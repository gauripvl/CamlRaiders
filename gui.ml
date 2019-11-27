open Sprite
open Objects 
open Commands
open Projectile
open Enemy


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

let rec draw_projectiles (lst: type_projectile list) = 
  match lst with 
  | [] -> () 
  | h::t -> draw h.image; draw_projectiles t

let rec draw_enemies (lst: type_enemy list) = 
  match lst with 
  | [] -> () 
  | h::t -> draw h.image; draw_enemies t

let rec draw_enemy_hp = function 
  | [] -> ()
  | e::t -> 
    Graphics.moveto (e.image.x + e.image.width / 4) (e.image.y - 12);
    Graphics.draw_string ("HP: " ^ (string_of_int e.health));
    draw_enemy_hp t

let print_st str = 
  Graphics.moveto ((gui_window.height)/2) ((gui_window.width)/2);
  Graphics.draw_string str

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
    200 90;

  Graphics.moveto ((gui_window.height)/10) ((gui_window.width)/10);
  Graphics.draw_string "SCORE BOARD";
  Graphics.lineto ((gui_window.height)/10) ((gui_window.width)/10);

  Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) - 16);
  Graphics.draw_string ("Lives Available:");
  Graphics.draw_image (create_image (get_hearts ())) 
    (((gui_window.height)/10) + 100) (((gui_window.width)/10) - 16);

  Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) - 32);
  Graphics.draw_string ("Invincibility: " ^ (string_of_bool player.invincible));

  Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) - 48);
  Graphics.draw_string ("Score: " ^ (string_of_int scoreboard.score));

