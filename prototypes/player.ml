(* TODO *)

(* module type Player = sig
   type t
   val get_speed : t -> int
   val get_x : t -> int
   val get_y : t -> int
   val img_to_transp : Graphics.image -> Graphics.image
   val draw : t -> unit
   val update_pos : t -> unit
   end *)

module Player = 
struct 
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