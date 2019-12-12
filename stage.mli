(** [loop_minion_stage ()] is the stage where random minion enemies spawn. *)
val loop_minion_stage : unit -> unit

(** [boss_stage b] is the boss stage with [b] as the boss. *)
val boss_stage : Boss.type_boss -> unit

(** [loop_game ()] runs the game and chooses stages according to 
    the status of the game *)
val loop_game : unit -> unit 