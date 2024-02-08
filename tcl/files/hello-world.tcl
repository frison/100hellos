#!/usr/bin/env tclsh

set H "H"
set e "e"
set l "l"
set o "o"
set W "W"
set r "r"
set d "d"
set excl "!"

proc string_repeat {s n} {
    set res ""
    for {set i 0} {$i < $n} {incr i} {
        append res $s
    }
    return $res
}

set ll [string_repeat $l 2]
puts "$H$e$ll$o $W$o$r$l$d$excl"
