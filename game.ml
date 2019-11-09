open Sprite
open Gui
open Objects
open Projectile

(* NOTE: player is defined in Objects and should not be used 
   as a variable *)

(* ============= lasers ============= *)
(* unused *)
let objects_list = ref []

let do_launch_proj t = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | ' ' -> objects_list := (create_projectile t) :: !objects_list
    | 'q' -> exit 0
    | _ -> () 

let rec draw_proj = function
  | [] -> () 
  | h::t -> draw h; draw_proj t

let cleanup () = 
  objects_list := List.filter (fun x -> x.y < gui_window.height) !objects_list
(* ============= lasers (end) ============= *)

let get_height s = 
  s.img |> create_image |> Graphics.dump_image |> Array.length 

let get_width s = 
  let temp = s.img |> create_image |> Graphics.dump_image in 
  Array.get temp 1 |> Array.length 

let collision_test (s: sprite) (e: sprite) = 
  (s.x + get_width s > e.x && s.x < e.x + get_width e) &&
  (s.y + get_height s > e.y && s.y < e.y + get_height e)

let set_bg col = 
  Graphics.set_color col; 
  Graphics.fill_rect 0 0 640 480

let collision (e: sprite) = 
  if (collision_test player.image e) 
  then set_bg 0xff792b 
  else set_bg 0x4797ff
(* if player.lives > 0 then player.lives <- player.lives - 1 else exit 0 *)


(* ============== move list of enemies (end) ============= *)
(* unused *)
let enemies_list = ref []

let rec draw_enemies = function
  | [] -> () 
  | h::t -> draw h; draw_enemies t

let rec move_enemies = function
  | [] -> () 
  | h::t -> h.y <- h.y - h.speed; move_enemies t

let cleanup_enemies () = 
  enemies_list := List.filter (fun x -> x.y > gui_window.height) !enemies_list
(* ============== move list of enemies (end) ============= *)

let move_enemy e = 
  e.image.y <- e.image.y - e.image.speed

let rec game_loop camel p e = 
  Unix.sleepf 0.05;
  (* cleanup (); *)
  update_pos camel;
  (* move_enemy enemy; *)
  (* do_launch_proj camel; *)
  (* move_projectiles !objects_list; *)
  Graphics.clear_graph ();
  (* set_bg 0x4797ff; *)
  collision enemy.image;
  Graphics.draw_image p camel.x camel.y;
  Graphics.draw_image e enemy.image.x enemy.image.y;
  (* draw enemy.image;
     draw camel; *)
  (* draw_proj !objects_list; *)
  game_loop camel p e

let main () = 
  open_game_window gui_window;
  set_bg 0x4797ff;
  draw player.image;
  draw enemy.image;
  let img_player = create_image player.image.img in 
  let img_enemy = create_image enemy.image.img in 
  game_loop player.image img_player img_enemy

let () = main ()