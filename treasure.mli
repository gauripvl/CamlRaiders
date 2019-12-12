open Sprite

(** [treasure_list] is a list of treasures that are on the screen *)
val treasure_list : sprite list ref

(** [collected_treasures] is a list of treasures that the player has picked
    up *)
val collected_treasures : sprite list ref

(** [power_list] is a list of power-ups that are on the screen *)
val power_list: sprite list ref

(** [power_ups] is a list of power-up names that are on the screen *)
val power_ups : string list ref

(** [source_treasures] is a list of the names of treasures *)
val source_treasures : string list ref

(* [random_treasure [treasures_ref] [enemy_list]] creates a random treasure
    using the ref list of treasures [treasure_ref] and [enemy_list]  *)
val random_treasure : 
  string list ref -> Enemy.type_enemy list -> sprite option

(* [add_treasure_to [list_enemy]] updates [treasure_list] with a new
   treasure *)
val add_treasure_to_list : Enemy.type_enemy list -> unit

(* [random_powerup [power_lst] [enemy_list]] is a random powerup using 
   the ref list of powerups [power_lst] and [enemy_list] *)
val random_powerup : string list ref -> Enemy.type_enemy list -> sprite option

(* [add_powerups_to_list [power_up]] updates [power_list] with a new
   power_up *)
val add_powerups_to_list : sprite option -> unit

(* [cleanup_power] deletes the power_up once it moves out of the screen *)
val cleanup_powerup : unit -> unit
