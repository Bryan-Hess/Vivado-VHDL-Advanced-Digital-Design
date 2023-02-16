restart

#TEST CASE 1
add_force A -radix hex FEDCBA98
add_force B -radix hex F1234567

#10 nanosecond clk
add_force clk 1 {0 5ns} -repeat_every 10ns

#reset
add_force rst 0
run 5ns
add_force rst 1
run 5 ns
add_force rst 0

#Cycle count
variable cnt 1

run 10 ns

#Runs indefinately until finihsed
while {[get_value -radix bin done] != 1} {
incr cnt
run 10 ns
}

#Cycles and pass/fail
puts "no. of clock cycles is $cnt"
if {[get_value -radix unsigned r] == [expr {0xFEDCBA98 * 0xF1234567}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}

#TEST CASE 2
add_force A -radix hex ABCDEF90
add_force B -radix hex 12345678

#10 nanosecond clk
add_force clk 1 {0 5ns} -repeat_every 10ns

#reset
add_force rst 0
run 5ns
add_force rst 1
run 5 ns
add_force rst 0

#Cycle count
variable cnt 1

run 10 ns

#Runs indefinately until finihsed
while {[get_value -radix bin done] != 1} {
incr cnt
run 10 ns
}

#Cycles and pass/fail
puts "no. of clock cycles is $cnt"
if {[get_value -radix unsigned r] == [expr {0xABCDEF90 * 0x12345678}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}

#TEST CASE 3
add_force A -radix hex FFFFFFFF
add_force B -radix hex FFFFFFFF

#10 nanosecond clk
add_force clk 1 {0 5ns} -repeat_every 10ns

#reset
add_force rst 0
run 5ns
add_force rst 1
run 5 ns
add_force rst 0

#Cycle count
variable cnt 1

run 10 ns

#Runs indefinately until finihsed
while {[get_value -radix bin done] != 1} {
incr cnt
run 10 ns
}

#Cycles and pass/fail
puts "no. of clock cycles is $cnt"
if {[get_value -radix unsigned r] == [expr {0xFFFFFFFF * 0xFFFFFFFF}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}


#TEST CASE 4
add_force A -radix hex 00000000
add_force B -radix hex 00000000

#10 nanosecond clk
add_force clk 1 {0 5ns} -repeat_every 10ns

#reset
add_force rst 0
run 5ns
add_force rst 1
run 5 ns
add_force rst 0

#Cycle count
variable cnt 1

run 10 ns

#Runs indefinately until finihsed
while {[get_value -radix bin done] != 1} {
incr cnt
run 10 ns
}

#Cycles and pass/fail
puts "no. of clock cycles is $cnt"
if {[get_value -radix unsigned r] == [expr {0x00000000 * 0x00000000}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}


#TEST CASE 5
add_force A -radix hex 01020304
add_force B -radix hex 0F0E0D0C

#10 nanosecond clk
add_force clk 1 {0 5ns} -repeat_every 10ns

#reset
add_force rst 0
run 5ns
add_force rst 1
run 5 ns
add_force rst 0

#Cycle count
variable cnt 1

run 10 ns

#Runs indefinately until finihsed
while {[get_value -radix bin done] != 1} {
incr cnt
run 10 ns
}

#Cycles and pass/fail
puts "no. of clock cycles is $cnt"
if {[get_value -radix unsigned r] == [expr {0x01020304 * 0x0F0E0D0C}]} {
	puts "Correct!"
} else {
	puts "Wrong!"
}