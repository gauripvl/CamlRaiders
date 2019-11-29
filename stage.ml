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

(* ============== DIALOGUE CODE (begin) ============== *)
let texts = ["Because people don't have wings, we look for other ways to fly. 
             - Ukai";
             "There are some flowers you only see when you take detours. 
             - Tanaka";
             "Haikyuu!! best show ~*";
             "Add more text here =D";
            ]

(* TODO - handle special characters *)
let string_to_list str = 
  (* let character = String.get str in 
     match character with 
     | '\'' -> List.init (String.length str) "'"
     | _ -> List.init (String.length str) character *)
  List.init (String.length str) (String.get str)

let rec print_typewriter_dialogue acc = function 
  | [] -> ()
  | h::t -> Unix.sleepf 0.04;
    let current_str = acc ^ Char.escaped h in 
    print_st current_str; 
    print_typewriter_dialogue current_str t

let print_current_dialogue txt = 
  txt |> string_to_list |> print_typewriter_dialogue ""

let is_dialogue_active = ref true 


(* TODO - fix the brief delay after pressing 'z' *)
let rec print_next_dialogue = function 
  | [] -> is_dialogue_active := false
  | h::t -> 
    print_current_dialogue h;
    if Graphics.key_pressed () then 
      match Graphics.read_key () with 
      | 'z' -> Graphics.clear_graph (); print_next_dialogue t
      | _ -> () 
    else print_next_dialogue (h::t)

let rec preface () = 
  if !is_dialogue_active then print_next_dialogue texts;
  preface ()

(* ============== DIALOGUE CODE (end) ============== *)

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
