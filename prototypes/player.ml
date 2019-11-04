(* TODO *)

module type SpriteSig = sig
  type t
  val get_speed : t -> int
  val get_x : t -> int
  val get_y : t -> int
  val img_to_transp : Graphics.image -> Graphics.image
  val draw : t -> unit
end

module type Player = sig
  module Sprite : SpriteSig
  type t
  val update_pos : t -> unit
end

module type PlayerMaker =
  functor (S : SpriteSig)
    -> Player with module Sprite = S

module Make : PlayerMaker
  = functor (S : SpriteSig) ->
  struct
    module Sprite = S
    type sprite = S.t
    exception Failure

    (** AF: TODO
        RI: TODO *)
    type t = {
      img: Graphics.image;
      mutable lives: int;
      speed: int;
      mutable x: int;
      mutable y: int;
    }

    let get_speed t =
      t.speed

    let get_x t =
      t.x

    let get_y t =
      t.y 

    let draw t = Graphics.draw_image t.img t.x t.y

    let update_pos t = 
      if Graphics.key_pressed () then 
        match Graphics.read_key () with 
        | 'w' -> t.y <- t.y + t.speed
        | 'a' -> t.x <- t.x - t.speed
        | 's' -> t.y <- t.y - t.speed
        | 'd' -> t.x <- t.x + t.speed
        | 'q' -> exit 0
        | _ -> ()
  end

module type PlayerMaker =
  functor (S : SpriteSig)
    -> Player with module Sprite = S