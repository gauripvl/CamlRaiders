open Sprite
open Objects
(* open Projectile *)

type t = sprite

(** [open_game_window w] opens a graphics window with 
    properties of [w] *) 
val open_game_window : type_gui -> unit 

(** [get_speed t] is the speed of [t] *)
val get_speed : t -> int

(** [get_pos t] is [(x,y)] where x is the x-coordinate of [t] 
    and y is the y-coordinate of [t] *)
val get_pos : t -> int * int

(** [get_x t] is the x-coordinate of [t] *)
val get_x : t -> int

(** [get_y t] is the y-coordinate of [t] *)
val get_y : t -> int

(** [create_image str] returns a transparent Graphics.image of 
    the png file named [str] in the assets/images directory *)
val create_image : string -> Graphics.image

(** [draw t] draws the image of [s] onto the GUI. *)
val draw : t -> unit

(** [lasers_list] is a reference to a list of sprites *)
val lasers_list : t list ref

(** [update_pos t] updates the position of the ship based on key presses. 
    Pressing 'w'moves the ship up, 'a' moves the ship left, 
    'd' moves the ship right, and 's' moves the ship down. 
    Pressing 'q' quits the game and any other key does nothing. *)
val update_pos : t -> unit

(** [draw_proj lst] draws each element of [lst] onto the gui *)
val draw_proj : t list -> unit

val print_st : string -> unit

(** [cleanup ()] removes laser sprites which are outside the 
    gui window boundaries from [lasers_list] *)
val cleanup : unit -> unit

