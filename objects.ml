open Gui
open Sprite

type type_player = {
  image: sprite;
  mutable lives: int;
  mutable level: int;
}

type type_enemy = {
  image: sprite;
  mutable health: int;
}

let init_player = { 
  image = {
    img = create_image "camel";
    speed = 8; 
    x = 320; 
    y = 240; 
  };
  lives = 3;
  level = 1;
}

let init_enemy = { 
  image = {
    img = create_image "camel";
    speed = 8; 
    x = 320; 
    y = 240; 
  };
  health = 1;
}