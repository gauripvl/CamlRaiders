open Graphics

module type Sprite = sig
  type s = {
    img: image;
    speed: int;
    mutable x: int;
    mutable y: int;
  }

  val get_speed : s -> int
  val get_x : s -> int
  val get_y : s -> int
  val color_to_rgb : color -> color * color * color
  val make_transp : color * color * color -> color
  val map_color : color -> color
  val img_to_transp : image -> image
end