open Sprite
open Objects
open Projectile
open Gui
open Enemy
open Collisions
open Commands 
open Utils
open Dialogue 
open Boss

let enemy_atk_timer = ref 2.0

let start_game () = 
  print_st "Press z to start"

let loop_minion_stage () = 
  Unix.sleepf 0.05;

  quit_game ();
  spawn_enemy 8;
  timer create_enemy_atks !enemy_list enemy_atk_timer 2.0;

  update_pos player.image;
  shoot_laser player.image;

  player_laser_collision !lasers_list !enemy_list;
  player_hit !enemy_atks;
  cleanup_enemies (); 
  treasure_collision !Treasure.treasure_list;
  Treasure.cleanup_powerup ();
  check_invincibility ();
  collision_with !enemy_list;

  move_enemies !enemy_list;
  move_projectiles !lasers_list;
  move_projectiles !enemy_atks;
  move_sprites !Treasure.treasure_list;
  move_sprites !Treasure.power_list;

  Graphics.clear_graph ();

  cleanup_projectiles ();
  remove_enemies ();

  draw_background ();
  draw_enemies !enemy_list;
  draw_enemy_hp !enemy_list;
  draw player.image;
  draw_projectiles !lasers_list;
  draw_projectiles !enemy_atks;
  draw_list !Treasure.treasure_list;
  draw_list !Treasure.power_list;

  draw_scoreboard ()

(* 'red-black binary' boss  (original idea =D ) *)
let boss_stage boss = 
  Unix.sleepf 0.05;

  quit_game ();
  update_pos player.image;
  shoot_laser player.image;

  timer create_boss_atk boss_rbbinary boss_attack_timer boss.attack_freq;

  (* move_boss boss; *)
  move_projectiles !lasers_list;
  move_projectiles !binary_red_atks;
  move_projectiles !binary_black_atks;

  cleanup_projectiles ();
  cleanup_enemies (); 
  check_invincibility ();
  collision_with !enemy_list;

  Graphics.clear_graph ();

  draw player.image;
  draw boss.image;
  draw_projectiles !binary_red_atks;
  draw_projectiles !binary_black_atks;
  draw_projectiles !lasers_list;

  draw_scoreboard ()

let script_boss = scripts_of "boss"

let rec loop_game () = 
  if (player.lives > 0) then (
    if (scoreboard.score < 999) then loop_minion_stage () 
    else ( 
      if !is_dialogue_active then (
        Graphics.clear_graph();
        draw_script script_boss;
      ) else boss_stage boss_rbbinary
    );
    loop_game ()
  )
