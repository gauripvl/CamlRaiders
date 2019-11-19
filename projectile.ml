open Sprite 
open Objects

type t = sprite

let lasers_list = ref []

let create_projectile s = {
  img = None;
  name = "beam";
  height = -1;
  width = -1;
  speed = 24;
  x = s.x + 16; (* TODO change 16 to player.image.width/2 etc... *)
  y = s.y + 24; (* TODO change 24 to player.image.height/2 etc... *)
}

(* let move_projectile p = p.y <- p.y - p.speed *)

let rec move_projectiles = function 
  | [] -> () 
  | h::t -> h.y <- h.y + h.speed; move_projectiles t

let cleanup_lasers () = 
  lasers_list := List.filter (fun x -> x.y < gui_window.height) !lasers_list
