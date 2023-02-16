restart
add_force D -radix hex ABCDE
add_force EN 1
add_force LOAD 0
add_force CON 0
add_force CLK 0
run 10ns

add_force RST 1
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns

if {[get_value -radix unsigned Q] == [expr {0x0}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}


#1-bit left shift
add_force RST 0
run 10ns


add_force CLK 1
run 10ns
add_force CLK 0
run 10ns


if {[get_value -radix unsigned Q] == [expr {0x1579bc}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}

#1-bit right shift
add_force CON 1
run 10ns

add_force CLK 1
run 10ns
add_force CLK 0
run 10ns

if {[get_value -radix unsigned Q] == [expr {0x55e6f}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}