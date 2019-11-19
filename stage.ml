open Objects
open Sprite

let spawn_timer = ref 3.0

let get_rand_x () = 
  Random.self_init ();
  Random.int gui_window.width

(* let get_rand_y () = 
   Random.self_init ();
   Random.int gui_window.height *)

let create_enemy () = {
  image = {
    img = None;
    name = "scorpion_mini";
    height = -1;
    width = -1;
    speed = 8; 
    x = get_rand_x (); 
    (* y = get_rand_y (); *)
    y = gui_window.height + 100; 
  };
  health = 1;
}

let enemy_list = ref []

(* TODO: Map to a timer utility function e.g. [timer f t a] 
   where [f] is the function body and [t] is the time to reset to *)
let spawn_enemy () = 
  if (!spawn_timer <= 0.0) then (
    enemy_list := create_enemy () :: !enemy_list; 
    print_endline "created enemy at x = ";
    let created_enemy = List.hd (List.rev !enemy_list) in 
    print_endline (string_of_int created_enemy.image.x);
    spawn_timer := 5.0)
  else spawn_timer := !spawn_timer -. 0.1

let rec move_enemies = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_enemies t

let cleanup_enemies () = 
  enemy_list := List.filter (fun e -> e.image.y > 0) !enemy_list