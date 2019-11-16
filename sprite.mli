
type sprite = {
  mutable img: Graphics.image option;
  name: string;
  mutable height: int;
  mutable width: int;
  speed: int;
  mutable x: int;
  mutable y: int;
}

(* val set_image_dimensions : sprite -> unit *)