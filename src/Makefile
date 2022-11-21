
SRC_FILES_MEM:= \
	design/hamming/HammingDecoder.vhdl \
	design/hamming/HammingEncoder.vhdl \
	design/memory/ProtectionUnit.vhdl \
	test/protection_unit_tb.vhd




test_encoder:
	ghdl -a -fsynopsys --std=08 design/hamming/HammingEncoder.vhdl
	ghdl -a -fsynopsys --std=08 test/Util.vhdl
	ghdl -a -fsynopsys --std=08 test/HammingEncoderTb.vhdl
	ghdl -e -fsynopsys --std=08 HammingEncoderTb
	ghdl -r -fsynopsys --std=08 HammingEncoderTb --wave=waveform.ghw 

test_decoder:
	ghdl -a -fsynopsys --std=08 design/hamming/HammingDecoder.vhdl
	ghdl -a -fsynopsys --std=08 test/Util.vhdl
	ghdl -a -fsynopsys --std=08 test/HammingDecoderTb.vhdl
	ghdl -e -fsynopsys --std=08 HammingDecoderTb
	ghdl -r -fsynopsys --std=08 HammingDecoderTb --wave=waveform.vcd





test_mem:
	ghdl -a -fsynopsys --std=08 $(SRC_FILES_MEM) 
	ghdl -e -fsynopsys --std=08 protection_unit_tb 
	ghdl -r -fsynopsys --std=08 protection_unit_tb --vcd=waveform_pu.vcd 



