open Sprite

(** [timer f a duration t] calls [f] every [t] milliseconds *)
val timer : ('a -> unit) -> 'a -> float ref -> float -> unit

val get_rand_x : int -> int

(** [is_onscreen s] is [true] if the current x, y coordinates 
    of [s] is a point on the gui *)
val is_onscreen : sprite -> bool