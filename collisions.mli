open Sprite

(** [collision_btn s1 s2] is true if the rectangular image bounds of 
    [s1] and [s2] overlap. *)
val collision_btn : sprite -> sprite -> bool

(** [player_laser_collision lst1 lst2] checks if one of the 
    player's projectiles in [lst1] collides with an enemy 
    in [lst2]. *)
val player_laser_collision : 
  Projectile.type_projectile list -> Enemy.type_enemy list -> unit

(** [collision_with_enemy_proj lst] checks if there is a collision 
    between any enemy laser and the player sprite *)
val collision_with_enemy_proj : Projectile.type_projectile list -> unit

(** [treasure_points str] returns how many points [str] is worth *)
val treasure_points : string -> int 

(** [treasure_collision] checks if there is a collision between any treasure
    sprite and the player sprite *)
val treasure_collision : sprite list -> unit

(** [powerup_collision] checks if there is a collision between any powerup
    sprite and the player sprite *)
val powerup_collision : sprite list -> unit

(** [collision_with_enemies lst] decreases player's lives by one if 
    player hits any sprite in [lst] *)
val collision_with_enemies : Enemy.type_enemy list -> unit

(** [remove_projs lst_ref spr] removes projectiles in [lst_ref] 
    that have collided with [spr]. *)
val remove_projs : Projectile.type_projectile list ref -> sprite -> unit

(** [remove_lasers lst_ref enemies] removes projectiles in [lst_ref] 
    that have collided with any enemy in [enemies]. *)
val remove_lasers : 
  Projectile.type_projectile list ref -> Enemy.type_enemy list -> unit

(** [check_invincibility] checks if the player is invincible or not *)
val check_invincibility : unit -> unit 

(** [remove_enemies lst] is [lst] with enemies whose health 
    is below 0 removed *) 
val remove_enemies : unit -> unit

(** [collision_with_boss boss] checks if there is a collision between [boss]
    and the player sprite. *)
val collision_with_boss : Boss.type_boss -> unit

(** [collision_with_player_laser boss lst] checks if there is a collision 
    between any of the player lasers and [boss]. *)
val collision_with_player_laser : 
  Boss.type_boss -> Projectile.type_projectile list -> unit