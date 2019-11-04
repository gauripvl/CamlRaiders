module type Sprite = sig

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

end