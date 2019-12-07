open Sprite

type type_treasure = {
  image : sprite
}
val treasure_list : type_treasure list ref 

val move_treasure : type_treasure list -> unit

val add_treasure_to_list : Enemy.type_enemy list -> unit

val cleanup_treasure : unit -> unit