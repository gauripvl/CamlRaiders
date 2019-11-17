open Sprite
open Objects
(* open Projectile *)

type t = sprite

(** [open_game_window w] opens a graphics window with 
    properties of [w] *) 
val open_game_window : type_gui -> unit 

(** [get_speed t] is the speed of [t] *)
val get_speed : t -> int

(** [create_image str] returns a transparent Graphics.image of 
    the png file named [str] in the assets/images directory *)
val create_image : string -> Graphics.image

(** [draw t] draws the image of [s] onto the GUI. *)
val draw : t -> unit

(** [draw_list lst] draws each element of [lst] onto the gui *)
val draw_list : t list -> unit

(** [update_pos t] updates the position of the ship based on key presses. 
    Pressing 'w'moves the ship up, 'a' moves the ship left, 
    'd' moves the ship right, and 's' moves the ship down. 
    Pressing 'q' quits the game and any other key does nothing. *)
val update_pos : t -> unit

val print_st : string -> unit