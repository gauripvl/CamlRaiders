open OUnit2
open Dialogue
open Sprite 

let objects_tests = 
  [
    "gui window width"  >:: 
    (fun _ -> assert_equal 800 (Objects.gui_window.width));
    "gui window height"  >:: 
    (fun _ -> assert_equal 480 (Objects.gui_window.height));
    "initial player lives"  >:: 
    (fun _ -> assert_equal 3 (Objects.player.lives));
    "initial player image name"  >:: 
    (fun _ -> assert_equal "chibi_camel" (Objects.player.image.name));
    "initial scoreboard score"  >:: 
    (fun _ -> assert_equal 0 (Objects.scoreboard.score));
  ]

let sprite_onscreen = {
  img = None;
  name = "onscreen";
  height = 100;
  width = 100;
  speed = 2; 
  x = 10; 
  y = 20; 
}

let sprite_offscreen = {
  img = None;
  name = "offscreen";
  height = 100;
  width = 100;
  speed = 12; 
  x = 999; 
  y = 999; 
}

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

    (* TODO: test all quadrants, ie, above, below, over left, over right. *)
    "is_onscreen: sprite is within GUI bounds"  >:: 
    (fun _ -> assert_equal true (Utils.is_onscreen sprite_onscreen));
    "is_onscreen: sprite is not within GUI bounds"  >:: 
    (fun _ -> assert_equal false (Utils.is_onscreen sprite_offscreen));
  ]

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
  x = 7; 
  y = 3; 
}

let sprite_three = {
  img = None;
  name = "two";
  height = 42;
  width = 42;
  speed = 13; 
  x = 0; 
  y = 99; 
}

(* Sprite functions are tested through the GUI. *)
let sprite_tests = []

let collisions_tests = 
  [
    "collision_btn: normal overlap"  >:: 
    (fun _ -> assert_equal true (
         Collisions.collision_btn sprite_one sprite_two));
    "collision_btn: edge overlap"  >:: 
    (fun _ -> assert_equal true (
         Collisions.collision_btn sprite_one sprite_three));
    "collision_btn: no overlap"  >:: 
    (fun _ -> assert_equal false (
         Collisions.collision_btn sprite_two sprite_three));
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
    objects_tests;
    collisions_tests;
    dialogue_tests;
  ]

let _ = run_test_tt_main suite
