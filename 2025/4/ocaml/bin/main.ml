let isRoll value =
    match value with
    | '@' -> true
    | _ -> false


(* let print_list to_string l = *)
(*     let rec loop rem acc = *)
(*         match rem with *)
(*         | [] -> acc *)
(*         | [s] -> acc ^ (to_string s) *)
(*         | (s::ss) -> *)
(*             loop ss (acc ^ (to_string s) ^ "; ") in *)
(*     print_string "["; *)
(*     print_string (loop l ""); *)
(*     print_endline "]" *)

(* let print_str_list = print_list (fun s -> "\"" ^ s ^ "\"") *)
(* let print_char_list = print_list (fun c -> "'" ^ String.make 1 c ^ "'") *)
(* let print_int_list = print_list string_of_int *)
(* let print_float_list = print_list string_of_float *)


let rec countRolls line currentIndex targetIndex totalCount targetedLine =
    if currentIndex > targetIndex + 1 then totalCount else
    match line with
    | [] -> totalCount
    | [x] -> if currentIndex == targetIndex && isRoll x == false && targetedLine then 69
                else if currentIndex == targetIndex && isRoll x && targetedLine then totalCount 
                else if isRoll x then (totalCount + 1) 
                else totalCount
    | x::y -> 
    if currentIndex == targetIndex && isRoll x == false && targetedLine then 69 else
    if currentIndex == targetIndex - 1 || currentIndex == targetIndex || currentIndex == targetIndex + 1 then
        if currentIndex = targetIndex && targetedLine then countRolls y (currentIndex + 1) targetIndex totalCount targetedLine else
        match isRoll x with
        | true -> countRolls y (currentIndex + 1) targetIndex (totalCount + 1) targetedLine
        | false -> countRolls y (currentIndex + 1) targetIndex totalCount targetedLine
    else countRolls y (currentIndex + 1) targetIndex totalCount targetedLine


let process2Lines line1 line2 target =
  let acc = ref 0 in
  for i = 0 to List.length line1 - 1 do
    if target = 0 then begin
      let c1 = countRolls line1 0 i 0 true in
      let c2 = countRolls line2 0 i 0 false in
      if c1 + c2 < 4 then
        incr acc
    end else begin
      let c1 = countRolls line1 0 i 0 false in
      let c2 = countRolls line2 0 i 0 true in
      if c1 + c2 < 4 then
        incr acc
    end
  done;
  !acc

let process3Lines line1 line2 line3 =
  let acc = ref 0 in
  for i = 0 to List.length line1 - 1 do
      let c1 = countRolls line1 0 i 0 false in
      let c2 = countRolls line2 0 i 0 true in
      let c3 = countRolls line3 0 i 0 false in
      if c1 + c2 + c3 < 4 then
        incr acc
  done;
  !acc

let rec remove_last l =
  match l with
  | [] -> []
  | [_] -> []
  | hd :: tl -> hd :: (remove_last tl)

let solve1 file =
    let rec processFile file rollFound =
        match file with
        | line1 :: line2 :: line3 :: (_ :: _ as rest) -> processFile (line2 :: line3 :: rest) (rollFound + (process3Lines line1 line2 line3))
        | [line1; line2; line3] ->  processFile [line2;line3] (rollFound + (process3Lines line1 line2 line3))
        | [line1; line2] -> processFile [line2] (rollFound + (process2Lines line1 line2 1))
        | [_] -> rollFound
        | [] -> rollFound in
    let lines : string list = String.split_on_char '\n' file in
    let file_chars : char list list =
        List.map
            (fun (s : string) -> List.of_seq (String.to_seq s))
            lines
    in
    let trimmed = remove_last file_chars in
    match trimmed with
    | line1 :: line2 :: line3 :: (_ :: _ as rest) -> processFile (line1 :: line2 :: line3 :: rest) (process2Lines line1 line2 0)
    | _ -> 0


let read_file filename =
  let ic = open_in filename in
  let len = in_channel_length ic in
  let content = really_input_string ic len in
  close_in ic;
  content

let () =
  let content = read_file "../input.txt" in
  let result = solve1 content in
  Printf.printf "%d\n" result
