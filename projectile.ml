open Sprite 
open Objects

type t = sprite

let lasers_list = ref []
let enemy_atks = ref []

let create_projectile name spd origin = {
  img = None;
  name = name;
  height = -1;
  width = -1;
  speed = spd;
  x = origin.x + 16; (* TODO change 16 to player.image.width/2 etc... *)
  y = origin.y + 24; (* TODO change 24 to player.image.height/2 etc... *)
}

let rec move_projectiles = function 
  | [] -> () 
  | h::t -> h.y <- h.y + h.speed; move_projectiles t

(* we want the directional vector that points from the enemy_atk to the 
   target's location. EP = P - E *)
(* let dir_vector origin target = 
   let x = target.x - origin.x in 
   let y = target.y - origin.y in 
   (float_of_int x, float_of_int y) *)

let dir_vector_mouse target = 
  let mouse_x, mouse_y = Graphics.mouse_pos () in 
  let x = mouse_x - target.x in 
  let y = mouse_y - target.y in 
  (float_of_int x, float_of_int y)

let unit_vector v = 
  let x, y = v in 
  let magnitude = sqrt (x ** 2.0 +. y ** 2.0) in 
  (x /. magnitude , y /. magnitude)

(* let rec move_enemy_atks = function 
   | [] -> () 
   | h::t -> 
    let dx, dy = unit_vector (dir_vector h player.image) in 
    h.x <- h.x + int_of_float (float_of_int h.speed *. dx); 
    h.y <- h.y + int_of_float (float_of_int h.speed *. dy); 
    move_enemy_atks t *)

let rec move_enemy_atks = function 
  | [] -> () 
  | h::t -> 
    let dx, dy = unit_vector (dir_vector_mouse player.image) in 
    h.x <- h.x + int_of_float (float_of_int h.speed *. dx); 
    h.y <- h.y + int_of_float (float_of_int h.speed *. dy); 
    move_enemy_atks t

let cleanup_lasers () = 
  lasers_list := List.filter (fun x -> x.y < gui_window.height) !lasers_list

(* TODO: enemy atks can leave screen from left, right sides *)
let cleanup_enemy_atks () = 
  enemy_atks := List.filter (fun x -> x.y > 0) !enemy_atks
