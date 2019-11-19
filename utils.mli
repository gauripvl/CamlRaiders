(** [timer f a duration t] calls [f] every [t] milliseconds *)
val timer : ('a -> unit) -> 'a -> float ref -> float -> unit