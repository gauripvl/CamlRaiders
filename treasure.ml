open Sprite
open Utils


type type_treasure = {
  image : sprite
}

let source_treasures = ref ["pink"; "beige"; "orange"; "purple"]

let create_treasure (name) (enemy: Enemy.type_enemy) = 

  Some {
    image = {
      img = Some (create_image name);
      name = "treasure1";
      height = -1;
      width = -1;
      speed = 3; 
      x = enemy.image.x; 
      y = enemy.image.y + 5; 
    }
  }
let treasure_list = ref []

let filter_fun lst = 
  match !lst with 
  | [] -> failwith ""
  | _::t -> lst := t

let random_treasure (treasures_ref) (enemy_list: Enemy.type_enemy list) = 
  if ( List.length enemy_list = 0) then None else
    let probability = random_int (List.length enemy_list) in
    (* let probability = 0 in *)
    if (List.length !treasures_ref > 0) then (
      filter_fun treasures_ref;
      (create_treasure 
         (List.hd !treasures_ref) (List.nth enemy_list probability))
    ) else None

let remove_option treasure = 
  match treasure with 
  | Some t -> t
  | None -> failwith "No treasure match."

let add_treasure_to_list list_enemy = 
  let new_treasure_option = random_treasure source_treasures list_enemy in
  if new_treasure_option = None then
    treasure_list := !treasure_list else
    let new_treasure = remove_option new_treasure_option in
    set_image_dimensions new_treasure.image;
    treasure_list := new_treasure :: !treasure_list

let rec move_treasure = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_treasure t

let cleanup_treasure () = 
  treasure_list := List.filter (fun e -> e.image.y > 0) !treasure_list
