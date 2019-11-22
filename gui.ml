open Sprite
open Objects
open Projectile
open Utils

type t = sprite

let open_game_window w = 
  " " ^ (string_of_int w.width) ^ "x" ^ (string_of_int w.height)
  |> Graphics.open_graph; Graphics.set_window_title w.title

let get_speed t = t.speed

(* let draw t = Graphics.draw_image (Option.get t.img) t.x t.y *)
let draw t = 
  match t.img with 
  | None -> Graphics.draw_image (create_image t.name) t.x t.y 
  | Some img -> Graphics.draw_image img t.x t.y

let rec draw_list = function
  | [] -> () 
  | h::t -> draw h; draw_list t

let rec draw_enemies = function
  | [] -> () 
  | h::t -> draw h.image; draw_enemies t

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

let print_st str = 
  Graphics.moveto ((gui_window.height)/2) ((gui_window.width)/2);
  Graphics.draw_string str

(* let game_over () = 
   print_endline "Game over!"; 
   print_endline ("Your score: " ^ (string_of_int scoreboard.score)); 
   exit 0 *)

let quit_game () = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'q' -> exit 0
    | _ -> ()

let rec draw_game_over_screen () = 
  print_st ("Game over! Your score: " ^ (string_of_int scoreboard.score));
  quit_game ();
  draw_game_over_screen ()

let get_hearts () = 
  match player.lives with 
  | 1 -> "one_heart"
  | 2 -> "two_hearts"
  | 3 -> "three_hearts"
  | _ -> "one_heart"

let draw_scoreboard () =
  Graphics.draw_rect 
    (((gui_window.height)/10)-10) 
    (((gui_window.width)/10)-60) 
    150 90;

  Graphics.moveto ((gui_window.height)/10) ((gui_window.width)/10);
  Graphics.draw_string "SCORE BOARD";
  Graphics.lineto ((gui_window.height)/10) ((gui_window.width)/10);

  Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) - 16);
  Graphics.draw_string ("Lives Available:");
  Graphics.draw_image (create_image (get_hearts ())) 
    (((gui_window.height)/10) + 100) (((gui_window.width)/10) - 16);

  Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) - 32);
  (* Graphics.draw_string ("Invincibility: " ^ (string_of_bool player.invincible)); *)

  (* Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) - 48); *)
  Graphics.draw_string ("Score: " ^ (string_of_int scoreboard.score));

