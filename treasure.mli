open Sprite

type type_treasure = {
  image : sprite
}

val treasure_list : type_treasure list ref

val power_list: type_treasure list ref

val move_treasure : type_treasure list -> unit

val random_treasure : string list ref -> Enemy.type_enemy list -> type_treasure option

val add_treasure_to_list : Enemy.type_enemy list -> unit

val add_powerups_to_list : Enemy.type_enemy list -> unit

val cleanup_powerup : unit -> unit
