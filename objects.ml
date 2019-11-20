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
  mutable power: int;
}

type type_attack = None | Missile 

type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable aggro: type_attack;
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
    speed = 12; 
    x = 320; 
    y = 240; 
  };
  lives = 3;
  level = 1;
  power = 10;
}
