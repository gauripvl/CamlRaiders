open Sprite 

type t = sprite

(* TODO dynamically center projectile *)
let create_projectile s = {
  img = "beam";
  height = -1;
  width = -1;
  speed = 24;
  x = s.x + 16;
  y = s.y + 24;
}

let move_projectile p = p.y <- p.y - p.speed

let rec move_projectiles = function 
  | [] -> () 
  | h::t -> h.y <- h.y + h.speed; move_projectiles t