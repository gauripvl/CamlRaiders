(* open Sprite *)
open Gui
open Objects
open Projectile

(* NOTE: player is defined in Objects and should not be used 
   as a variable *)

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

(* let cleanup () = 
   objects_list := List.filter (fun x -> x.y < gui_window.height) !objects_list *)

let set_bg col = 
  Graphics.set_color col; 
  Graphics.fill_rect 0 0 640 480

let rec game_loop camel = 
  Unix.sleepf 0.05;
  (* cleanup (); *)
  update_pos camel;
  (* do_launch_proj camel; *)
  (* move_projectiles !objects_list; *)
  Graphics.clear_graph ();
  set_bg 0x4797ff;
  draw camel;
  (* draw_proj !objects_list; *)
  game_loop camel

let main () = 
  open_game_window gui_window;
  set_bg 0x4797ff;
  draw player.image;
  game_loop player.image

let () = main ()