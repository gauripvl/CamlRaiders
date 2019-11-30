open Sprite

(** [timer f a r t] calls [f a] every [t] milliseconds *)
val timer : ('a -> unit) -> 'a -> float ref -> float -> unit

(** [switch_duration s r t] *)
val switch_duration : bool ref -> float ref-> float ->unit

(** [random_int n] is a random int between 0 (inclusive) 
    and [n] (exclusive). *)
val random_int : int -> int

(** [is_btn min max n] is true if [n] is between [min] (inclusive) 
    and [max] (inclusive). 
    Requires: [n] >= 0 *)
val is_btn : 'a -> 'a -> 'a -> bool

(** [is_onscreen s] is [true] if the current x, y coordinates 
    of [s] is a point on the gui *)
val is_onscreen : sprite -> bool