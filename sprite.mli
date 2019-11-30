(** [sprite] is the type represention a sprite. 
    [x] and [y] represents the lower left point ([x],[y]) of the sprite. *)
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

(** [set_image_dimensions spr] sets the height of width of [spr] *)
val set_image_dimensions : sprite -> unit
