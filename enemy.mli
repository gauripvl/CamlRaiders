(* handles spawn, enemy waves *)
open Objects

val spawn_timer : float ref

(** [enemy_list] is a reference to a list of enemies *)
val enemy_list : type_enemy list ref

(* val create_enemy : type_enemy *)

val spawn_enemy : unit -> unit

val move_enemies : type_enemy list -> unit

val cleanup_enemies : unit -> unit