open Sprite 

type type_projectile = {
  image: sprite;
  vector: float * float;
}

(** [lasers_list] is a reference to a list of sprites *)
val lasers_list : type_projectile list ref

(** [lasers_list] is a reference to a list of enemy attacks *)
val enemy_atks : type_projectile list ref

val create_projectile : string -> int -> sprite -> float * float -> type_projectile

(** [create_enemy_atks lst] creates a suitable projectile based on the enemy's 
    attack type and adds the newly created projectile to [enemy_atks]. *)
val create_enemy_atks : Enemy.type_enemy list -> unit

val move_projectiles : type_projectile list -> unit

(* val create_missile : string -> int -> t -> type_missile *)

(* val move_enemy_atks : type_projectile list -> unit *)

(** [cleanup_lasers lst] removes sprites which are outside the 
    gui window boundaries from [lst] *)
val cleanup_projectiles : unit -> unit
(* val cleanup_lasers : unit -> unit *)

(* val cleanup_enemy_atks : unit -> unit *)