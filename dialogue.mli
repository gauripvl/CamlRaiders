
(** The abstract type of values representing the dialogue system. *)
type t

(** The type of script. *)
type script

(** Raised when an unknown title is processed. *)
exception UnknownTitle of string

(** [to_json j] is the dialogue that [j] represents.
    Requires: [j] is a valid JSON dialogue representation. *)
val to_json : Yojson.Basic.t -> t

(** [get_scripts t title] is a list of all the scripts with title [title]. 
    Requires: [title] is unique. *)
val get_scripts : t -> string -> script list 

(** [get_avatar s] is the image name of the avatar in [s]. *)
val get_avatar : script -> string

(** [get_speaker s] is the speaker in [s]. *)
val get_speaker : script -> string

(** [get_texts s] is the texts in [s]. *)
val get_texts : script -> string list 
