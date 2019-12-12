open Sprite 
open Objects 
open Projectile 
open Utils 

let press_any_key_to f = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | _ -> f ()

let quit_game () = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'q' -> exit 0
    | _ -> ()

let update_pos (t:sprite) = 
  let mouse_x, mouse_y = Graphics.mouse_pos () in 
  if is_btn 0 gui_window.width mouse_x then t.x <- mouse_x - (t.width / 2);
  if is_btn 0 gui_window.height mouse_y then t.y <- mouse_y - (t.height / 2)

let laser_duration = ref 0.1

(** [add_lasers origin lst] adds a laser for each vector in [lst] 
    to [lasers_list]. *)
let rec add_lasers origin = function 
  | [] -> ()
  | h::t ->
    let new_laser = create_projectile "beam" 24 origin h in 
    set_image_dimensions new_laser.image;
    lasers_list := new_laser :: !lasers_list;
    add_lasers origin t

(** [make_laser origin] adds lasers to [lasers_list] according to 
    the player's powerup. *)
let make_laser origin = 
  match player.powerup with 
  | Neutral -> add_lasers origin [(1.,0.)]
  | TripleLasers -> add_lasers origin [(1.,0.); (1.,0.25); (1.,-0.25)]

let shoot_laser origin = 
  if Graphics.button_down () then 
    timer make_laser origin laser_duration 0.5
