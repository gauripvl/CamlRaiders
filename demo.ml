open Objects
open Gui
open Sprite
open Stage 

let main () = 
  open_game_window gui_window;
  draw player.image;
  player.image.img <- Some (create_image player.image.name);
  Boss.boss_rbbinary.image.img <- Some (
      create_image Boss.boss_rbbinary.image.name);
  set_image_dimensions player.image;
  set_image_dimensions Boss.boss_rbbinary.image; 
  loop_game ();
  (* boss_dialogue (); *)
  Graphics.clear_graph (); 
  draw_game_over_screen ()

let () = main ()
