open Objects
open Projectile
open Gui
open Enemy
open Collisions
open Commands 
open Utils

let enemy_atk_timer = ref 2.0

let start_game () = 
  print_st "Press z to start"

let loop_minion_stage () = 
  Unix.sleepf 0.05;

  spawn_enemy 8;
  timer create_enemy_atks !enemy_list enemy_atk_timer 2.0;

  update_pos player.image;
  shoot_laser player.image;

  player_laser_collision !lasers_list !enemy_list;
  cleanup_enemies (); 
  check_invincibility ();
  collision_with !enemy_list;

  move_enemies !enemy_list;
  move_projectiles !lasers_list;
  move_projectiles !enemy_atks;

  Graphics.clear_graph ();

  cleanup_projectiles ();
  remove_enemies ();

  draw_enemies !enemy_list;
  draw_enemy_hp !enemy_list;
  draw player.image;
  draw_projectiles !lasers_list;
  draw_projectiles !enemy_atks;

  draw_scoreboard ()

let rec boss_dialogue () = 
  Unix.sleepf 0.05;

  update_pos player.image;
  Graphics.clear_graph ();

  draw_scoreboard ();
  draw_dialogue_box ();
  draw player.image;

  boss_dialogue ()

let rec loop_game () = 
  if (player.lives > 0) then (loop_minion_stage (); loop_game ())
