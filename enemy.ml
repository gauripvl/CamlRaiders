open Objects
open Sprite
open Utils

type type_attack = 
  | Passive 
  | Bullet
  | Missile 
  | Diamond 
  | Cross 
  | Star

type type_movement = 
  | Straight 
  | Curved
  | Snake

type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable attack: type_attack;
  movement: type_movement;
  v_spd: int;
}

(** [create_enemy n h a] creates an enemy with image name [n], 
    health of [hp], and an attack type of [atk]. *)
let create_enemy name ~hp:hp ~atk:atk ~spd:spd ~move:dir = {
  image = {
    img = Some (create_image name);
    name = name;
    height = -1;
    width = -1;
    speed = spd; 
    x = gui_window.width - 100; 
    y = random_int gui_window.height + 100; 
  };
  health = hp;
  attack = atk;
  movement = dir;
  v_spd = spd;
}

let enemy_list = ref []

let spawn_timer = ref 1.0

(** [random_enemy ()] is an enemy with a randomly set attack type. *)
let random_enemy () = 
  let probability = random_int 100 in 
  if (probability < 15) then 
    create_enemy "serpent" ~hp:10 ~atk:Missile ~spd:4 ~move:Straight
  else if (is_btn 15 30 probability) then 
    create_enemy "serpent" ~hp:14 ~atk:Cross ~spd:3 ~move:Straight
  else if (is_btn 31 45 probability) then 
    create_enemy "serpent" ~hp:14 ~atk:Diamond ~spd:3 ~move:Straight
  else if (is_btn 46 60 probability) then 
    create_enemy "serpent" ~hp:6 ~atk:Star ~spd:1 ~move:Straight
  else create_enemy "scorpion" ~hp:20 ~atk:Passive ~spd:2 ~move:Straight

let add_enemy_to_list () = 
  let new_enemy = random_enemy () in 
  set_image_dimensions new_enemy.image;
  enemy_list := new_enemy :: !enemy_list

let spawn_enemy cooldown = 
  let rand_spawn_time =  2.0 +. float_of_int (random_int cooldown) in 
  timer add_enemy_to_list () spawn_timer rand_spawn_time

let match_enemy_movement e = 
  match e.movement with 
  | _ -> e.image.x <- e.image.x - e.image.speed
(* | Curved -> ()
   | Snake -> e.image.y <- e.image.y - e.image.speed *)

(* and perform_curved_movement = 
   failwith "Curved motion not implemented." *)

let rec move_enemies = function
  | [] -> () 
  | h::t -> match_enemy_movement h; move_enemies t
(* | h::t -> h.image.y <- h.image.y - h.image.speed; move_enemies t *)

let cleanup_enemies () = 
  enemy_list := List.filter (fun e -> e.image.x > 0) !enemy_list
