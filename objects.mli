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
  mutable invincible: bool;
  mutable invincibility_duration: float;
}

type type_attack = None | Missile 

type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable aggro: type_attack;
}

type type_scoreboard = {
  mutable score: int;
}

val gui_window : type_gui
val player : type_player 
val scoreboard : type_scoreboard
