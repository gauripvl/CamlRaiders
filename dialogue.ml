open Yojson.Basic.Util
open Gui

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

let is_dialogue_active = ref true 
let end_of_speech = ref false 

let string_to_list str = 
  List.init (String.length str) (String.get str)

let rec press_z () = 
  match Graphics.read_key () with 
  | 'z' -> true
  | _ -> press_z ()

(* draws speaker and text *)
let rec show_current_dialogue speaker avatar = function 
  | [] -> 
    end_of_speech := true;
  | h::t -> 
    let char_lst = string_to_list h in 
    draw_dialogue_container speaker avatar char_lst;
    if press_z () then (
      draw_static (); 
      show_current_dialogue speaker avatar t
    )

let rec show_next_dialogue = function 
  | [] -> is_dialogue_active := false
  | h::t -> 
    if not !end_of_speech then (
      let speaker = get_speaker h in 
      let avatar = get_avatar h in 
      let texts = get_texts h in 
      show_current_dialogue speaker avatar texts;
    ) else (
      if press_z () then (
        draw_static (); 
        show_next_dialogue t
      )
    )

let draw_script script_ref = 
  Unix.sleepf 0.05;
  draw_static ();
  if !is_dialogue_active then (
    end_of_speech := false;
    show_next_dialogue !script_ref;
    if not (List.length !script_ref = 0) then 
      script_ref := List.tl !script_ref
  )

let dlg_json = Yojson.Basic.from_file "dialogues.json"
let dlgs = to_json dlg_json
let scripts_of title = ref (get_scripts dlgs title)