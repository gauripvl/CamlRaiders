open Gui
open Objects
open Unix

let player_sprite = init_player.image

let rec game_loop () = 
  sleepf 0.05;
  update_pos init_player.image;
  Graphics.clear_graph ();
  draw init_player.image;
  game_loop ()

let main () = 
  Graphics.open_graph " 640x480";
  game_loop ()

let test_gui () = 
  Graphics.open_graph " 640x480";
  sleepf 3.0;
  Graphics.close_graph ()

let () = main ()