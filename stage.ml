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

(** [start_game] prints instructions for starting the game *)
let start_game () = 
  print_st "Press z to start"

(** [move_minion_stage] moves the enemies, projectiles, and sprites *)
let move_minion_stage () = 
  move_enemies !enemy_list;
  move_projectiles !lasers_list;
  move_projectiles !enemy_atks;
  move_sprites !Treasure.treasure_list;
  move_sprites !Treasure.power_list

(** [collision_minion_stages] checks for any sort of collision in the game *)
let collision_minion_stage () = 
  player_laser_collision !lasers_list !enemy_list;
  collision_with_enemy_proj !enemy_atks;
  collision_with_enemies !enemy_list;
  treasure_collision !Treasure.treasure_list;
  powerup_collision !Treasure.power_list;
  check_invincibility ()

(** [cleanup_minion_stage] removes any object that has disappeared from the
    screen from the game *)
let cleanup_minion_stage () = 
  Treasure.cleanup_powerup ();
  remove_projs enemy_atks player.image;
  remove_lasers lasers_list !enemy_list;
  remove_enemies (); 
  cleanup_projectiles ();
  cleanup_enemies ()

(** [draw_minion_stage] draws all of the components of the game *)
let draw_minion_stage () =
  Graphics.clear_graph ();
  draw_background ();
  draw_enemies !enemy_list;
  draw_enemy_hp !enemy_list;
  draw player.image;
  draw_projectiles !lasers_list;
  draw_projectiles !enemy_atks;
  draw_list !Treasure.treasure_list;
  draw_list !Treasure.power_list;
  draw_scoreboard ()

let loop_minion_stage () = 
  Unix.sleepf 0.05;

  quit_game ();
  spawn_enemy 8;
  timer create_enemy_atks !enemy_list enemy_atk_timer 2.0;

  update_pos player.image;
  shoot_laser player.image;

  collision_minion_stage ();
  cleanup_minion_stage ();
  move_minion_stage ();
  draw_minion_stage ()

(** [move_boss_stage] moves all of the objects on the screen in the boss
    stage *)
let move_boss_stage boss = 
  move_boss boss;
  move_projectiles !lasers_list;
  move_projectiles !binary_red_atks;
  move_projectiles !binary_black_atks

(** [collision_boss_stage] checks for collisions between any objects in the
    boss stage *)
let collision_boss_stage boss = 
  collision_with_boss boss;
  collision_with_player_laser boss !lasers_list;
  collision_with_enemy_proj !binary_red_atks;
  collision_with_enemy_proj !binary_black_atks;
  collision_with_enemies !enemy_list;
  check_invincibility ()

(** [cleanup_boss_stage] removes any object that has disappeared from the
    screen from the game in the boss stage *)
let cleanup_boss_stage boss = 
  remove_projs lasers_list boss.image;
  remove_projs binary_red_atks player.image;
  remove_projs binary_black_atks player.image;
  cleanup_projectiles ();
  cleanup_enemies ()

(** [draw_boss_stages] draws all of the components of the game in the boss
    stage *)
let draw_boss_stage boss = 
  Graphics.clear_graph ();
  draw_background ();
  draw player.image;
  draw boss.image;
  draw_boss_hp boss;
  draw_projectiles !binary_red_atks;
  draw_projectiles !binary_black_atks;
  draw_projectiles !lasers_list;
  draw_scoreboard ()

(* 'red-black binary' boss  (original idea =D ) *)
let boss_stage boss = 
  Unix.sleepf 0.05;

  quit_game ();
  update_pos player.image;
  shoot_laser player.image;

  timer create_boss_atk boss_rbbinary boss_attack_timer boss.attack_freq;

  move_boss_stage boss;
  collision_boss_stage boss;
  cleanup_boss_stage boss;
  draw_boss_stage boss

(** [won_game] prints win message when game is defeated *)
let won_game () = 
  Graphics.clear_graph ();
  print_st ("Congratulations, You have won! Your score: " ^ 
            (string_of_int scoreboard.score));
  quit_game ()

let script_boss = scripts_of "boss"

let rec loop_game () = 
  if (player.lives > 0) then (
    if (List.length !Treasure.collected_treasures < 4) then 
      loop_minion_stage () 
    else ( 
      if !is_dialogue_active then (
        Graphics.clear_graph();
        draw_script script_boss;
      ) else (
        if boss_rbbinary.health > 0 then boss_stage boss_rbbinary
        else won_game ()
      ));
    loop_game ()
  )
