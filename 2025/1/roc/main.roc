app [main!] { pf: platform "./platform/main.roc" }

import pf.Stdout

input =
	\\L68
	\\L30
	\\R48
	\\L5
	\\R60
	\\L55
	\\L1

main! = || {
    for line in input.split_on("\n") {
	totalChars = List.walk lines 0 (add_rotation)
        # dir = get_direction(line)
        Stdout.line!(remove_first_char(line))
    }
    
}


get_direction : Str -> I8
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

add_rotation : I8, Str -> I8
add_rotation = |acc, line| {
    distance = remove_first_char(line).to_i8()?
    movement = get_direction(line).mul(distance)
    acc + movement
}
