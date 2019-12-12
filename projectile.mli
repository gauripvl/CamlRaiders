open Sprite 

(** [type_projectile] is the type of a projectile in our game. *)
type type_projectile = {
  image: sprite;
  vector: float * float;
}

(** [lasers_list] is a reference to a list of player's projectiles. *)
val lasers_list : type_projectile list ref

(** [enemy_atks] is a reference to a list of enemy projectiles. *)
val enemy_atks : type_projectile list ref

(** [create_projectile str spd origin v] is a projectile with 
    image [str], speed [spd], having the same initial position 
    as [origin], and a vector [v]. *)
val create_projectile : string -> int -> sprite -> float * float -> type_projectile

(** [dir_vector a b] is the vector that points from [a] to [b]. *)
val dir_vector : sprite -> sprite -> float * float 

(** [unit_vector v] is the unit vector of [v]. *)
val unit_vector : float * float -> float * float

(** [create_enemy_atks lst] creates a suitable projectile based on the enemy's 
    attack type and adds the newly created projectile to [enemy_atks]. *)
val create_enemy_atks : Enemy.type_enemy list -> unit

(** [move_projectiles lst] moves each projectile of [lst]. *)
val move_projectiles : type_projectile list -> unit

(** [cleanup_projectiles lst] removes sprites which are outside the 
    gui window boundaries from [lst] *)
val cleanup_projectiles : unit -> unit