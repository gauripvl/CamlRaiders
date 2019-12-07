open Sprite

type type_treasure = {
  image : sprite
}
val treasure_list : type_treasure list ref

val move_enemies : type_treasure list -> unit

val cleanup_enemies : unit -> unit