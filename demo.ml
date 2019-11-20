open Objects
open Projectile
open Gui
open Sprite
open Stage
open Collisions

let make_score_board (player: type_player) =
  Graphics.draw_rect (((gui_window.height)/10)-10) (((gui_window.width)/10)-60) 150 90;
  Graphics.moveto ((gui_window.height)/10) ((gui_window.width)/10);
  Graphics.draw_string "SCORE BOARD";
  Graphics.lineto ((gui_window.height)/10) ((gui_window.width)/10);
  Graphics.moveto ((gui_window.height)/10) (((gui_window.width)/10) -13);
  Graphics.draw_string ("Lives Available:");
  if player.lives = 3 then
    Graphics.draw_image (create_image "one_heart") (((gui_window.height)/10) + 100) (((gui_window.width)/10) -13)
  else
  if player.lives = 2 then
    Graphics.draw_image (create_image "two_hearts") (((gui_window.height)/10) + 100) (((gui_window.width)/10) -13)
  else
    Graphics.draw_image(create_image "thee_hearts") (((gui_window.height)/10) + 100) (((gui_window.width)/10) -13)

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
  make_score_board player;

  (* print_st (string_of_float !spawn_timer); *)
  (* print_st ("number of enemies: " ^ string_of_int (List.length !enemy_list)); *)

  game_loop ()

let main () = 
  open_game_window gui_window;
  draw player.image;
  player.image.img <- Some (create_image player.image.name);
  set_image_dimensions player.image;
  game_loop ()

let () = main ()
