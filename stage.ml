open Objects
open Projectile
open Gui
open Enemy
open Collisions
open Commands 

let start_game () = 
  print_st "Press z to start"

let loop_minion_stage () = 
  Unix.sleepf 0.05;

  spawn_enemy ();

  update_pos player.image;
  shoot_laser player.image;

  player_laser_collision !lasers_list !enemy_list;
  cleanup_enemies (); 
  check_invincibility ();
  collision_with !enemy_list;
  (* update_player_status (); *)

  move_enemies !enemy_list;
  move_projectiles !lasers_list;

  Graphics.clear_graph ();

  cleanup_lasers (); 
  remove_enemies ();

  draw player.image;
  draw_enemies !enemy_list;
  draw_list !lasers_list;

  draw_scoreboard ()

let rec loop_game () = 
  if (player.lives > 0) then (loop_minion_stage (); loop_game ())
