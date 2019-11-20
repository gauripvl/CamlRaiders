open Sprite
open Objects

val collision_test : sprite -> sprite -> bool

val set_bg : int -> unit

val enemy_list_collision : sprite -> type_enemy list -> unit

val player_laser_collision : sprite list -> type_enemy list -> unit

(** [remove_enemy lst] is [lst] with enemies whose health 
    is below 0 removed *) 
val remove_enemies : unit -> unit