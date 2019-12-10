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

(** [draw_list lst] draws each sprite element of [lst] onto the GUI. *)
val draw_list : t list -> unit

(** [draw_projectiles lst] draws each projectile in [lst] onto the GUI. *)
val draw_projectiles : type_projectile list -> unit 

(** [draw_enemies lst] draws each enemy element of [lst] onto the gui. *)
val draw_enemies : type_enemy list -> unit

val draw_treasure : Treasure.type_treasure list -> unit

(** [draw_enemy_hp lst] draws the current health of each enemy in 
    [lst] onto the gui. *)
val draw_enemy_hp : type_enemy list -> unit

(** [draw_background ()] draws and moves the game background on 
    the GUI. *)
val draw_background : unit -> unit

(** [print_st str] prints [str] at the center of the game window *)
val print_st : string -> unit

(** [draw_scoreboard ()] draws the scoreboard with player's lives, 
    invincibility, current score, and inventory. *)
val draw_scoreboard : unit -> unit 

(** [draw_game_over_screen ()] draws the game over screen. *)
val draw_game_over_screen : unit -> unit

(** [draw_dialogue_container name lst] draws the dialogue with 
    speaker [name] and text of [lst]. *)
val draw_dialogue_container : string -> char list -> unit 

(** [draw_static ()] draws the scoreboard and player onto the GUI. *)
val draw_static : unit -> unit