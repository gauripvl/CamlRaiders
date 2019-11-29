open Objects
open Gui
open Sprite
open Stage 

let main () = 
  open_game_window gui_window;
  preface ();
  draw player.image;
  player.image.img <- Some (create_image player.image.name);
  set_image_dimensions player.image;
  (* loop_game (); *)
  (* boss_dialogue (); *)
  Graphics.clear_graph (); 
  draw_game_over_screen ()

let () = main ()
