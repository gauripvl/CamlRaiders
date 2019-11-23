open Sprite 
open Objects 
open Projectile 
open Utils 

let quit_game () = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'q' -> exit 0
    | _ -> ()

let update_pos t = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'w' -> t.y <- if t.y + t.speed >= (gui_window.height - 50) then (gui_window.height - 50) else t.y + t.speed
    | 'a' -> t.x <- if t.x - t.speed <= 0 then 0 else t.x - t.speed
    | 's' -> t.y <- if t.y - t.speed <= 0 then 0 else t.y - t.speed
    | 'd' -> t.x <- if t.x + t.speed >= (gui_window.width - 50) then (gui_window.width - 50) else t.x + t.speed
    (* | 'p' -> enemy_atks := (create_projectile "orb" 12 t) :: !enemy_atks *)
    | 'q' -> exit 0
    | _ -> ()

let laser_duration = ref 0.1

let add_laser_to_list t = 
  let new_laser = create_projectile "beam" 24 t in 
  set_image_dimensions new_laser;
  lasers_list := new_laser :: !lasers_list

let shoot_laser t = 
  if Graphics.button_down () then 
    timer add_laser_to_list t laser_duration 0.5
