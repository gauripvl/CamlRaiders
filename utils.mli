open Sprite

(** [timer f a r t] calls [f a] every [t] milliseconds *)
val timer : ('a -> unit) -> 'a -> float ref -> float -> unit

(** [switch_duration s r t] *)
val switch_duration : bool ref -> float ref-> float ->unit

val get_rand_x : int -> int

(** [is_onscreen s] is [true] if the current x, y coordinates 
    of [s] is a point on the gui *)
val is_onscreen : sprite -> bool