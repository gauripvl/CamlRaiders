open Sprite
open Objects

let foreground_props = ref []
let middleground_props = ref []
let background_props = ref []

let add_bg name ~x:initial_x ~spd:spd ~ref:lst_ref = 
  let new_sprite = create_sprite name 
      ~x:initial_x ~y:0 ~spd:spd in 
  set_image_dimensions new_sprite;
  lst_ref := new_sprite :: !lst_ref

let rec manage_parallax name ~spd:spd ~ref:lst_ref = function 
  | [] -> ()
  | h::t -> 
    if h.x + h.width - 14 < gui_window.width && List.length !lst_ref < 3  then 
      add_bg name ~x:gui_window.width ~spd:spd ~ref:lst_ref;
    h.x <- h.x - h.speed;
    manage_parallax name ~spd:spd ~ref:lst_ref t

let rec cleanup_bg = function 
  | [] -> ()
  | h::t -> 
    h := List.filter (fun bg -> bg.x + bg.width > 0) !h;
    cleanup_bg t
