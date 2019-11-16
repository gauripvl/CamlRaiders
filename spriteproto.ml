open Objects
open Projectile
open Gui

let rec game_loop () = 
  Unix.sleepf 0.05;
  update_pos player.image;
  move_projectiles !lasers_list;
  Graphics.clear_graph ();
  draw player.image;
  draw_proj !lasers_list;
  game_loop ()

let main () = 
  open_game_window gui_window;
  draw player.image;
  draw enemy.image;
  player.image.img <- Some (create_image player.image.name);
  game_loop ()

let test () = 
  Graphics.open_graph " 640x480"

let () = main ()
