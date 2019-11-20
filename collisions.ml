open Sprite
open Projectile 
open Objects

let collision_test (s: sprite) (e: sprite) = 
  (s.x + get_width s > e.x && s.x < e.x + get_width e) &&
  (s.y + get_height s > e.y && s.y < e.y + get_height e)

let set_bg col = 
  Graphics.set_color col; 
  Graphics.fill_rect 0 0 640 480

let collision (e: sprite) = 
  if (collision_test player.image e) 
  then set_bg 0xff792b 
  else set_bg 0x4797ff
(* if player.lives > 0 then player.lives <- player.lives - 1 else exit 0 *)

let rec enemy_list_collision enemy_laser enemies =
  match enemies with 
  | [] -> ()
  | h::t -> if collision_test enemy_laser h
    then h.health <- h.health - player.power
    else enemy_list_collision enemy_laser t

let rec player_laser_collision enemy_lasers enemies =
  match enemy_lasers with
  | [] -> ()
  | h::t -> enemy_list_collision h enemies;
    player_laser_collision t enemies

let remove_enemy lst  = 
  List.filter (fun e -> e.health > 0) lst
(* match lst with
   | [] -> []
   | h::t -> if h.health <= 0
   then remove_enemy t acc
   else
   acc :: h; remove_enemy t acc *)


(* try doing accumulator w/ all enemies that have not collided, or try
   doing something with fold_left *)