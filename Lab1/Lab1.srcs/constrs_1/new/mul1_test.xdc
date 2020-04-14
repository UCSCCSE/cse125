create_clock -period 11.000 -name clk -waveform {0.000 5.500} [get_ports clk]
set_input_delay -clock [get_clocks clk] -min -add_delay 4.000 [get_ports {arg1[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 10.000 [get_ports {arg1[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 4.000 [get_ports {arg2[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 10.000 [get_ports {arg2[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 4.000 [get_ports res_n]
set_input_delay -clock [get_clocks clk] -max -add_delay 10.000 [get_ports res_n]
set_input_delay -clock [get_clocks clk] -min -add_delay 4.000 [get_ports start]
set_input_delay -clock [get_clocks clk] -max -add_delay 10.000 [get_ports start]
set_output_delay -clock [get_clocks clk] -min -add_delay 1.000 [get_ports {product[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay 5.000 [get_ports {product[*]}]
set_output_delay -clock [get_clocks clk] -min -add_delay 1.000 [get_ports done]
set_output_delay -clock [get_clocks clk] -max -add_delay 5.000 [get_ports done]



