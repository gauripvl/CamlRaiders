module type SpriteSig = sig
  type t

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

end

module type Player = sig
  module Sprite : SpriteSig
  type t

  (** [update_pos t] updates the position of the ship based on key presses. 
      Pressing 'w'moves the ship up, 'a' moves the ship left, 
      'd' moves the ship right, and 's' moves the ship down. 
      Pressing 'q' quits the game and any other key does nothing. *)
  val update_pos : t -> unit

end

module type PlayerMaker =
  functor (S : SpriteSig)
    -> Player with module Sprite = S

module Make : PlayerMaker