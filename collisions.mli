open Sprite
open Projectile
open Objects

val collision_test : sprite -> sprite -> bool

val set_bg : int -> unit

val enemy_list_collision : sprite -> type_enemy list ref -> unit

val player_laser_collision : sprite list ref -> type_enemy list ref -> unit

(** [remove_enemy lst] is [lst] with enemies whose health 
    is below 0 removed *) 
val remove_enemy : type_enemy list ref