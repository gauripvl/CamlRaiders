open Sprite

val foreground_props : sprite list ref
val middleground_props : sprite list ref
val background_props : sprite list ref

(** [add_bg str x spd ref] adds a sprite with image [name], 
    initial x position of [x], initial y position of 0, 
    and speed [spd] to [ref]. *)
val add_bg : string -> x:int -> spd:int -> ref:sprite list ref -> unit

(** [manage_parallax str spd ref lst] moves each element of [lst] 
    and adds a new sprite with image [str] and speed [spd] to [ref] 
    when the left edge of an element in [lst] passes through the 
    right-most boundary of the GUI.  *)
val manage_parallax : 
  string -> spd:int -> ref:sprite list ref -> sprite list -> unit

(** [cleanup_bg lst] removes elements of [lst] that have a left edge 
    of their sprite passing through the left side of the GUI. *)
val cleanup_bg : sprite list ref list -> unit