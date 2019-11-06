open Sprite 

type t = sprite

val create_projectile : t -> t
val move_projectile : t -> unit
val move_projectiles : t list -> unit