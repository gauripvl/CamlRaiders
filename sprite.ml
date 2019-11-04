module type Sprite = sig
  type t 
  val get_speed : t -> int
  val get_x : t -> int
  val get_y : t -> int
  val img_to_transp : Graphics.image -> Graphics.image
end

module Sprite = struct

  type t = {
    img: Graphics.image;
    speed: int;
    mutable x: int;
    mutable y: int;
  }

  let get_speed t =
    t.speed

  let get_x t =
    t.x

  let get_y t =
    t.y

  (* https://discuss.ocaml.org/t/what-ive-found-playing-with-graphics/739 *)
  (* no function for converting color back to rgb in Graphics *)
  (** [color_to_rgb c] returns the (r,g,b) component of [c] *)
  let color_to_rgb color =
    let r = (color land 0xFF0000) asr 0x10
    and g = (color land 0x00FF00) asr 0x8
    and b = (color land 0x0000FF)
    in r, g, b

  (** [make_transp rgb] is [rbg] converted to the type [color] 
      if [rgb] is not black. Otherwise return [transp] *)
  let make_transp = function 
    | (0, 0, 0) -> Graphics.transp
    | (r', g', b') -> Graphics.rgb r' g' b'

  (** [map_color c] is [c] if [c] is not black. 
      Otherwise return [transp] *)
  let map_color color = color |> color_to_rgb |> make_transp

  let img_to_transp img = 
    Graphics.dump_image img 
    |> Array.map (fun x -> Array.map (fun c -> map_color c) x)
    |> Graphics.make_image
end