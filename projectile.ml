open Sprite 
open Objects
open Utils
open Enemy

type type_projectile = {
  image: sprite;
  vector: float * float;
}

let lasers_list = ref []
let enemy_atks = ref []

let create_projectile name spd origin vector = {
  image = {
    img = Some (create_image name);
    name = name;
    height = -1;
    width = -1;
    speed = spd;
    x = origin.x + 16; (* TODO change 16 to player.image.width/2 etc... *)
    y = origin.y + 24; (* TODO change 24 to player.image.height/2 etc... *)
  };
  vector = vector;
}

(* we want the directional vector that points from the enemy_atk to the 
   target's location. EP = P - E *)
let dir_vector origin target = 
  let x = target.x - origin.x in 
  let y = target.y - origin.y in 
  (float_of_int x, float_of_int y)

let unit_vector v = 
  let x, y = v in 
  let magnitude = sqrt (x ** 2.0 +. y ** 2.0) in 
  (x /. magnitude , y /. magnitude)

let rec create_enemy_atks = function 
  | [] -> () 
  | h::t -> begin match h.attack with 
      | Passive -> () 
      | Missile -> 
        let vect = unit_vector (dir_vector h.image player.image) in 
        enemy_atks := (create_projectile "orb" 12 h.image vect) :: !enemy_atks
    end; 
    create_enemy_atks t

let rec move_projectiles = function 
  | [] -> () 
  (* | h::t -> h.y <- h.y + h.speed; move_projectiles t *)
  | h::t ->
    if h.vector = (0.0, 0.0) then h.image.y <- h.image.y + h.image.speed
    else (
      let dx, dy = unit_vector h.vector in 
      h.image.x <- h.image.x + int_of_float (float_of_int h.image.speed *. dx); 
      h.image.y <- h.image.y + int_of_float (float_of_int h.image.speed *. dy)
    );
    move_projectiles t

let cleanup_projectiles () = 
  lasers_list := List.filter (fun x -> is_onscreen x.image) !lasers_list;
  enemy_atks := List.filter (fun x -> is_onscreen x.image) !enemy_atks
