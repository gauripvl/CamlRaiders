(* TODO *)
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
(* type obj *)

val init_player : type_player 
val init_enemy : type_enemy
