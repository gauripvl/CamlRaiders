open Sprite
open Objects

let timer f a t_ref t = 
  if (!t_ref <= 0.0) then (f a; t_ref := t)
  else t_ref := !t_ref -. 0.1

let switch_duration switch t_ref t = 
  if (!t_ref > 0.0) then (switch := true; t_ref := !t_ref -. 0.1) 
  else (switch := false; t_ref := t)

let random_int bound = 
  Random.self_init ();
  Random.int bound

let is_onscreen s = 
  s.x > 0 && s.x < gui_window.width &&
  s.y > 0 && s.y < gui_window.height 

