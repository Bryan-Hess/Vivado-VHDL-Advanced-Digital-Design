# restart the simulation
restart

#top-level CPU testbench is named cpu_tb
#this instruction will add the internal signals and ports of a component name U_1, which in this case is the memory block.
#this should be replaced by the name of the componenet in your top-level testbench
#add_wave {{/cpu_tb/U_1}}

#LUI $1	0xF1E8
#ORI $8  $0 0x0011
#SRA $2 $1 8
#MULTU $1 $2
#MFHI $1
#MFLO $2
#LW $1 15($8)
#LW $2 19($8)

# you can use any of the following commands as an example on how to initilaize a memory location with a value
# the first 4 memory locations are initialized with the instruction codes correpsonding to the 4 instructions above.
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {3C01F1E8}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {34080011}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {00011203}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {00220019}
add_force {/cpu_tb/U_1/mw_U_0ram_table[4]} -radix hex {00000810}
add_force {/cpu_tb/U_1/mw_U_0ram_table[5]} -radix hex {00001012}
add_force {/cpu_tb/U_1/mw_U_0ram_table[6]} -radix hex {AD01000F}
add_force {/cpu_tb/U_1/mw_U_0ram_table[7]} -radix hex {AD020013}

#forcing a clock with 10 ns period
add_force clk 1 {0 5ns} -repeat_every 10ns

#give a reset signal
add_force reset 0
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 500 ns


if { [get_value -radix hex {/cpu_tb/U_1/mw_U_0ram_table[8]} ] == {f1daaea2} && [get_value -radix hex {/cpu_tb/U_1/mw_U_0ram_table[9]} ] == {40000000}} {
    puts "Multiplication Passed"
} else {
    puts "Multiplication Failed"
}
puts [get_value -radix hex {/cpu_tb/U_1/mw_U_0ram_table[8]}  ]
puts [get_value -radix hex {/cpu_tb/U_1/mw_U_0ram_table[9]}  ]