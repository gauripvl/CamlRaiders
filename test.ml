open OUnit2
open Dialogue

let dlg_json = Yojson.Basic.from_file "dialogues.json"
let dlgs = Dialogue.to_json dlg_json

let scripts_boss = Dialogue.get_scripts dlgs "boss"
let texts_boss_1 = [
  "...";
  "I feel a powerful force approaching...!"
]

let dialogue_tests =
  [
    (* test avatars*)
    "avatar 1"  >:: 
    (fun _ -> assert_equal "player_avatar" (
         Dialogue.get_avatar (List.nth scripts_boss 0)));
    "avatar 2"  >:: 
    (fun _ -> assert_equal "sphinx_avatar" (
         Dialogue.get_avatar (List.nth scripts_boss 1)));

    (* test speakers*)
    "speaker 1"  >:: 
    (fun _ -> assert_equal "Camel" (
         Dialogue.get_speaker (List.nth scripts_boss 0)));
    "speaker 2"  >:: 
    (fun _ -> assert_equal "Sphinx Guardian" (
         Dialogue.get_speaker (List.nth scripts_boss 1)));

    (* test texts *)
    "texts of 1"  >:: 
    (fun _ -> assert_equal texts_boss_1 (
         Dialogue.get_texts (List.nth scripts_boss 0)));
  ]

let suite =
  "test suite"  >::: List.flatten [
    dialogue_tests;
  ]

let _ = run_test_tt_main suite
