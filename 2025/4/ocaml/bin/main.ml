(* open Sys *)

(* let () = *)
(*     let filename = Sys.argv(1) in *)
(*     let chalNumber = Sys.argv(2) in *)
(*     let file = input_file filename *)


let solve file chalNumber =
    match chalNumber with
    | 1 -> solve1 file
    | 2 -> solve2 file
    | _ -> ""

let solve1 file =
    let rec processFile file rollFound =
        match file with
        | [line1::"\n"::line2::"\n"::line3::"\n"::x] -> processFile (line2::"\n"::line3::"\n"::x) (processLine line1 line2 lin3 rollFound)
        | [] -> rollFound
    processFile file 0



(* let processLine line currentRoll = *)
(*     | ["@"::x] ->  *)

let atIndex line =
    let rec atIndexCounter line counter =
        match line with
        | ["@"::x] -> Some(counter)
        | [y::x] -> atIndexCounter x (counter + 1)
        | ["@"] -> Some(counter)
        | [_] -> None in
    atIndexCounter line 0


