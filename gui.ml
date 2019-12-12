open Sprite
open Objects 
open Commands
open Projectile
open Enemy
open Background

type t = sprite

let open_game_window (w: type_gui) = 
  " " ^ (string_of_int w.width) ^ "x" ^ (string_of_int w.height)
  |> Graphics.open_graph; Graphics.set_window_title w.title

let get_speed t = t.speed

let draw t = 
  match t.img with 
  | None -> Graphics.draw_image (create_image t.name) t.x t.y 
  | Some img -> Graphics.draw_image img t.x t.y

let rec draw_list = function
  | [] -> () 
  | h::t -> draw h; draw_list t

let rec draw_projectiles (lst: type_projectile list) = 
  match lst with 
  | [] -> () 
  | h::t -> draw h.image; draw_projectiles t

let rec draw_enemies (lst: type_enemy list) = 
  match lst with 
  | [] -> () 
  | h::t -> draw h.image; draw_enemies t

let rec draw_enemy_hp = function 
  | [] -> ()
  | e::t -> 
    Graphics.moveto (e.image.x + e.image.width / 4) (e.image.y - 12);
    Graphics.draw_string ("HP: " ^ (string_of_int e.health));
    draw_enemy_hp t

let draw_boss_hp (boss:Boss.type_boss) = 
  Graphics.moveto (boss.image.x + boss.image.width / 4) (boss.image.y - 12);
  Graphics.draw_string ("BOSS HP: " ^ (string_of_int boss.health))

let draw_background () = 
  manage_parallax "sky" ~spd:1 ~ref:background_props !background_props;
  manage_parallax "back_dunes" ~spd:2 ~ref:middleground_props !middleground_props;
  manage_parallax "fore_dunes" ~spd:3 ~ref:foreground_props !foreground_props;

  draw_list !background_props;
  draw_list !middleground_props;
  draw_list !foreground_props;

  let bg_lst = [foreground_props; middleground_props; background_props;] in 
  cleanup_bg bg_lst

let print_st str = 
  Graphics.moveto ((gui_window.width)/5) ((gui_window.height)/2);
  Graphics.draw_string str

(** [get_hearts] returns how many hearts should be displayed based on the
    number of player lives *)
let get_hearts () = 
  match player.lives with 
  | 1 -> "one_heart"
  | 2 -> "two_hearts"
  | 3 -> "three_hearts"
  | _ -> "one_heart"

let draw_scoreboard () =
  Graphics.draw_rect 10 10 scoreboard.width scoreboard.height;

  let x_pos = 20 in 
  let y_pos = scoreboard.height - 10 in (
    Graphics.moveto x_pos y_pos;
    Graphics.draw_string "SCORE BOARD";
    Graphics.lineto x_pos y_pos;

    Graphics.moveto x_pos (y_pos - 16);
    Graphics.draw_string ("Lives Available:");
    Graphics.draw_image (create_image (get_hearts ())) 
      (x_pos + 100) (y_pos - 16);

    Graphics.moveto x_pos (y_pos - 32);
    Graphics.draw_string 
      ("Invincibility: " ^ (string_of_bool player.invincible));

    Graphics.moveto x_pos (y_pos - 48);
    Graphics.draw_string ("Score: " ^ (string_of_int scoreboard.score));

    Graphics.moveto x_pos (y_pos - 64);
    Graphics.draw_string ("Inventory: " ^ (string_of_int (List.length !Treasure.collected_treasures)))
  )

let rec draw_game_over_screen () = 
  print_st ("Game over! Your score: " ^ (string_of_int scoreboard.score));
  quit_game ();
  draw_game_over_screen ()

(** [draw_typewriter] draws the dialogue one letter at a time *)
let rec draw_typewriter = function 
  |[] -> ()
  |h::t -> 
    Unix.sleepf 0.05;
    Graphics.draw_char h; 
    draw_typewriter t

let draw_dialogue_container speaker txt = 
  Graphics.draw_rect 
    (scoreboard.width + 20) 10 
    (gui_window.width - scoreboard.width-30) scoreboard.height;

  Graphics.fill_rect (scoreboard.width + 20) 10 
    scoreboard.height scoreboard.height;

  Graphics.moveto 
    (scoreboard.width + scoreboard.height + 40) 
    (scoreboard.height - 10);
  Graphics.draw_string speaker;
  Graphics.lineto 
    (scoreboard.width + scoreboard.height + 40) 
    (scoreboard.height - 10);

  Graphics.moveto 
    (scoreboard.width + scoreboard.height + 40) 
    (scoreboard.height - 40);
  draw_typewriter txt

let draw_static () = 
  Graphics.clear_graph (); 
  quit_game();
  draw_background ();
  draw_scoreboard ();
  draw player.image
