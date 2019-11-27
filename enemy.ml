open Objects
open Sprite
open Utils

type type_attack = Passive | Missile 

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
    x = random_int gui_window.width; 
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
  let probability = random_int 10 in 
  if probability < 3 then create_enemy "serpent" 6 Missile 
  else create_enemy "scorpion" 10 Passive

let add_enemy_to_list () = 
  let new_enemy = random_enemy () in 
  set_image_dimensions new_enemy.image;
  enemy_list := new_enemy :: !enemy_list

(* print_endline "created enemy at x = ";
   let created_enemy = List.hd (List.rev !enemy_list) in 
   print_endline (string_of_int created_enemy.image.x) *)

let spawn_enemy () = timer add_enemy_to_list () spawn_timer 5.0

let rec move_enemies = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_enemies t

let cleanup_enemies () = 
  enemy_list := List.filter (fun e -> e.image.y > 0) !enemy_list
