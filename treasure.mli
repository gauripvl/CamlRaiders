open Sprite

type type_treasure = {
  image : sprite
}
val treasure_list : type_treasure list ref
val power_list: type_treasure list ref

val power_ups: string list ref

val move_treasure : type_treasure list -> unit

val random_treasure : string list ref -> Enemy.type_enemy list -> type_treasure option
val add_treasure_to_list : Enemy.type_enemy list -> unit

val random_powerup : string list ref -> Enemy.type_enemy list -> type_treasure option

val add_powerups_to_list : type_treasure option -> unit


val cleanup_powerup : unit -> unit