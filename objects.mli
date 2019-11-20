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

type type_attack = None | Missile 

type type_enemy = {
  image: sprite;
  mutable health: int;
  mutable aggro: type_attack;
}

val gui_window : type_gui
val player : type_player 
(* val enemy : type_enemy *)
(* val bullet : sprite *)
