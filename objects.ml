open Sprite
(* open Boss *)

type type_gui = {
  width : int;
  height : int;
  title : string;
}

type type_powerup = Neutral | TripleLasers

type type_player = {
  image: sprite;
  mutable lives: int;
  mutable level: int;
  mutable power: int;
  mutable invincible: bool;
  mutable invincibility_duration: float;
  mutable powerup: type_powerup;
}

type type_scoreboard = {
  width: int;
  height: int;
  mutable score: int;
}

let gui_window = {
  width = 800;
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
  power = 2;
  invincible = false;
  invincibility_duration = 3.0;
  powerup = Neutral;
}

let scoreboard = {
  width = 200;
  height = 90;
  score = 0;
}
