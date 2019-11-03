open Unix
open Graphics
open Png
(* open Sprite *)

type sprite = {
  img: image;
  speed: int;
  mutable x: int;
  mutable y: int;
}

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

let update_pos s =
  if key_pressed () then
    match read_key () with
    | 'w' -> s.y <- s.y + s.speed
    | 'a' -> s.x <- s.x - s.speed
    | 's' -> s.y <- s.y - s.speed
    | 'd' -> s.x <- s.x + s.speed
    | 'q' -> exit 0
    | _ -> ()

let move_enemy e =
  e.y <- e.y - e.speed

let draw s = draw_image s.img s.x s.y

let rec game_loop s e = (* later make e a list of enemies rather than a single enemy *)
  sleepf 0.05;
  update_pos s;
  move_enemy e;
  clear_graph ();
  draw s;
  draw e;
  game_loop s e

let main () =
  open_graph " 640x480";
  let img_camel =
    load_as_rgb24 "assets/images/camel.png" []
    |> Graphic_image.of_image
    |> img_to_transp in
  let player = { speed = 8; img = img_camel; x = 320; y = 240; } in
  let enemy = { speed = 1; img = create_image 50 50; x = 100; y = 400; } in
  draw player;
  draw enemy;
  game_loop player enemy

let () = main ()