# restart the simulation
restart

#top-level CPU testbench is named cpu_tb
#this instruction will add the internal signals and ports of a component name U_1, which in this case is the memory block.
#this should be replaced by the name of the componenet in your top-level testbench
add_wave {{/cpu_tb/U_1}}

#addi $7 $0 17 #SW address
#ori $1 $0 75 #Divisor
#ori $2 $0 7 #Dividend
#DivideAgain: 
bltzal $1 afterDiv #Once <0, Jump to:FinishedDivision
#sub $1 $1 $2
#addi $3 $3 1
#j DivideAgain

#FinishedDivision
#addi $3 $3 -1
#sw $3 27($7)

# you can use any of the following commands as an example on how to initilaize a memory location with a value
# the first 4 memory locations are initialized with the instruction codes correpsonding to the 4 instructions above.
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {20070011}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {3401004B}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {34020005}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {04300007}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {00220822}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {20630001}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {08000c03}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {2063ffff}
add_force {/cpu_tb/U_1/mw_U_0ram_table[8]} -radix hex {ace3001b}
#forcing a clock with 10 ns period
add_force clk 1 {0 5ns} -repeat_every 10ns

#give a reset signal
add_force reset 0
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 4000 ns

if { [get_value -radix hex {/cpu_tb/U_1/mw_U_0ram_table[11]} ] == {0000000f} } {
    puts "Division Pass"
} else {
    puts "Division Fail"
}
puts [get_value -radix hex {/cpu_tb/U_1/mw_U_0ram_table[11]} ]