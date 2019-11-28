open Yojson.Basic.Util

type script = {
  avatar : string;
  speaker : string;
  texts : string list;
}

type dialogue = {
  title : string;
  scripts : script list;
}

(** [script_json j] parses [j] to a record of type script. *)
let script_json j = {
  avatar = j |> member "avatar" |> to_string;
  speaker = j |> member "speaker" |> to_string;
  texts = j |> member "texts" |> to_list |> filter_string ;
}

(** [dialogue_json j] parses [j] to a record of type dialogue. *)
let dialogue_json j = {
  title = j |> member "title" |> to_string;
  scripts = j |> member "scripts" |> to_list |> List.map script_json;
}

