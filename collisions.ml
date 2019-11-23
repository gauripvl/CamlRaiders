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

let invincibility_timer = ref player.invincibility_duration
let is_invincible = ref false 

let decrease_player_lives () = 
  player.lives <- player.lives - 1

let rec collision_with = function
  | [] -> ()
  | e::t -> 
    if collision_btn player.image e.image then 
      if not !is_invincible then (
        decrease_player_lives ();
        is_invincible := true)
      else ()
    else collision_with t 

let check_invincibility () = 
  player.invincible <- !is_invincible;
  if !is_invincible then switch_duration 
      is_invincible invincibility_timer player.invincibility_duration

(* let update_player_status () = 
   if (!invincibility_timer > 0.0) then player.invincible <- true 
   else player.invincible <- false  *)

let remove_enemies ()  = 
  enemy_list := List.filter (fun e -> e.health > 0) !enemy_list 

(* try doing accumulator w/ all enemies that have not collided, or try
   doing something with fold_left *)