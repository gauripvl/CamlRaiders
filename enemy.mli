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

(** [enemy_list] is a reference to a list of enemies *)
val enemy_list : type_enemy list ref

(** [spawn_enemy n] creates an enemy at a random spawn location outside 
    the game window. The frequency at which enemies are spawning is 
    randomly generated from 2 (inclusive) to [n] (inclusive) seconds. *)
val spawn_enemy : int -> unit

val move_enemies : type_enemy list -> unit

val cleanup_enemies : unit -> unit