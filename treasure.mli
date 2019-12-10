open Sprite

val treasure_list : sprite list ref

val power_list: sprite list ref

val power_ups : string list ref
val source_treasures : string list ref

val random_treasure : 
  string list ref -> Enemy.type_enemy list -> sprite option

val add_treasure_to_list : Enemy.type_enemy list -> unit

val random_powerup : string list ref -> Enemy.type_enemy list -> sprite option

val add_powerups_to_list : sprite option -> unit

val cleanup_powerup : unit -> unit
