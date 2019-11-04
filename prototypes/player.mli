module type Player = sig

  type t

  (* ================= COMMON SPRITE FIELDS ================= *)

  (** [get_speed t] is the speed of [t] *)
  val get_speed : t -> int

  (** [get_x t] is the x-coordinate of [t] *)
  val get_x : t -> int

  (** [get_y t] is the y-coordinate of [t] *)
  val get_y : t -> int

  (** [img_to_transp i] is [i] with black color 
      changed to [transp] *)
  val img_to_transp : Graphics.image -> Graphics.image

  (** [draw t] draws the image of [s] onto the GUI. *)
  val draw : t -> unit

  (* ================= COMMON SPRITE FIELDS (END) ================= *)

  (** [update_pos t] updates the position of the ship based on key presses. 
      Pressing 'w'moves the ship up, 'a' moves the ship left, 
      'd' moves the ship right, and 's' moves the ship down. 
      Pressing 'q' quits the game and any other key does nothing. *)
  val update_pos : t -> unit

end