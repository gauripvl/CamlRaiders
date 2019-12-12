(* ============== TEST PLAN ============== 
   CamlRaiders is a heavily GUI-based game so most functions either 
   return unit or are dependent on time, or in other words, the frame 
   rate of the game. Moreover, some functions can be called only when the 
   GUI is opened else a Graphics exception is raised. This way, most 
   functions are tested by play-testing. 

   Modules with functions which return a value are tested in tests 
   suites in this file, test.ml through glass-box testing.
   The following modules consist almost entirely of unit functions and have 
   been tested through play-testing in the GUI: 
   - Background
   - Boss
   - Commands
   - Sprite
   - Gui
   - Enemy
   - Stage
   - Treasure

   The modules that are tested in this file: 
   - Objects
   - Dialogue
   - Projectile
   - Collisions
   - Utils

   Other notes: 
   Objects module stores the main objects of our game: 
   the GUI window, the player, and the scoreboard. Each object can be 
   mutated. These mutations are tested by play-testing our game 
   on the GUI. The non-mutablable fields and initial values of our 
   objects are tested in the [objects_tests] test set. 

   Utils module contain general functions that are repeatedly used 
   in other modules. The functions [timer] and [switch_duration] are 
   time-dependent and are tested by play-testing. The [random_int] 
   function is dependent on probability and cannot be tested 
   effectively by assertions. The functions [is_btn] and [on_screen] 
   gives a concrete value and are tested in the [utils_tests] test set.
*)

open OUnit2
open Dialogue
open Sprite 

