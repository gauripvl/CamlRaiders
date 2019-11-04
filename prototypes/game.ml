(** [game_loop s e] updates the screen continuously to animate the game. *)
let rec game_loop ()= 
  Unix.sleepf 3.0;
  game_loop ()

let main () = 
  Graphics.open_graph " 640x480";
  Unix.sleepf 3.0;
  Graphics.close_graph ()

let () = main ()