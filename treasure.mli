open Sprite

val treasure_list : sprite list ref

<<<<<<< HEAD
val power_ups: string list ref

val move_treasure : type_treasure list -> unit
=======
val power_list: sprite list ref

val random_treasure : 
  string list ref -> Enemy.type_enemy list -> sprite option
>>>>>>> c3ccca373e34214be3a789577509927dce27cc16

val add_treasure_to_list : Enemy.type_enemy list -> unit

val random_powerup : string list ref -> Enemy.type_enemy list -> type_treasure option

val add_powerups_to_list : type_treasure option -> unit


val cleanup_powerup : unit -> unit
