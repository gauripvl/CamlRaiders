open Sprite
open Objects

let timer f a duration t = 
  if (!duration <= 0.0) then (f a; duration := t)
  else duration := !duration -. 0.1

let get_rand_x bound = 
  Random.self_init ();
  Random.int bound

let is_onscreen s = 
  s.x > 0 && s.x < gui_window.width &&
  s.y > 0 && s.y < gui_window.height 