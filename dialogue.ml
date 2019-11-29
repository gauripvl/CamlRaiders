open Yojson.Basic.Util

exception UnknownTitle of string

type script = {
  avatar : string;
  speaker : string;
  texts : string list;
}

(** The type of dialogue. *)
type dialogue = {
  title : string;
  scripts : script list;
}

type t = {
  dialogues : dialogue list;
}

(** [script_json j] parses [j] to a record of type [script]. *)
let script_json j = {
  avatar = j |> member "avatar" |> to_string;
  speaker = j |> member "speaker" |> to_string;
  texts = j |> member "texts" |> to_list |> filter_string ;
}

(** [dialogue_json j] parses [j] to a record of type [dialogue]. *)
let dialogue_json j = {
  title = j |> member "title" |> to_string;
  scripts = j |> member "scripts" |> to_list |> List.map script_json;
}

let to_json j = {
  dialogues = j |> member "dialogues" |> to_list |> List.map dialogue_json;
}

(** [titles_helper lst] is a list of titles in [lst]. *)
let rec titles_helper = function
  | [] -> []
  | h::t -> h.title :: titles_helper t

(** [all_titles t] is a list of all unique titles in [t].*)
let all_titles t = 
  let lst = titles_helper t.dialogues in 
  List.sort_uniq Stdlib.compare lst

(** [all_scripts lst] is a list of all the scripts of each dialogue in [lst]*)
(* let rec all_scripts = function
   | [] -> []
   | h::t -> h.scripts :: all_scripts t *)

let get_scripts t title = 
  if List.mem title (all_titles t) then 
    let dlg = List.find (fun x -> x.title = title) t.dialogues in 
    dlg.scripts
  else raise (UnknownTitle title)

let get_avatar s = s.avatar 

let get_speaker s = s.speaker

let get_texts s = s.texts
