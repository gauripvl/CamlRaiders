
type sprite = {
  mutable img: Graphics.image option;
  name: string;
  mutable height: int;
  mutable width: int;
  speed: int;
  mutable x: int;
  mutable y: int;
}

(** [create_image str] returns a transparent Graphics.image of 
    the png file named [str] in the assets/images directory *)
val create_image : string -> Graphics.image

(** [get_pos t] is [(x,y)] where x is the x-coordinate of [t] 
    and y is the y-coordinate of [t] *)
val get_pos : sprite -> int * int

(** [get_x t] is the x-coordinate of [t] *)
val get_x : sprite -> int

(** [get_y t] is the y-coordinate of [t] *)
val get_y : sprite -> int

(** [set_image_dimensions spr] sets the height of width of [spr] *)
val set_image_dimensions : sprite -> unit