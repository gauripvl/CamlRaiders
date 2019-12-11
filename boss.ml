open Sprite
open Utils
open Projectile 
open Objects

type type_boss_attack = 
  | BinaryStar 
  | BinaryBullet

type type_boss = {
  image: sprite;
  mutable health: int;
  mutable attacks: type_boss_attack list;
  attack_freq: float;
}

let spawn_boss name ~hp:hp ~atk_types:atks ~freq:freq = {
  image = {
    img = None;
    name = name;
    height = -1;
    width = -1;
    speed = 2; 
    x = 1000;
    y = 500;
  };
  health = hp;
  attacks = atks;
  attack_freq = freq;
}

(* rb special attacks *)
let binary_red_atks = ref []
let binary_black_atks = ref []

(* creates an attack every set amount of time *)
let boss_attack_timer = ref 25.0

(* switches to a random attack when false *)
let switch_attack = ref true

let attack_duration = ref 0.5

(* stores the current attack of the boss *)
let boss_current_attack = ref None

(** [create_vector_projectiles name spd origin atk_ref vectors] *) 
let rec create_vector_projectiles 
    name ~speed:spd ~origin:(origin:type_boss) ~atk_ref:atk_ref = function 
  | [] -> ()
  | h::t ->
    atk_ref := (create_projectile name spd origin.image h) :: !atk_ref;
    create_vector_projectiles 
      name ~speed:spd ~origin:origin ~atk_ref:atk_ref t

let manage_atk_duration () = 
  if !switch_attack then
    switch_duration switch_attack attack_duration 0.5 

(** [choose_random_atk lst] is one random element of [lst]. *) 
let choose_random_atk lst = 
  if (!boss_current_attack = None) || not !switch_attack then (
    switch_attack := true;
    let random_attack = (
      Random.self_init ();
      lst |> List.length |> Random.int |> List.nth lst 
    ) in 
    boss_current_attack := Some random_attack 
  );
  match !boss_current_attack with 
  | Some atk -> atk
  | None -> failwith "Boss's current attack is None."

let rec create_boss_atk b = 
  manage_atk_duration ();
  let random_atk = choose_random_atk b.attacks in 
  match random_atk with 
  | BinaryStar -> create_atk_binarystar b
  | BinaryBullet ->  create_atk_binarybullet b;

and create_atk_binarystar (b: type_boss) = 
  let prob_rb, prob_atk_type = (random_int 4, random_int 2) in 
  if prob_rb < 3 then 
    let diamond_vectors = [(1.,0.); (-1.,0.);(0.,1.);(0.,-1.)] in (
      if prob_atk_type = 0 then create_vector_projectiles 
          "orb" 
          ~speed:6  ~origin:b 
          ~atk_ref:binary_red_atks diamond_vectors 
      else create_vector_projectiles 
          "orb_blue" 
          ~speed:6 ~origin:b 
          ~atk_ref:binary_red_atks diamond_vectors 
    )
  else let cross_vectors = [(1.,1.); (-1.,1.);(1.,-1.);(-1.,-1.)] in (
      if prob_atk_type = 0 then create_vector_projectiles 
          "orb" 
          ~speed:6 ~origin:b 
          ~atk_ref:binary_red_atks cross_vectors 
      else create_vector_projectiles 
          "orb_blue"
          ~speed:6 ~origin:b 
          ~atk_ref:binary_red_atks cross_vectors 
    )

and create_atk_binarybullet (b:type_boss) = 
  let dx, dy = unit_vector (dir_vector b.image player.image) in (
    let prob_rb = random_int 4 in 
    if prob_rb < 3 then (
      binary_red_atks := (
        create_projectile "orb" 12 b.image (dx, dy)) :: 
        !binary_red_atks;
      binary_red_atks := (
        create_projectile "orb" 12 b.image (~-.dx, ~-.dy)) :: 
        !binary_red_atks)
    else 
      binary_black_atks := (
        create_projectile "orb_blue" 12 b.image (dx, dy)) :: 
        !binary_black_atks;
    binary_black_atks := (
      create_projectile "orb" 12 b.image (~-.dx, ~-.dy)) :: 
      !binary_black_atks
  )

let is_motion_upwards = ref true
let direction_duration = ref 15.0
let is_current_dir_up = ref true

let manage_motion () = 
  if !is_motion_upwards then 
    switch_duration is_motion_upwards direction_duration 10.0
  else (
    is_motion_upwards := true;
    is_current_dir_up := not !is_current_dir_up
  )

let oscillate_vertically (b:type_boss) = 
  match !is_current_dir_up with 
  | true -> b.image.y <- b.image.y + b.image.speed
  | false -> b.image.y <- b.image.y - b.image.speed

let is_entry_going = ref true
let switch_entry_off = ref 25.0

let move_boss (b:type_boss) = 
  if !is_entry_going then (
    switch_duration is_entry_going switch_entry_off 25.0;
    b.image.x <- b.image.x - b.image.speed;
    b.image.y <- b.image.y - b.image.speed
  ) else (
    manage_motion ();
    oscillate_vertically b
  )

let boss_rbbinary = 
  let attack_types = [BinaryBullet; BinaryStar] in 
  spawn_boss "boss_rbbinary" 
    ~hp:3110 ~atk_types:attack_types ~freq:1.0

(* let is_boss_defeated (b:type_boss) = b.health <= 0 *)
