open Objects
open Gui
open Sprite
open Stage 
open Background

(** [initialize_sprites] creates sprites given a list of sprites *)
let rec initialize_sprites = function 
  | [] -> ()
  | h::t ->
    h.img <- Some (create_image h.name);
    set_image_dimensions h;
    initialize_sprites t

(** [initialize_bg] creates the background  *)
let initialize_bg () = 
  add_bg "sky" ~x:0 ~spd:1 ~ref:background_props;
  add_bg "back_dunes" ~x:0 ~spd:2 ~ref:middleground_props;
  add_bg "fore_dunes" ~x:0 ~spd:3 ~ref:foreground_props

let init_lst = [player.image; Boss.boss_rbbinary.image;]

let main () = 
  open_game_window gui_window;
  initialize_sprites init_lst;
  initialize_bg ();
  loop_game ();
  Graphics.clear_graph (); 
  draw_game_over_screen ()

let () = main ()
