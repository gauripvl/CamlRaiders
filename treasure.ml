open Sprite
open Utils

type type_treasure = {
  image : sprite
}

let source_treasures = ref ["pink"; "beige"; "orange"; "purple"]

let power_ups = ref ["one_heart"]

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
let power_list = ref []

let filter_fun lst ene_lst prob = 
  match !lst with 
  | [] -> failwith "Empty treasure list."
  | h::t -> lst := t; create_treasure h (List.nth ene_lst prob)

let random_treasure (treasures_ref) (enemy_list: Enemy.type_enemy list) = 
  if ( List.length enemy_list = 0) then None else
    let probability = random_int (List.length enemy_list) in
    if (List.length !treasures_ref > 0) then (
      filter_fun treasures_ref enemy_list probability
    ) else None

let random_powerup (power_lst) (enemy_list: Enemy.type_enemy list) = 
  if (List.length enemy_list = 0) then None else
    let probability_e = random_int (List.length enemy_list) in
    (* let probability_p = random_int (0) in *)
    create_treasure (List.nth !power_lst 0) (List.nth enemy_list probability_e)

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

let add_powerups_to_list power_up = 
  (* let new_power_option = random_powerup power_ups list_enemy in  *)
  if power_up = None then
    treasure_list := !treasure_list else
    let new_power_up = remove_option power_up in
    set_image_dimensions new_power_up.image;
    power_list := new_power_up :: !power_list

let rec move_treasure = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_treasure t

let cleanup_powerup () = 
  power_list := List.filter (fun e -> e.image.y > 0) !power_list
