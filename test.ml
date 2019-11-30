open OUnit2
open Dialogue

let utils_tests = 
  [
    "is_btn: edge case min, int"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 2 42 2));
    "is_btn: edge case max, int"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 2 42 42));
    "is_btn: not btn bounds, int"  >:: 
    (fun _ -> assert_equal false (Utils.is_btn 2 42 3110));
    "is_btn: normal case, int"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 2 42 12));
    "is_btn: restricted bounds, int"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 0 0 0));

    "is_btn: edge case min, float"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 2. 42. 2.));
    "is_btn: edge case max, float"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 2. 42. 42.));
    "is_btn: not btn bounds, float"  >:: 
    (fun _ -> assert_equal false (Utils.is_btn 2. 42. 3110.));
    "is_btn: normal case, float"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 2. 42. 12.));
    "is_btn: restricted bounds, float"  >:: 
    (fun _ -> assert_equal true (Utils.is_btn 0. 0. 0.));
  ]

open Sprite 
(* TODO *)
let sprite_one = {
  img = None;
  name = "one";
  height = 100;
  width = 20;
  speed = 12; 
  x = 0; 
  y = 0; 
}

let sprite_two = {
  img = None;
  name = "two";
  height = 20;
  width = 80;
  speed = 4; 
  x = 320; 
  y = 240; 
}

let sprite_three = {
  img = None;
  name = "two";
  height = 42;
  width = 42;
  speed = 13; 
  x = 320; 
  y = 240; 
}

(* Sprite.create_image is tested through the GUI. *)
let sprite_tests = 
  [
    (* "initial player lives"  >:: 
       (fun _ -> assert_equal true (Collisions.collision_btn)); *)
  ]

let objects_tests = 
  [
    "initial player lives"  >:: 
    (fun _ -> assert_equal 3 (Objects.player.lives));
  ]

let collisions_tests = 
  [
    (* "collision_btn: normal overlap"  >:: 
       (fun _ -> assert_equal true (Collisions.collision_btn));
        "collision_btn: edge overlap"  >:: 
       (fun _ -> assert_equal true (Collisions.collision_btn));
        "collision_btn: no overlap"  >:: 
       (fun _ -> assert_equal false (Collisions.collision_btn)); *)
  ]

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
    utils_tests;
    dialogue_tests;
  ]

let _ = run_test_tt_main suite
