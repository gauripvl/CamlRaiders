open Sprite
open Utils
open Projectile 
open Objects

type type_boss_attack = 
  | BinaryStar 
  | BinaryBullet
  | BinaryChaos

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
    x = 300;
    y = 200;
    (* x = random_int Objects.gui_window.width - 100; 
       y = Objects.gui_window.height + 100;  *)
  };
  health = hp;
  attacks = atks;
  attack_freq = freq;
}

let binary_red_atks = ref []
let binary_black_atks = ref []
let boss_attack_timer = ref 5.0
(* let combo_atk_timer = ref 0.5 *)

(** [create_vector_projectiles name spd origin atk_ref vectors] *) 
let rec create_vector_projectiles 
    name ~speed:spd ~origin:(origin:type_boss) ~atk_ref:atk_ref = function 
  | [] -> ()
  | h::t ->
    atk_ref := (create_projectile name spd origin.image h) :: !atk_ref;
    create_vector_projectiles 
      name ~speed:spd ~origin:origin ~atk_ref:atk_ref t

(** [choose_random_atk lst] is one random element of [lst]. *) 
let choose_random_atk lst = 
  Random.self_init ();
  lst |> List.length |> Random.int |> List.nth lst

let rec create_boss_atk b = 
  let random_atk = choose_random_atk b.attacks in 
  match random_atk with 
  | BinaryStar -> create_atk_binarystar b
  | BinaryBullet ->  create_atk_binarybullet b;
    (* | BinaryChaos -> create_atk_binarychaos b; *)
  | _ -> ()

and create_atk_binarystar (b: type_boss) = 
  let prob_rb, prob_atk_type = (random_int 4, random_int 2) in 
  if prob_rb < 3 then 
    let diamond_vectors = [(1.,0.); (-1.,0.);(0.,1.);(0.,-1.)] in (
      if prob_atk_type = 0 then create_vector_projectiles 
          "orb" ~speed:6 ~origin:b ~atk_ref:binary_red_atks diamond_vectors 
      else create_vector_projectiles 
          "orb_blue" ~speed:6 ~origin:b ~atk_ref:binary_red_atks diamond_vectors 
    )
  else let cross_vectors = [(1.,1.); (-1.,1.);(1.,-1.);(-1.,-1.)] in (
      if prob_atk_type = 0 then create_vector_projectiles 
          "orb" ~speed:6 ~origin:b ~atk_ref:binary_red_atks cross_vectors 
      else create_vector_projectiles 
          "orb_blue" ~speed:6 ~origin:b ~atk_ref:binary_red_atks cross_vectors 
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

(* and create_atk_binarychaos (b: type_boss) = 
   let count = 5 in 
   let rec random_unit_vectors =  *)

let boss_rbbinary = 
  let attack_types = [BinaryBullet] in spawn_boss "boss_rbbinary" 
    ~hp:1000 ~atk_types:attack_types ~freq:4.0

