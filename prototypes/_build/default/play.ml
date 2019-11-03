open Unix
open Graphics
open Png
open Sprite

let update_pos s = 
  if key_pressed () then 
    match read_key () with 
    | 'w' -> s.y <- Sprite.get_y s + Sprite.get_speed s
    | 'a' -> s.x <- s.x - s.speed
    | 's' -> s.y <- s.y - s.speed
    | 'd' -> s.x <- s.x + s.speed
    | 'q' -> exit 0
    | _ -> ()

let move_enemy e = 
  e.y <- e.y - e.speed

let draw s = draw_image s.img s.x s.y

let rec game_loop s e = (* later make e a list of enemies rather than a single enemy *)
  sleepf 0.05;
  update_pos s;
  move_enemy e;
  clear_graph ();
  draw s;
  draw e;
  game_loop s e

let main () = 
  open_graph " 640x480";
  let img_camel = 
    load_as_rgb24 "assets/images/camel.png" [] 
    |> Graphic_image.of_image 
    |> Sprite.img_to_transp in 
  let player = { speed = 8; img = img_camel; x = 320; y = 240; } in 
  let enemy = { speed = 1; img = create_image 50 50; x = 100; y = 400; } in
  draw player;
  draw enemy;
  game_loop player enemy

let () = main ()