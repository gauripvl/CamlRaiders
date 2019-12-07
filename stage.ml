(* open Sprite  *)
open Objects
open Projectile
open Gui
open Enemy
open Collisions
open Commands 
open Utils
open Dialogue 
open Boss
(* open Boss *)

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


(* ============== DIALOGUE CODE V2 (begin) ============== *)
let dlg_json = Yojson.Basic.from_file "dialogues.json"
let dlgs = to_json dlg_json
let scripts_boss = get_scripts dlgs "boss"

let is_dialogue_active = ref true 
let end_of_speech = ref false 

let string_to_list str = 
  List.init (String.length str) (String.get str)

let draw_static () = 
  quit_game();
  draw_scoreboard ();
  draw player.image

(* draws speaker and text *)
let rec show_current_dialogue speaker = function 
  | [] -> 
    print_endline "show_current_dialogue []"; end_of_speech := true 
  | h::t -> 
    print_endline "show_current_dialogue ht";
    let char_lst = string_to_list h in 
    draw_dialogue_container speaker char_lst;
    if Graphics.key_pressed () then 
      match Graphics.read_key () with 
      | 'z' -> 
        Graphics.clear_graph (); 
        draw_static (); 
        show_current_dialogue speaker t
      | _ -> () 

let rec show_next_dialogue = function 
  | [] -> 
    print_endline "show_next_dialogue []"; is_dialogue_active := false
  | h::t -> 
    print_endline "show_next_dialogue ht";
    if not !end_of_speech then (
      let speaker = get_speaker h in 
      let texts = get_texts h in 
      show_current_dialogue speaker texts;
    ) else (
      if Graphics.key_pressed () then 
        match Graphics.read_key () with 
        | 'z' -> 
          Graphics.clear_graph (); 
          draw_static ();
          end_of_speech := false;
          print_endline "SUCCESS! :D";
          show_next_dialogue t
        | _ -> () 
    )
(* if !end_of_speech then (
   if Graphics.key_pressed () then (
    match Graphics.read_key () with 
    | 'z' -> 
      Graphics.clear_graph (); 
      draw_static ();
      end_of_speech := false;
      show_next_dialogue t
    | _ -> () ))
   else show_next_dialogue (h::t) *)

(* buggy code - do not use *)
let rec boss_dialogue () = 
  Unix.sleepf 0.05;
  draw_static ();
  print_endline "boss_dialogue before diag";
  if !is_dialogue_active then show_next_dialogue scripts_boss;
  print_endline "boss_dialogue outside diag";
  boss_dialogue ()

(* ============== DIALOGUE CODE V2 (end) ============== *)

(* ============== BOSS CODE (begin) ============== *)

(* 'red-black binary' boss  (original idea =D ) *)
let boss_stage boss = 
  Unix.sleepf 0.05;
  Graphics.clear_graph ();

  draw boss.image;
  update_pos player.image;
  shoot_laser player.image;

  timer create_boss_atk boss_rbbinary boss_attack_timer boss.attack_freq;

  draw player.image;
  draw_projectiles !binary_red_atks;
  draw_projectiles !binary_black_atks;
  draw_projectiles !lasers_list;

  move_projectiles !binary_red_atks;
  move_projectiles !binary_black_atks;

  cleanup_projectiles ();

  cleanup_enemies (); 
  check_invincibility ();
  collision_with !enemy_list;

  print_st "You've entered a BOSS BATTLE"

(* ============== BOSS CODE (end) ============== *)

let rec loop_game () = 
  if (player.lives > 0) then 
    (
      (* if (scoreboard.score < 42) then loop_minion_stage () 
         else  *)
      boss_stage boss_rbbinary;

      loop_game ()
    )
