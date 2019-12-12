open Sprite
open Utils
(* [source_treasures] is the list of names of all possible treasures .*)
let source_treasures = ref ["coin"; "lily"; "crown"; "diamond"]

(* [power_ups] is the list of names of all possible  *)
let power_ups = ref ["one_heart"]

(* [create_treasure [name] [origin]] creates a new treasure with name [name]
   and position .*)
let create_treasure name (origin: Enemy.type_enemy) = 
  create_sprite name ~x:origin.image.x ~y:(origin.image.y + 5) ~spd:~-3

(* [treasure_list] is the empty *)
let treasure_list = ref []
let collected_treasures = ref []
let power_list = ref []

(*[filter_fun [lst] [ene_lst] [prob]] is the [lst] without its first element 
  and creates a new treasure using the head of the [lst] and [ene_lst] and [prob]*)
let filter_fun lst ene_lst prob = 
  match !lst with 
  | [] -> failwith "Empty treasure list."
  | h::_ -> create_treasure h (List.nth ene_lst prob)

(* [random_treasure [treasures_ref] [enemy_list]] creates a random treasure using 
   the ref list of treasures [treasure_ref] and [enemy_list]  *)
let random_treasure (treasures_ref) (enemy_list: Enemy.type_enemy list) = 
  if (List.length enemy_list = 0) then None else
    let probability = random_int (List.length enemy_list) in
    if (List.length !treasures_ref > 0) then (
      Some (filter_fun treasures_ref enemy_list probability)
    ) else None

(* [random_powerup [power_lst] [enemy_list]] creates a random powerup using 
   the ref list of powerups [power_lst] and [enemy_list] *)
let random_powerup (power_lst) (enemy_list: Enemy.type_enemy list) = 
  if (List.length enemy_list = 0) then None else
    let probability_e = random_int (List.length enemy_list) in
    (* let probability_p = random_int (0) in *)
    Some (create_treasure (
        List.nth !power_lst 0) (List.nth enemy_list probability_e))

(* [remove_option [treasure]] is the treasure with its option.*)
let remove_option treasure = 
  match treasure with 
  | Some t -> t
  | None -> failwith "No treasure match."

(* [add_treasure_to [list_enemy]] is the updated [treasure_list] with a new treasure*)
let add_treasure_to_list list_enemy = 
  let new_treasure_option = random_treasure source_treasures list_enemy in
  if new_treasure_option = None then
    treasure_list := !treasure_list 
  else
    let new_treasure = remove_option new_treasure_option in
    set_image_dimensions new_treasure;
    treasure_list := new_treasure :: !treasure_list

(* [add_powerups_to_list [power_up]] is the updated [power_list] with a new power_up*)
let add_powerups_to_list power_up =  
  if power_up = None then 
    power_list := !power_list 
  else
    let new_power_up = remove_option power_up in
    set_image_dimensions new_power_up;
    power_list := new_power_up :: !power_list

(* [cleanup_power ()] deletes the power_up once it moves out of the sc*)
let cleanup_powerup () = 
  power_list := List.filter (fun e -> e.y > 0) !power_list
