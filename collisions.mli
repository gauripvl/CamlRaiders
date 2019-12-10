open Sprite
(* open Objects *)

(** [collision_btn s1 s2] is true if the rectangular image bounds of 
    [s1] and [s2] overlap. *)
val collision_btn : sprite -> sprite -> bool

(** [player_laser_collision lst1 lst2] checks if one of the 
    player's projectiles in [lst1] collides with an enemy 
    in [lst2]. *)
val player_laser_collision : 
  Projectile.type_projectile list -> Enemy.type_enemy list -> unit

val collision_with_enemy_proj : Projectile.type_projectile list -> unit

(** [collision_with lst] decreases player's lives by one if 
    player hits any sprite in [lst] *)
val collision_with_enemies : Enemy.type_enemy list -> unit

val check_invincibility : unit -> unit 

(** [remove_enemy lst] is [lst] with enemies whose health 
    is below 0 removed *) 
val remove_enemies : unit -> unit

val collision_with_boss : Boss.type_boss -> unit

val collision_with_player_laser : 
  Boss.type_boss -> Projectile.type_projectile list -> unit