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
  title = "CamlRaiders";
}

let player = { 
  image = {
    img = "camel";
    speed = 8; 
    x = 320; 
    y = 240; 
  };
  lives = 3;
  level = 1;
}

let enemy = { 
  image = {
    img = "camel";
    speed = 8; 
    x = 320; 
    y = 240; 
  };
  health = 1;
}

let bullet = {
  img = "";
  speed = 20;
  x = player.image.x;
  y = player.image.y;
}