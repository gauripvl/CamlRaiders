open Sprite

(** [type_gui] is the type of the game GUI. Holds information 
    about the dimensions and the title of the game GUI. *)
type type_gui = {
  width : int;
  height : int;
  title : string;
}

(** [type_powerup] is the type of powerup in our game. *)
type type_powerup = Neutral | TripleLasers

(** [type_player] is the type of the player. *)
type type_player = {
  image: sprite;
  mutable lives: int;
  mutable level: int;
  mutable power: int;
  mutable invincible: bool;
  mutable invincibility_duration: float;
  mutable powerup: type_powerup;
}

(** [type_scoreboard] is the type of the scoreboard. Holds information 
    about the dimensions of the scoreboard and the current score. *)
type type_scoreboard = {
  width: int;
  height: int;
  mutable score: int;
}

(** [gui_window] returns the properties of the GUI window. *)
val gui_window : type_gui

(** [player] is the player. *)
val player : type_player 

(** [scoreboard] returns the properties of the scoreboard. *)
val scoreboard : type_scoreboard
