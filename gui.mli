open Sprite
open Objects
open Projectile
open Enemy 

type t = sprite

(** [open_game_window w] opens a graphics window with 
    properties of [w] *) 
val open_game_window : type_gui -> unit 

(** [get_speed t] is the speed of [t] *)
val get_speed : t -> int

(** [draw t] draws the image of [s] onto the GUI. *)
val draw : t -> unit

(** [draw_list lst] draws each sprite element of [lst] onto the gui *)
val draw_list : t list -> unit

val draw_projectiles : type_projectile list -> unit 

(** [draw_create_list lst] creates an image and 
    draws each sprite element of [lst] onto the gui *)
(* val draw_create_list : t list -> unit *)

(** [draw_enemies lst] draws each enemy element of [lst] onto the gui *)
val draw_enemies : type_enemy list -> unit

(** [print_st str] prints [str] at the center of the game window *)
val print_st : string -> unit

val draw_scoreboard : unit -> unit 

val draw_game_over_screen : unit -> unit
