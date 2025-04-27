 
#  Design Timing Constraints Definitions

set_time_format -unit ns -decimal_places 3

#  Create Input reference clock
create_clock -name KEY1_CLOCK -period 20.000ns [get_ports KEY[1]]

derive_pll_clocks -create_base_clocks
derive_clock_uncertainty

#https://electronics.stackexchange.com/questions/339401/get-ports-vs-get-pins-vs-get-nets-vs-get-registers
#create_generated_clock -name reg_IR_CLOCK -source [get_ports KEY[1]] [get_pins proc_extension/simple_proc_ext/register_n|Q[6]]

