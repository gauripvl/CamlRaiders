open Objects
open Projectile
open Gui
open Sprite


let print_st str = 
  Graphics.moveto ((gui_window.height)/2) ((gui_window.width)/2);
  Graphics.draw_string str

let rec game_loop () = 
  Unix.sleepf 0.05;
  update_pos player.image;
  move_projectiles !lasers_list;
  Graphics.clear_graph ();
  draw player.image;
  draw_list !lasers_list;
  print_st "you lost";
  game_loop ()


let main () = 
  open_game_window gui_window;
  draw player.image;
  player.image.img <- Some (create_image player.image.name);
  game_loop ()

let test () = 
  Graphics.open_graph " 640x480"

let () = main ()
