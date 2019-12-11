open Sprite
open Utils

let source_treasures = ref ["pink"; "beige"; "orange"; "purple"]

let power_ups = ref ["one_heart"]

let create_treasure name (origin: Enemy.type_enemy) = 
  create_sprite name ~x:origin.image.x ~y:(origin.image.y + 5) ~spd:~-3

let treasure_list = ref []
let collected_treasures = ref []
let power_list = ref []

let filter_fun lst ene_lst prob = 
  match !lst with 
  | [] -> failwith "Empty treasure list."
  | h::t -> lst := t; create_treasure h (List.nth ene_lst prob)

let random_treasure (treasures_ref) (enemy_list: Enemy.type_enemy list) = 
  if (List.length enemy_list = 0) then None else
    let probability = random_int (List.length enemy_list) in
    if (List.length !treasures_ref > 0) then (
      Some (filter_fun treasures_ref enemy_list probability)
    ) else None

let random_powerup (power_lst) (enemy_list: Enemy.type_enemy list) = 
  if (List.length enemy_list = 0) then None else
    let probability_e = random_int (List.length enemy_list) in
    (* let probability_p = random_int (0) in *)
    Some (create_treasure (
        List.nth !power_lst 0) (List.nth enemy_list probability_e))

let remove_option treasure = 
  match treasure with 
  | Some t -> t
  | None -> failwith "No treasure match."

let add_treasure_to_list list_enemy = 
  let new_treasure_option = random_treasure source_treasures list_enemy in
  if new_treasure_option = None then
    treasure_list := !treasure_list 
  else
    let new_treasure = remove_option new_treasure_option in
    set_image_dimensions new_treasure;
    treasure_list := new_treasure :: !treasure_list

let add_powerups_to_list power_up =  
  if power_up = None then 
    treasure_list := !treasure_list 
  else
    let new_power_up = remove_option power_up in
    set_image_dimensions new_power_up;
    power_list := new_power_up :: !power_list

let cleanup_powerup () = 
  power_list := List.filter (fun e -> e.y > 0) !power_list
