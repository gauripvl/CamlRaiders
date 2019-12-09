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

(* let update_pos t = 
   if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'w' -> t.y <- if t.y + t.speed >= (gui_window.height - 50) then (gui_window.height - 50) else t.y + t.speed
    | 'a' -> t.x <- if t.x - t.speed <= 0 then 0 else t.x - t.speed
    | 's' -> t.y <- if t.y - t.speed <= 0 then 0 else t.y - t.speed
    | 'd' -> t.x <- if t.x + t.speed >= (gui_window.width - 50) then (gui_window.width - 50) else t.x + t.speed
    | 'q' -> exit 0
    | _ -> () *)

let laser_duration = ref 0.1

(** [add_laser_to_list t] adds a beam laser to the list of lasers *)
let add_laser_to_list t = 
  let new_laser = create_projectile "beam" 24 t (0.0, 0.0) in 
  set_image_dimensions new_laser.image;
  lasers_list := new_laser :: !lasers_list

let shoot_laser t = 
  if Graphics.button_down () then 
    timer add_laser_to_list t laser_duration 0.5
