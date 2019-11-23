(** [start_game ()] displays the title screen *)
val start_game : unit -> unit 

(** [loop_minion_stage ()] *)
val loop_minion_stage : unit -> unit

(** [loop_game ()] runs the game and chooses stages according to 
    the status of the game *)
val loop_game : unit -> unit 