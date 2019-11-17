open Sprite
open Objects
open Projectile

type t = sprite

let open_game_window w = 
  " " ^ (string_of_int w.width) ^ "x" ^ (string_of_int w.height)
  |> Graphics.open_graph; Graphics.set_window_title w.title

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

(* let draw t = Graphics.draw_image (Option.get t.img) t.x t.y *)
let draw t = Graphics.draw_image (create_image t.name) t.x t.y

let rec draw_list = function
  | [] -> () 
  | h::t -> draw h; draw_list t

let update_pos t = 
  if Graphics.key_pressed () then 
    match Graphics.read_key () with 
    | 'w' -> t.y <- if t.y + t.speed >= (gui_window.height - 50) then (gui_window.height - 50) else t.y + t.speed
    | 'a' -> t.x <- if t.x - t.speed <= 0 then 0 else t.x - t.speed
    | 's' -> t.y <- if t.y - t.speed <= 0 then 0 else t.y - t.speed
    | 'd' -> t.x <- if t.x + t.speed >= (gui_window.width - 50) then (gui_window.width - 50) else t.x + t.speed
    | ' ' -> lasers_list := (create_projectile t) :: !lasers_list
    | 'q' -> exit 0
    | _ -> ()

let print_st str = 
  Graphics.moveto ((gui_window.height)/2) ((gui_window.width)/2);
  Graphics.draw_string str
