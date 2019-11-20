(* open Objects
   open Projectile
   open Gui
   open Sprite

   let timer = ref 5.0

   let rec game_loop () = 
   Unix.sleepf 0.05;
   update_pos player.image;
   move_projectiles !lasers_list;
   Graphics.clear_graph ();
   draw player.image;
   draw_list !lasers_list;
   if (!timer > 0.0) then print_st "you lost"; timer := !timer -. 0.1;
   game_loop ()


   let main () = 
   open_game_window gui_window;
   draw player.image;
   player.image.img <- Some (create_image player.image.name);
   set_image_dimensions player.image;
   game_loop ()

   let test () = 
   Graphics.open_graph " 640x480"

   let () = main () *)
