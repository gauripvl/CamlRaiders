(** [start_game ()] displays the title screen *)
val start_game : unit -> unit 

(** [loop_minion_stage ()] is the stage where random minion enemies spawn. *)
val loop_minion_stage : unit -> unit

(** [boss_dialogue ()] is the stage before a boss battle. *)
(* val boss_dialogue : unit -> unit *)

(** [boss_stage ()] is the boss stage. *)
val boss_stage : Boss.type_boss -> unit

(** [loop_game ()] runs the game and chooses stages according to 
    the status of the game *)
val loop_game : unit -> unit 