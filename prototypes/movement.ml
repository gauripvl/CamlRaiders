open Graphics
(* open Unix *)

type sprite = {
  img: image;
  speed: int;
  mutable x: int;
  mutable y: int;
}

type enemy = {
  img: image;
  speed: int;
  mutable x: int;
  mutable y: int;
}

let update_pos s = 
  if key_pressed () then 
    match read_key () with 
    | 'w' -> s.y <- s.y + s.speed
    | 'a' -> s.x <- s.x - s.speed
    | 's' -> s.y <- s.y - s.speed
    | 'd' -> s.x <- s.x + s.speed
    | 'q' -> exit 0
    | _ -> ()

let rec game_loop s e = (* later make e a list of enemies rather than a single enemy *)
  (* sleepf 0.005; *)
  update_pos s;
  clear_graph ();
  draw_image s.img s.x s.y;
  draw_image e.img e.x e.y;
  game_loop s e

let init s = draw_image s.img s.x s.y

let main () = 
  open_graph " 640x480";
  let player = { speed = 8; img = create_image 50 50; x = 320; y = 240; } in 
  let enemy = { speed = 5; img = create_image 50 50; x = 100; y = 100; } in
  init player;
  init enemy;
  game_loop player enemy

let () = main ()