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

val binary_red_atks: Projectile.type_projectile list ref
val binary_black_atks: Projectile.type_projectile list ref
val boss_attack_timer: float ref

val create_boss_atk: type_boss -> unit

val boss_rbbinary : type_boss