transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/cgreg/Documents/Uni/ECE2072/Lab\ 2/Part1 {C:/Users/cgreg/Documents/Uni/ECE2072/Lab 2/Part1/ones_counting_testbench.v}
vlog -vlog01compat -work work +incdir+C:/Users/cgreg/Documents/Uni/ECE2072/Lab\ 2/Part1 {C:/Users/cgreg/Documents/Uni/ECE2072/Lab 2/Part1/ones_counter.v}

