open Objects
open Projectile
open Gui
open Sprite
open Stage

let rec game_loop () = 
  Unix.sleepf 0.05;

  spawn_enemy ();

  update_pos player.image;
  shoot_laser player.image;

  move_enemies !enemy_list;
  move_projectiles !lasers_list;

  Graphics.clear_graph ();

  draw player.image;
  draw_enemies !enemy_list;
  draw_list !lasers_list;

  cleanup_enemies (); 
  cleanup_lasers (); 

  print_st (string_of_float !spawn_timer);
  print_st ("number of enemies: " ^ string_of_int (List.length !enemy_list));

  game_loop ()

let main () = 
  open_game_window gui_window;
  draw player.image;
  player.image.img <- Some (create_image player.image.name);
  set_image_dimensions player.image;
  game_loop ()

let () = main ()
