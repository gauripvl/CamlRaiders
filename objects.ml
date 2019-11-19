open Sprite

type type_gui = {
  width : int;
  height : int;
  title : string;
}

type type_player = {
  image: sprite;
  mutable lives: int;
  mutable level: int;
}

type type_enemy = {
  image: sprite;
  mutable health: int;
}

let gui_window = {
  width = 640;
  height = 480;
  title = "CamlRaiders Demo";
}

let player = { 
  image = {
    img = None;
    name = "chibi_camel";
    height = -1;
    width = -1;
    speed = 8; 
    x = 320; 
    y = 240; 
  };
  lives = 3;
  level = 1;
}

let get_rand_x () = 
  Random.self_init ();
  Random.int gui_window.width

let enemy = { 
  image = {
    img = None;
    (* img = Some (create_image "scorpion_mini"); *)
    name = "scorpion_mini";
    height = -1;
    width = -1;
    speed = 8; 
    x = get_rand_x (); 
    y = gui_window.height - 250;
  };
  health = 1;
}

(* let laser s = {
   img = None;
   name = "beam";
   height = -1;
   width = -1;
   speed = 24;
   x = s.x + 16; (* TODO change 16 to player.image.width/2 etc... *)
   y = s.y + 24; (* TODO change 24 to player.image.height/2 etc... *)
   } *)

(* let bullet = {
   img = "beam";
   height = -1;
   width = -1;
   speed = 20;
   x = player.image.x;
   y = player.image.y;
   } *)