open Sprite 

type t = sprite

(** [lasers_list] is a reference to a list of sprites *)
val lasers_list : t list ref

val create_projectile : t -> t
(* val move_projectile : t -> unit *)
val move_projectiles : t list -> unit

(** [cleanup_lasers lst] removes sprites which are outside the 
    gui window boundaries from [lst] *)
val cleanup_lasers : t list ref -> unit