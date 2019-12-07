open Sprite
open Utils

type type_treasure = {
  image : sprite
}

let create_treasure (enemy: Enemy.type_enemy) = 
  print_endline "Treasure was created";
  Some {
    image = {
      img = Some (create_image "goldstar");
      name = "treasure1";
      height = -1;
      width = -1;
      speed = 3; 
      x = enemy.image.x; 
      y = enemy.image.y + 5; 
    }
  }

let treasure_list = ref []
(* let spawn_timer = ref 1.0 *)

let random_treasure (enemy_list: Enemy.type_enemy list) = 
  if ( List.length enemy_list = 0) then None else
    let probability = random_int (List.length enemy_list) in
    (* let probability = 0 in *)

    (create_treasure (List.nth enemy_list probability))


let remove_option treasure = 
  match treasure with 
  | Some t -> t
  | None -> failwith""


let add_treasure_to_list list_enemy = 
  let new_treasure_option = random_treasure list_enemy in
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
