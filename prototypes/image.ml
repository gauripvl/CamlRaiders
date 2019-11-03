open Graphics
open Graphic_image
open Png 
open Unix

let () = 
  open_graph "";
  let img = load_as_rgb24 "assets/images/camel.png" [] in 
  (* let g = of_image img in  *)
  draw_image img 0 0;
  sleepf 5.0