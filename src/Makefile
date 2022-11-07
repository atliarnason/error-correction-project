test_encoder:
	ghdl -a -fsynopsys --std=08 design/hamming/HammingEncoder.vhdl
	ghdl -a -fsynopsys --std=08 test/Util.vhdl
	ghdl -a -fsynopsys --std=08 test/HammingEncoderTb.vhdl
	ghdl -e -fsynopsys --std=08 HammingEncoderTb
	ghdl -r -fsynopsys --std=08 HammingEncoderTb --wave=waveform.vcd --trace-signals

test_decoder:
	ghdl -a -fsynopsys --std=08 design/hamming/HammingDecoder.vhdl
	ghdl -a -fsynopsys --std=08 test/Util.vhdl
	ghdl -a -fsynopsys --std=08 test/HammingDecoderTb.vhdl
	ghdl -e -fsynopsys --std=08 HammingDecoderTb
	ghdl -r -fsynopsys --std=08 HammingDecoderTb --wave=waveform.vcd
