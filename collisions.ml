open Sprite
open Projectile 

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

let rec enemy_list_collision (e_laser: laser) (e_enemy_list: enemy_list) (p: player) =
  | [] -> ()
  | h::t -> if collision_test e_laser h
    then a.health <- a.health - player.health
    else enemy_list_collision e_laser t player

let rec player_laser_collision (l: lasers_list) (e: enemy_list) (p: player) =
  match l with
  | [] -> ()
  | h::t -> enemy_list_collision h e p;
    player_laser_collision t e p

let rec remove_enemy (e: enemy_list) (acc: enemy_list)  =
  match e with
  | [] -> []
  | h::t -> if h.health <= 0
    then remove_enemy t acc
    else
      acc :: h;
    remove_enemy t acc


(* try doing accumulator w/ all enemies that have not collided, or try
   doing something with fold_left *)