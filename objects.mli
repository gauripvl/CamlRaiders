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

type type_scoreboard = {
  width: int;
  height: int;
  mutable score: int;
}

val gui_window : type_gui
val player : type_player 
val scoreboard : type_scoreboard

(* val sprite_sky : sprite
   val sprite_foredunes : sprite
   val sprite_backdunes : sprite *)