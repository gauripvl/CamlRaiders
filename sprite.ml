
type sprite = {
  mutable img: Graphics.image option;
  name: string;
  mutable height: int;
  mutable width: int;
  speed: int;
  mutable x: int;
  mutable y: int;
}

let get_pos spr = (spr.x, spr.y)

let get_x spr = spr.x

let get_y spr = spr.y

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