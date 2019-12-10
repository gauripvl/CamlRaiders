open Objects
open Gui
open Sprite
open Stage 

let rec initialize_sprites = function 
  | [] -> ()
  | h::t ->
    h.img <- Some (create_image h.name);
    set_image_dimensions h;
    initialize_sprites t

let init_lst = [
  player.image; 
  Boss.boss_rbbinary.image; 
  sprite_sky; sprite_foredunes; sprite_backdunes
]

let main () = 
  open_game_window gui_window;
  initialize_sprites init_lst;
  loop_game ();
  Graphics.clear_graph (); 
  draw_game_over_screen ()

let () = main ()
