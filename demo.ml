open Objects
open Projectile
open Gui
open Sprite
open Stage
open Collisions

let rec game_loop () = 
  Unix.sleepf 0.05;

  spawn_enemy ();

  update_pos player.image;
  shoot_laser player.image;

  player_laser_collision !lasers_list !enemy_list;
  cleanup_enemies (); 

  move_enemies !enemy_list;
  move_projectiles !lasers_list;

  Graphics.clear_graph ();

  cleanup_lasers (); 
  remove_enemies ();

  draw player.image;
  draw_enemies !enemy_list;
  draw_list !lasers_list;

  (* print_st (string_of_float !spawn_timer); *)
  (* print_st ("number of enemies: " ^ string_of_int (List.length !enemy_list)); *)
  draw_scoreboard ();

  game_loop ()

let main () = 
  open_game_window gui_window;
  draw player.image;
  player.image.img <- Some (create_image player.image.name);
  set_image_dimensions player.image;
  game_loop ()

let () = main ()
