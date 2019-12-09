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

(** [enemy_list_collision proj lst] subtracts health from enemy and increases 
    the score if [proj] hits one enemy in [lst]. *)
let rec enemy_list_collision 
    (player_laser: Projectile.type_projectile) enemies =
  match enemies with 
  | [] -> ()
  | h::t -> if collision_btn player_laser.image h.image then (
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

(** [decrease_player_lives ()] decrements one life from the player. *)
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
  let probability = random_int 10 in  
  if probability >= 5 then 
    let dead_enemies = 
      (List.filter (fun e -> e.health <= 0) !enemy_list) in
    Treasure.add_treasure_to_list dead_enemies;
    enemy_list := List.filter (fun e -> e.health > 0) !enemy_list 
  else enemy_list := List.filter (fun e -> e.health > 0) !enemy_list
(* let probability = random_int (List.length dead_enemies) in
       let rand_enemy = List.nth dead_enemies probability in
       Treasure. *)
(* try doing accumulator w/ all enemies that have not collided, or try
   doing something with fold_left *)