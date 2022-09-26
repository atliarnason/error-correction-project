set_property IOSTANDARD LVCMOS33 [get_ports *]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Clock signal
set_property PACKAGE_PIN W5 [get_ports {clock}]							
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clock}]

## Reset signal
set_property PACKAGE_PIN T17 [get_ports {reset}]

## Switches
set_property PACKAGE_PIN V17 [get_ports {x[0]}]					
set_property PACKAGE_PIN V16 [get_ports {x[1]}]					
set_property PACKAGE_PIN W16 [get_ports {x[2]}]					
set_property PACKAGE_PIN W17 [get_ports {x[3]}]					

## LEDs
set_property PACKAGE_PIN U16 [get_ports {leds[0]}]					
set_property PACKAGE_PIN E19 [get_ports {leds[1]}]					
set_property PACKAGE_PIN U19 [get_ports {leds[2]}]					
set_property PACKAGE_PIN V19 [get_ports {leds[3]}]					
set_property PACKAGE_PIN W18 [get_ports {leds[4]}]					
set_property PACKAGE_PIN U15 [get_ports {leds[5]}]					
set_property PACKAGE_PIN U14 [get_ports {leds[6]}]					
set_property PACKAGE_PIN V14 [get_ports {leds[7]}]					

##7 segment display
set_property PACKAGE_PIN W7 [get_ports {display[segments][0]}]					
set_property PACKAGE_PIN W6 [get_ports {display[segments][1]}]					
set_property PACKAGE_PIN U8 [get_ports {display[segments][2]}]					
set_property PACKAGE_PIN V8 [get_ports {display[segments][3]}]					
set_property PACKAGE_PIN U5 [get_ports {display[segments][4]}]					
set_property PACKAGE_PIN V5 [get_ports {display[segments][5]}]					
set_property PACKAGE_PIN U7 [get_ports {display[segments][6]}]												
set_property PACKAGE_PIN U2 [get_ports {display[digit_select][0]}]					
set_property PACKAGE_PIN U4 [get_ports {display[digit_select][1]}]					
set_property PACKAGE_PIN V4 [get_ports {display[digit_select][2]}]					
set_property PACKAGE_PIN W4 [get_ports {display[digit_select][3]}]
set_property PACKAGE_PIN V7 [get_ports {display[dot]}]				



##Pmod Header JB
set_property PACKAGE_PIN A14 [get_ports {x_encoded[0]}]					
set_property PACKAGE_PIN A16 [get_ports {x_encoded[1]}]					
set_property PACKAGE_PIN B15 [get_ports {x_encoded[2]}]					
set_property PACKAGE_PIN B16 [get_ports {x_encoded[3]}]					
set_property PACKAGE_PIN A15 [get_ports {x_encoded[4]}]					
set_property PACKAGE_PIN A17 [get_ports {x_encoded[5]}]					
set_property PACKAGE_PIN C15 [get_ports {x_encoded[6]}]					
set_property PACKAGE_PIN C16 [get_ports {x_encoded[7]}]					
 