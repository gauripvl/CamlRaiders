open Sprite 

type t = sprite

(** [lasers_list] is a reference to a list of sprites *)
val lasers_list : t list ref

(** [lasers_list] is a reference to a list of enemy attacks *)
val enemy_atks : t list ref

val create_projectile : string -> int -> t -> t

val move_projectiles : t list -> unit

val move_enemy_atks : t list -> unit

(** [cleanup_lasers lst] removes sprites which are outside the 
    gui window boundaries from [lst] *)
val cleanup_lasers : unit -> unit

val cleanup_enemy_atks : unit -> unit