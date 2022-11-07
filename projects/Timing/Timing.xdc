set_property IOSTANDARD LVCMOS33 [get_ports *]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
					
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clock}]
