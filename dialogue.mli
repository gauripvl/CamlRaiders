
(** The abstract type of values representing adventures. *)
type dialogue

(** [dialogue_json j] is the dialogue that [j] represents.
    Requires: [j] is a valid JSON dialogue representation. *)
val dialogue_json : Yojson.Basic.t -> dialogue