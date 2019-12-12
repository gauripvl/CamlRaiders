type type_boss_attack = 
  | BinaryStar 
  | BinaryBullet
  | BinaryChaos

type type_boss = {
  image: Sprite.sprite;
  mutable health: int;
  mutable attacks: type_boss_attack list;
  attack_freq: float;
}

(** [spawn_boss name hp:hp atk_types:atks freq:freq] spawns a boss with 
    name [name], hp of [hp], attack types of [atks] 
    and attack frequency of [freq]. *) 
val spawn_boss: string -> hp:int -> atk_types:type_boss_attack list -> freq:float -> type_boss

(** [binary_red_atks] is a list of all of the boss's red attacks *)
val binary_red_atks: Projectile.type_projectile list ref
(** [binary_black_atks] is a list of all of the boss's black attacks *)
val binary_black_atks: Projectile.type_projectile list ref
(** [boss_attack_timer] is the amount of time between each of the boss's 
    attacks *)
val boss_attack_timer: float ref

(** [create_boss_atk boss] creates an attack for [boss] from the types of boss 
    attacks *)
val create_boss_atk: type_boss -> unit

(** [move_boss b] moves [b] on the GUI. *)
val move_boss: type_boss -> unit

(** [boss_rbbinary] spawns a boss with BinaryStar adn BinaryBullet attacks *)
val boss_rbbinary : type_boss