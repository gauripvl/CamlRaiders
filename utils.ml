let timer f a duration t = 
  if (!duration <= 0.0) then (f a; duration := t)
  else duration := !duration -. 0.1

let get_rand_x bound = 
  Random.self_init ();
  Random.int bound
