open Sprite 

(** [quit_game ()] exits the game window when the key 'q' is pressed 
    on the keyboard *)
val quit_game : unit -> unit 

(** [update_pos s] updates the position of the ship based on key presses. 
    Pressing 'w'moves the ship up, 'a' moves the ship left, 
    'd' moves the ship right, and 's' moves the ship down. 
    Pressing 'q' quits the game and any other key does nothing. *)
val update_pos : sprite -> unit

(** [shoot_laser s] allows player to shoot lasers when the mouse 
    button is held down *)
val shoot_laser : sprite -> unit
