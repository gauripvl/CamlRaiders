open Sprite
open Utils

type type_treasure = {
  image : sprite
}

let create_treasure (enemy_s) = {
  image = {
    img = Some (create_image "serpent");
    name = "treasure1";
    height = -1;
    width = -1;
    speed = 3; 
    x = enemy_s.x; 
    y = enemy_s.y + 5; 
  }
}

let treasure_list = []

let random_treasure (enemy_list: Enemy.type_enemy list ref) = 
  let probability = random_int (List.length !enemy_list) in
  create_treasure (List.nth !enemy_list probability)

let add_treasure_to_list () = 
  let new_treasure = random_treasure (Enemy.enemy_list) 
  in set_image_dimensions new_treasure.image;
  new_treasure :: treasure_list

let rec move_treasure = function
  | [] -> () 
  | h::t -> h.image.y <- h.image.y - h.image.speed; move_treasure t

let cleanup_enemies () = 
  List.filter (fun e -> e.image.y > 0) treasure_list