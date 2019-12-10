
type sprite = {
  mutable img: Graphics.image option;
  name: string;
  mutable height: int;
  mutable width: int;
  speed: int;
  mutable x: int;
  mutable y: int;
}

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

let create_sprite name ~x:initial_x ~y:initial_y ~spd:spd = {
  img = Some (create_image name);
  name = name;
  height = -1;
  width = -1;
  speed = spd; 
  x = initial_x; 
  y = initial_y; 
}

(** [get_height img] is the height of [img] *)
let get_height img = 
  img |> Graphics.dump_image |> Array.length 

(** [get_width img] is the width of [img] *)
let get_width img = 
  let image_array = img |> Graphics.dump_image in 
  Array.get image_array 1 |> Array.length 

let set_image_dimensions spr = 
  match spr.img with 
  | None -> failwith "No sprite image specified."
  | Some img -> spr.height <- get_height img; spr.width <- get_width img