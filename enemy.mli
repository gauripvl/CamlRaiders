(* handles spawn, enemy waves *)
(* open Objects *)
open Sprite

type type_attack = Passive | Missile 

type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable attack: type_attack;
}

val spawn_timer : float ref

(** [enemy_list] is a reference to a list of enemies currently 
    on the screen. *)
val enemy_list : type_enemy list ref

(** [spawn_enemy n] creates an enemy at a random spawn location outside 
    the game window. The frequency at which enemies are spawning is 
    randomly generated from 2 (inclusive) to [n] (inclusive) seconds. *)
val spawn_enemy : int -> unit

(** [move_enemies lst] moves each enemy in [lst]. *)
val move_enemies : type_enemy list -> unit

(** [cleanup_enemies ()] removes enemies which are outside the game window 
    from [enemy_list] *)
val cleanup_enemies : unit -> unit