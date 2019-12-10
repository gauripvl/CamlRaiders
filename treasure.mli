open Sprite

val treasure_list : sprite list ref

val power_list: sprite list ref

val random_treasure : 
  string list ref -> Enemy.type_enemy list -> sprite option

val add_treasure_to_list : Enemy.type_enemy list -> unit

val add_powerups_to_list : Enemy.type_enemy list -> unit

val cleanup_powerup : unit -> unit
