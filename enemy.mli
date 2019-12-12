(* handles spawn, enemy waves *)
(* open Objects *)
open Sprite

(** [type_attack] is the type of attack of an enemy. *)
type type_attack = 
  | Passive 
  | Bullet
  | Missile 
  | Diamond 
  | Cross 
  | Star

(** [type_movement] is the type of movement of an enemy. *)
type type_movement = 
  | Straight 
  | Organic
  | CurveUpward

(** [type_enemy] is the type of an enemy. *)
type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable attack: type_attack;
  movement: type_movement;
  mutable v_spd: float;
}

val spawn_timer : float ref

(** [enemy_list] is a reference to a list of enemies currently 
    on the screen. *)
val enemy_list : type_enemy list ref

(** [spawn_enemy n] creates an enemy at a random spawn location outside 
    the game window. The frequency at which enemies are spawning is 
    randomly generated from 2 (inclusive) to [n] (inclusive) seconds. *)
val spawn_enemy : int -> unit

(** [move_enemies lst] moves each enemy in [lst] according to their 
    movement type. *)
val move_enemies : type_enemy list -> unit

(** [cleanup_enemies ()] removes enemies which are outside the game window 
    from [enemy_list] *)
val cleanup_enemies : unit -> unit
