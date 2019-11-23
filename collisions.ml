open Objects
open Sprite
open Enemy 
open Utils 

let collision_btn origin target = 
  (origin.x + origin.width > target.x 
   && origin.x < target.x + target.width
  ) && (
    origin.y + origin.height > target.y 
    && origin.y < target.y + target.height)

let set_bg col = 
  Graphics.set_color col; 
  Graphics.fill_rect 0 0 640 480

(* let collision (e: sprite) = 
   if (collision_test player.image e) 
   then set_bg 0xff792b 
   else set_bg 0x4797ff *)
(* if player.lives > 0 then player.lives <- player.lives - 1 else exit 0 *)

let rec enemy_list_collision player_laser enemies =
  match enemies with 
  | [] -> ()
  | h::t -> if collision_btn player_laser h.image then (
      h.health <- h.health - player.power; 
      scoreboard.score <- scoreboard.score + 1 
    )
    else enemy_list_collision player_laser t

let rec player_laser_collision player_lasers enemies =
  match player_lasers with
  | [] -> ()
  | h::t -> enemy_list_collision h enemies;
    player_laser_collision t enemies

let decrease_player_lives () = 
  player.lives <- player.lives - 1

let invincibility_timer = ref 0.0

let rec collision_with = function
  | [] -> ()
  | e::t -> 
    if collision_btn player.image e.image then 
      timer decrease_player_lives () invincibility_timer 5.0
    else collision_with t 

let update_player_status () = 
  if (!invincibility_timer > 0.0) then player.invincible <- true 
  else player.invincible <- false 

let remove_enemies ()  = 
  enemy_list := List.filter (fun e -> e.health > 0) !enemy_list 

(* try doing accumulator w/ all enemies that have not collided, or try
   doing something with fold_left *)