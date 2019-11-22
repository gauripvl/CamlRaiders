open Sprite
open Objects

val collision_btn : sprite -> sprite -> bool

val set_bg : int -> unit

val enemy_list_collision : sprite -> type_enemy list -> unit

val player_laser_collision : sprite list -> type_enemy list -> unit

val invincibility_timer : float ref 

(** [collision_with lst] decreases player's lives by one if 
    player hits any sprite in [lst] *)
val collision_with : type_enemy list -> unit

val update_player_status : unit -> unit 

(** [remove_enemy lst] is [lst] with enemies whose health 
    is below 0 removed *) 
val remove_enemies : unit -> unit