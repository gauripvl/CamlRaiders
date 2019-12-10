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
    x = origin.x + (origin.width / 2);
    y = origin.y + (origin.height / 2);
  };
  vector = vector;
}

let dir_vector origin target = 
  let x = target.x - origin.x in 
  let y = target.y - origin.y in 
  (float_of_int x, float_of_int y)

let unit_vector v = 
  let x, y = v in 
  let magnitude = sqrt (x ** 2.0 +. y ** 2.0) in 
  (x /. magnitude , y /. magnitude)

let create_diamond_atk (e: type_enemy) = 
  enemy_atks := (create_projectile "orb" 12 e.image (1.,0.)) :: !enemy_atks;
  enemy_atks := (create_projectile "orb" 12 e.image (-1.,0.)) :: !enemy_atks;
  enemy_atks := (create_projectile "orb" 12 e.image (0.,1.)) :: !enemy_atks;
  enemy_atks := (create_projectile "orb" 12 e.image (0.,-1.)) :: !enemy_atks

let create_cross_atk (e: type_enemy) = 
  enemy_atks := (create_projectile "orb" 12 e.image (1.,1.)) :: !enemy_atks;
  enemy_atks := (create_projectile "orb" 12 e.image (-1.,1.)) :: !enemy_atks;
  enemy_atks := (create_projectile "orb" 12 e.image (1.,-1.)) :: !enemy_atks;
  enemy_atks := (create_projectile "orb" 12 e.image (-1.,-1.)) :: !enemy_atks

let rec create_enemy_atks = function 
  | [] -> () 
  | h::t -> begin match h.attack with 
      | Passive -> () 
      | Bullet -> 
        enemy_atks := (
          create_projectile "orb" 10 h.image (0.,0.)) :: !enemy_atks
      | Missile -> 
        let vect = unit_vector (dir_vector h.image player.image) in 
        enemy_atks := (
          create_projectile "orb" 12 h.image vect) :: !enemy_atks
      | Diamond -> create_diamond_atk h 
      | Cross -> create_cross_atk h 
      | Star -> create_diamond_atk h; create_cross_atk h;
    end; 
    create_enemy_atks t

let rec move_projectiles = function 
  | [] -> () 
  | h::t -> move_projectile h; move_projectiles t

and move_projectile h = 
  if h.vector = (0.0, 0.0) then h.image.x <- h.image.x + h.image.speed
  else (
    let dx, dy = unit_vector h.vector in 
    h.image.x <- h.image.x + int_of_float (float_of_int h.image.speed *. dx); 
    h.image.y <- h.image.y + int_of_float (float_of_int h.image.speed *. dy)
  )

let cleanup_projectiles () = 
  lasers_list := List.filter (fun x -> is_onscreen x.image) !lasers_list;
  enemy_atks := List.filter (fun x -> is_onscreen x.image) !enemy_atks
