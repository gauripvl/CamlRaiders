open Objects
open Sprite
open Utils

let create_enemy name = {
  image = {
    img = Some (create_image name);
    name = name;
    height = -1;
    width = -1;
    speed = 3; 
    x = get_rand_x gui_window.width; 
    y = gui_window.height + 100; 
  };
  health = 1;
  aggro = None;
}

let enemy_list = ref []

let spawn_timer = ref 5.0

let add_enemy_to_list () = 
  let new_enemy = create_enemy "scorpion_mini" in 
  set_image_dimensions new_enemy.image;
  enemy_list := new_enemy :: !enemy_list; 
  print_endline "created enemy at x = ";
  let created_enemy = List.hd (List.rev !enemy_list) in 
  print_endline (string_of_int created_enemy.image.x)

let spawn_enemy () = timer add_enemy_to_list () spawn_timer 5.0

let rec move_enemies = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_enemies t

let cleanup_enemies () = 
  enemy_list := List.filter (fun e -> e.image.y > 0) !enemy_list