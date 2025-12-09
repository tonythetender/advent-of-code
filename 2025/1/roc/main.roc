app [main!] { pf: platform "./platform/main.roc" }

import pf.Stdout
# import List
# import "input.txt" as input : Str

input =
	\\L68
	\\L30
	\\R48
	\\L5
	\\R60
	\\L55
	\\L1

main! = || {
    lines = input.split_on("\n")
    init : I16
    init = 0
    total = List.fold(lines, init, add_rotation)
    Stdout.line!(total.to_str())
}


get_direction : Str -> I16
get_direction = |line| {
    dir = match line.contains("L") {
        True => -1
        False => 1
    }
    dir
}

remove_first_char : Str -> Str
remove_first_char = |s| {
	to_list = s.to_utf8()
	to_list.drop_at(0) -> Str.from_utf8_lossy()
}

add_rotation : I16, Str -> I16
add_rotation = |acc, line| {
    distanceStr = remove_first_char(line)
    distance = str_to_i16(distanceStr)
    movement = get_direction(line) * distance
    acc + movement
}


str_to_i16 : Str -> I16
str_to_i16 = |s| {
    bytes = Str.to_utf8(s)

    List.fold(bytes, 0, |acc, byte| {
        digit : I16
        digit = match byte {
                48 => 0
                49 => 1
                50 => 2
                51 => 3
                52 => 4
                53 => 5
                54 => 6
                55 => 7
                56 => 8
                57 => 9
                _  => 0
        }
        acc * 10 + digit
    })
}
