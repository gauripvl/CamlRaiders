open Objects
open Gui
open Sprite
open Stage 

let initialize_sprites () = 
  player.image.img <- Some (create_image player.image.name);
  set_image_dimensions player.image;

  Boss.boss_rbbinary.image.img <- Some (
      create_image Boss.boss_rbbinary.image.name);
  set_image_dimensions Boss.boss_rbbinary.image

let main () = 
  open_game_window gui_window;
  initialize_sprites ();
  loop_game ();
  Graphics.clear_graph (); 
  draw_game_over_screen ()

let () = main ()
