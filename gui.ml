open Sprite

type t = sprite

let get_speed t = t.speed

let get_pos t = (t.x, t.y)

let get_x t = t.x

let get_y t = t.y

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

(** [img_to_transp i] is [i] with black color 
    changed to [transp] *)
let img_to_transp img = 
  Graphics.dump_image img 
  |> Array.map (fun x -> Array.map (fun c -> map_color c) x)
  |> Graphics.make_image

let create_image str = 
  Png.load_as_rgb24 ("assets/images/" ^ str ^ ".png") [] 
  |> Graphic_image.of_image 
  |> img_to_transp

let draw t = Graphics.draw_image t.img t.x t.y

let update_pos t = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'w' -> t.y <- t.y + t.speed
    | 'a' -> t.x <- t.x - t.speed
    | 's' -> t.y <- t.y - t.speed
    | 'd' -> t.x <- t.x + t.speed
    | 'q' -> exit 0
    | _ -> ()