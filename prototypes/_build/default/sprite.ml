open Unix
open Graphics

module type Sprite = sig
  type s = {
    img: image;
    speed: int;
    mutable x: int;
    mutable y: int;
  }

  (* type img = image
     type speed = int
     type x = int
     (* mutable *)
     type y = int
     mutable *)
  val get_speed : s -> int
  val get_x : s -> int
  val get_y : s -> int
  val color_to_rgb : color -> color * color * color
  val make_transp : color * color * color -> color
  val map_color : color -> color
  val img_to_transp : image -> image
end

module Sprite = struct
  type s = {
    img: image;
    speed: int;
    mutable x: int;
    mutable y: int;
  }
  (* type img = image
     type speed = int
     type x = int
     type y = int *)

  let get_speed s =
    s.speed

  let get_x s =
    s.x

  let get_y s =
    s.y

  (* https://discuss.ocaml.org/t/what-ive-found-playing-with-graphics/739 *)
  (* no function for converting color back to rgb in Graphics *)
  (** [color_to_rgb c] returns the (r,g,b) components of [c] *)
  let color_to_rgb color =
    let r = (color land 0xFF0000) asr 0x10
    and g = (color land 0x00FF00) asr 0x8
    and b = (color land 0x0000FF)
    in r, g, b

  (** [make_transp rgb] is [rbg] converted to the type [color] 
      if [rgb] is not black. Otherwise return [transp] *)
  let make_transp = function 
    | (0, 0, 0) -> transp
    | (r', g', b') -> rgb r' g' b'

  (** [map_color c] is [c] if [c] is not black. 
      Otherwise return [transp] *)
  let map_color color = color |> color_to_rgb |> make_transp

  (** [img_to_transp i] is [i] with black color changed to [transp] *)
  let img_to_transp img = 
    dump_image img 
    |> Array.map (fun x -> Array.map (fun c -> map_color c) x)
    |> make_image
end