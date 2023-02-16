restart

add_force D -radix hex 1234
add_force EN 1
add_force CLK 0
run 10ns

add_force RST 1
run 10ns

add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns

#check if the result is correct
if {[get_value -radix unsigned Q] == [expr {0x0}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}

add_force RST 0
run 10ns

add_force CLK 0
run 10ns
add_force CLK 1
run 10ns

if {[get_value -radix unsigned Q] == [expr {0x1234}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}

add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns

add_force RST 1
run 10ns

add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns
add_force CLK 0
run 10ns
add_force CLK 1
run 10ns