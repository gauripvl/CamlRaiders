open Objects
open Sprite
open Utils

type type_attack = Passive | Missile | Diamond | Cross | Star 

type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable attack: type_attack;
  (* mutable attack_freq: float ref; *)
}

(** [create_enemy n h a] creates an enemy with image name [n], 
    health of [hp], and an attack type of [atk]. *)
let create_enemy name hp atk = {
  image = {
    img = Some (create_image name);
    name = name;
    height = -1;
    width = -1;
    speed = 3; 
    x = random_int gui_window.width - 100; 
    y = gui_window.height + 100; 
  };
  health = hp;
  attack = atk;
  (* attack_freq = freq; *)
}

let enemy_list = ref []

let spawn_timer = ref 1.0

(** [random_enemy ()] is an enemy with a randomly set attack type. *)
let random_enemy () = 
  let probability = random_int 100 in 
  if (probability < 15) then create_enemy "serpent" 10 Missile 
  else if (is_btn 15 30 probability) then create_enemy "serpent" 14 Cross 
  else if (is_btn 31 45 probability) then create_enemy "serpent" 14 Diamond 
  else if (is_btn 46 60 probability) then create_enemy "serpent" 6 Star 
  else create_enemy "scorpion" 20 Passive 

let add_enemy_to_list () = 
  let new_enemy = random_enemy () in 
  set_image_dimensions new_enemy.image;
  enemy_list := new_enemy :: !enemy_list

(* print_endline "created enemy at x = ";
   let created_enemy = List.hd (List.rev !enemy_list) in 
   print_endline (string_of_int created_enemy.image.x) *)

let spawn_enemy cooldown = 
  let rand_spawn_time =  2.0 +. float_of_int (random_int cooldown) in 
  timer add_enemy_to_list () spawn_timer rand_spawn_time

let rec move_enemies = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_enemies t

let cleanup_enemies () = 
  enemy_list := List.filter (fun e -> e.image.y > 0) !enemy_list
