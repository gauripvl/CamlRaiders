open Objects
open Sprite
open Enemy 
open Utils 
open Treasure

let collision_btn origin target = 
  (origin.x + origin.width > target.x 
   && origin.x < target.x + target.width
  ) && (
    origin.y + origin.height > target.y 
    && origin.y < target.y + target.height)

(** [enemy_list_collision proj lst] subtracts health from enemy and increases 
    the score if [proj] hits one enemy in [lst]. *)
let rec enemy_list_collision 
    (player_laser: Projectile.type_projectile) (enemies:type_enemy list) =
  match enemies with 
  | [] -> ()
  | h::t -> if collision_btn player_laser.image h.image then (
      h.health <- h.health - player.power; 
      scoreboard.score <- scoreboard.score + 2 
    )
    else enemy_list_collision player_laser t

let rec player_laser_collision lasers_ref enemies = 
  match lasers_ref with
  | [] -> ()
  | h::t -> enemy_list_collision h enemies;
    player_laser_collision t enemies

let invincibility_timer = ref player.invincibility_duration
let is_invincible = ref false 

let check_invincibility () = 
  player.invincible <- !is_invincible;
  if !is_invincible then switch_duration 
      is_invincible invincibility_timer player.invincibility_duration

(** [decrease_player_lives ()] decrements one life from the player 
    if the player is not invincible. *)
let decrease_player_lives () = 
  if not !is_invincible then (
    player.lives <- player.lives - 1;
    is_invincible := true)
  else ()

let rec collision_with_enemy_proj 
    (enemy_lasers:Projectile.type_projectile list) =
  match enemy_lasers with
  | [] -> ()
  | h::t -> if collision_btn h.image player.image then (
      decrease_player_lives ()
    )
    else collision_with_enemy_proj t

(** [remove_treasure lst treasure acc] returns a new list [acc] of treasures
    with the elements of [lst] exluding [treasure] *)
let rec remove_treasure (treasures:sprite list) (treasure:sprite) 
    (acc:sprite list)=
  match treasures with
  | [] -> acc
  | h::t -> if (h.name = treasure.name) then
      remove_treasure t treasure acc
    else (
      remove_treasure t treasure (h :: acc)
    )

(** [remove_head lst] removes the first string from a list of strings [lst] *)
let remove_head (treasures:string list) =
  match treasures with
  | [] -> []
  | _::t -> t

let treasure_points str =
  match str with
  | "coin" -> 42
  | "lily" -> 60
  | "crown" -> 100
  | "diamond" -> 200
  | _ -> 0

let rec treasure_collision (treasures:sprite list) =
  match treasures with
  | [] -> ()
  | h::t -> if collision_btn h player.image then (
      source_treasures := remove_head !source_treasures;
      scoreboard.score <- scoreboard.score + treasure_points h.name;
      collected_treasures := h :: !collected_treasures;
      treasure_list := remove_treasure !treasure_list h [] 
    )
    else treasure_collision t

let rec collision_with_enemies = function
  | [] -> ()
  | e::t -> 
    if collision_btn player.image e.image then 
      decrease_player_lives ()
    else collision_with_enemies t 

(** [should_keep proj target] returns whether [proj] and [target] have
    collided or not *)
let should_keep (proj:Projectile.type_projectile) target = 
  not (collision_btn proj.image target)

let remove_projs (lst_ref:Projectile.type_projectile list ref) target = 
  lst_ref := List.filter (fun p -> should_keep p target) !lst_ref

let rec remove_lasers (lasers_ref:Projectile.type_projectile list ref) 
    (enemies:type_enemy list) = 
  match enemies with 
  | [] -> ()
  | h::t -> remove_projs lasers_ref h.image;
    remove_lasers lasers_ref t

(** [inc_player_lives ()] increases the number of player's lives by 1 *)
let inc_player_lives () = player.lives <- player.lives + 1

(** [match_powerup_to_power p] determines what power the powerup grants the
    player *)
let match_powerup_to_power power_up = 
  match power_up with 
  | None -> ()
  | Some h -> match h.name with
    |"one_heart" -> if player.lives < 3 then inc_player_lives ()
    | _ -> failwith "not yet implemented"

(** [remove_first_powerup lst powerup acc] returns a new list [acc] of powerups
    with the elements of [lst] exluding the first instance of [powerup] *)
let rec remove_first_powerup (powerups:sprite list) (powerup:sprite) 
    (acc:sprite list)=
  match powerups with
  | [] -> acc
  | h::t -> if (h.name = powerup.name) then
      List.append t acc
    else (
      remove_first_powerup t powerup (h :: acc)
    )

let rec powerup_collision (powerups:sprite list) =
  match powerups with
  | [] -> ()
  | h::t -> if collision_btn h player.image then (
      match_powerup_to_power (Some h);
      power_list := remove_first_powerup !power_list h [] 
    )
    else powerup_collision t

let remove_enemies ()  = 
  let probability_t = random_int 10 in  
  let probability_p = random_int 10 in
  if probability_p >= 2 then 
    if probability_t >= 5 then 
      let dead_enemies = 
        (List.filter (fun e -> e.health <= 0) !enemy_list) in
      let new_powerup_option = 
      Treasure.random_powerup Treasure.power_ups dead_enemies in
      (* match_powerup_to_power new_powerup_option; *)
      Treasure.add_treasure_to_list dead_enemies;
      Treasure.add_powerups_to_list new_powerup_option;
      enemy_list := List.filter (fun e -> e.health > 0) !enemy_list 
    else 
      let dead_enemies = 
        (List.filter (fun e -> e.health <= 0) !enemy_list) in
      let new_powerup_option = 
      Treasure.random_powerup Treasure.power_ups dead_enemies in
      (* match_powerup_to_power new_powerup_option; *)
      Treasure.add_powerups_to_list new_powerup_option;
      enemy_list := List.filter (fun e -> e.health > 0) !enemy_list 
  else enemy_list := List.filter (fun e -> e.health > 0) !enemy_list

let collision_with_boss (boss:Boss.type_boss) = 
  if collision_btn player.image boss.image then 
    decrease_player_lives ()

let rec collision_with_player_laser (boss:Boss.type_boss) 
    (player_lasers:Projectile.type_projectile list) = 
  match player_lasers with 
  | [] -> ()
  | h::t -> check_laser_hit_boss h boss; 
    collision_with_player_laser boss t

(** [check_laser_hit_boss h b] updates the health of boss [b] 
    and the scoreboard whenever a laser shot by the player hits the boss *)
and check_laser_hit_boss h boss = 
  if collision_btn boss.image h.image then (
    boss.health <- boss.health - player.power; 
    scoreboard.score <- scoreboard.score + 10
  )