let objects_tests = [
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

(* The sprites below are used to test functions in [utils_tests] test set. *)
let sprite_onscreen = {
  img = None;
  name = "onscreen";
  height = 100;
  width = 100;
  speed = 2; 
  x = 10; 
  y = 20; 
}

let sprite_offscreen_left = {
  img = None;
  name = "test";
  height = 100;
  width = 100;
  speed = 2; 
  x = ~-99; 
  y = 20; 
}

let sprite_offscreen_right = {
  img = None;
  name = "test";
  height = 100;
  width = 100;
  speed = 2; 
  x = 999; 
  y = 20; 
}

let sprite_offscreen_up = {
  img = None;
  name = "test";
  height = 100;
  width = 100;
  speed = 2; 
  x = 20; 
  y = 999; 
}

let sprite_offscreen_down = {
  img = None;
  name = "test";
  height = 100;
  width = 100;
  speed = 2; 
  x = 20; 
  y = ~-999; 
}

let utils_tests = [
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

  "is_onscreen: sprite is within GUI bounds"  >:: 
  (fun _ -> assert_equal true (Utils.is_onscreen sprite_onscreen));
  "is_onscreen: sprite offset to the left is not within GUI bounds"  >:: 
  (fun _ -> assert_equal false (Utils.is_onscreen sprite_offscreen_left));
  "is_onscreen: sprite offset to the right is not within GUI bounds"  >:: 
  (fun _ -> assert_equal false (Utils.is_onscreen sprite_offscreen_right));
  "is_onscreen: sprite offset above window is not within GUI bounds"  >:: 
  (fun _ -> assert_equal false (Utils.is_onscreen sprite_offscreen_up));
  "is_onscreen: sprite offset below window is not within GUI bounds"  >:: 
  (fun _ -> assert_equal false (Utils.is_onscreen sprite_offscreen_down));
]

(* The sprites below are used to test functions in [collisions_tests] 
   test set. *)
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

let sprite_four = {
  img = None;
  name = "two";
  height = 42;
  width = 42;
  speed = 13; 
  x = 41; 
  y = 99; 
}

let sprite_five = {
  img = None;
  name = "two";
  height = 42;
  width = 42;
  speed = 13; 
  x = 41; 
  y = 58; 
}


let collisions_tests = [
  "collision_btn: normal overlap"  >:: 
  (fun _ -> assert_equal true (
       Collisions.collision_btn sprite_one sprite_two));
  "collision_btn: no overlap"  >:: 
  (fun _ -> assert_equal false (
       Collisions.collision_btn sprite_two sprite_three));
  "collision_btn: top edge overlap"  >:: 
  (fun _ -> assert_equal true (
       Collisions.collision_btn sprite_one sprite_three));
  "collision_btn: bottom edge overlap"  >:: 
  (fun _ -> assert_equal true (
       Collisions.collision_btn sprite_five sprite_four));
  "collision_btn: right edge overlap"  >:: 
  (fun _ -> assert_equal true (
       Collisions.collision_btn sprite_four sprite_three));

  "treasure_points: coin"  >:: 
  (fun _ -> assert_equal 42 (Collisions.treasure_points "coin"));
  "treasure_points: lily"  >:: 
  (fun _ -> assert_equal 60 (Collisions.treasure_points "lily"));
  "treasure_points: crown"  >:: 
  (fun _ -> assert_equal 100 (Collisions.treasure_points "crown"));
  "treasure_points: diamond"  >:: 
  (fun _ -> assert_equal 200 (Collisions.treasure_points "diamond"));
  "treasure_points: empty string"  >:: 
  (fun _ -> assert_equal 0 (Collisions.treasure_points ""));
  "treasure_points: invalid treasure"  >:: 
  (fun _ -> assert_equal 0 (Collisions.treasure_points "tears of pain"));
  "treasure_points: whitespace"  >:: 
  (fun _ -> assert_equal 0 (Collisions.treasure_points "  "));
]

let dlg_json = Yojson.Basic.from_file "dialogues.json"
let dlgs = Dialogue.to_json dlg_json

let scripts_boss = Dialogue.get_scripts dlgs "boss"
let texts_boss_1 = [
  "...";
  "What's this?!";
  "I feel a powerful force approaching...!";
  "We must be careful!"
]
let texts_boss_2 = [
  "* appears *";
  "R A W W W R !!";
  "All those who trepass shall face my wrath!"
]

let dialogue_tests = [
  (* test avatars*)
  "avatar camel"  >:: 
  (fun _ -> assert_equal "avatar_camel" (
       Dialogue.get_avatar (List.nth scripts_boss 0)));
  "avatar boss"  >:: 
  (fun _ -> assert_equal "avatar_boss" (
       Dialogue.get_avatar (List.nth scripts_boss 1)));

  (* test speakers*)
  "speaker camel"  >:: 
  (fun _ -> assert_equal "Camel" (
       Dialogue.get_speaker (List.nth scripts_boss 0)));
  "speaker boss"  >:: 
  (fun _ -> assert_equal "Final Boss Guardian" (
       Dialogue.get_speaker (List.nth scripts_boss 1)));

  (* test texts *)
  "texts of camel"  >:: 
  (fun _ -> assert_equal texts_boss_1 (
       Dialogue.get_texts (List.nth scripts_boss 0)));
  "texts of boss"  >:: 
  (fun _ -> assert_equal texts_boss_2 (
       Dialogue.get_texts (List.nth scripts_boss 1)));

  (* test scripts *)
  "script of unknown title"  >:: 
  (fun _ -> assert_raises (UnknownTitle "invalidtitle") 
      (fun _ -> (Dialogue.get_scripts dlgs "invalidtitle")));
  "script of empty title"  >:: 
  (fun _ -> assert_raises (UnknownTitle "") 
      (fun _ -> (Dialogue.get_scripts dlgs "")));
  "script of blank title"  >:: 
  (fun _ -> assert_raises (UnknownTitle "  ") 
      (fun _ -> (Dialogue.get_scripts dlgs "  ")));
]

let projectile_tests = [
  "dir_vector btn two sprites"  >:: 
  (fun _ -> assert_equal (7.0,3.0) 
      (Projectile.dir_vector sprite_one sprite_two));
  "dir_vector of the same sprite"  >:: 
  (fun _ -> assert_equal (0.0,0.0) 
      (Projectile.dir_vector sprite_two sprite_two));
  "dir_vector negative"  >:: 
  (fun _ -> assert_equal (0.0,-99.0) 
      (Projectile.dir_vector sprite_three sprite_one));
  "dir_vector btn two sprites with positive values"  >:: 
  (fun _ -> assert_equal (3.0,17.0) 
      (Projectile.dir_vector sprite_two sprite_onscreen));
  "dir_vector of two sprites with position (0,0)"  >:: 
  (fun _ -> assert_equal (0.0,0.0) 
      (Projectile.dir_vector sprite_one sprite_one));

  "unit_vector of (3.,4.)"  >:: 
  (fun _ -> assert_equal (0.6,0.8) (Projectile.unit_vector (3.,4.)));
  "unit_vector of (-3.,4.)"  >:: 
  (fun _ -> assert_equal (-0.6,0.8) (Projectile.unit_vector (-3.,4.)));
  "unit_vector of (-3.,-4.)"  >:: 
  (fun _ -> assert_equal (-0.6,-0.8) (Projectile.unit_vector (-3.,-4.)));  
  "unit_vector of (8.,0.)"  >:: 
  (fun _ -> assert_equal (1.,0.) (Projectile.unit_vector (8.,0.)));  
  "unit_vector of (0.,-6.)"  >:: 
  (fun _ -> assert_equal (0.,-1.) (Projectile.unit_vector (0.,-6.)));  
]

let suite =
  "test suite"  >::: List.flatten [
    utils_tests;
    objects_tests;
    collisions_tests;
    dialogue_tests;
    projectile_tests;
  ]

let _ = run_test_tt_main suite
