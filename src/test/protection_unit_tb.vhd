library ieee;
use ieee.std_logic_1164.all;
use work.all;


entity protection_unit_tb is
end entity;




architecture tb of protection_unit_tb is
		

	-- components
	component ProtectionUnit is
		generic(
					address_width: integer := 16 

			   );
		port (
				clock: in std_logic;
				reset: in std_logic;
			
				request: in std_logic;
				write: in std_logic;
				acknowledge: out std_logic;
				error: out std_logic;
				address: in std_logic_vector(address_width-1 downto 0);
				write_data: in std_logic_vector(15 downto 0);
				read_data: out std_logic_vector(15 downto 0);	
				
				mem_request: out std_logic;
				mem_write: out std_logic;
				mem_address: out std_logic_vector(address_width-1 downto 0);
				mem_write_data: out std_logic_vector(31 downto 0);
				mem_read_data: in std_logic_vector(31 downto 0)
		 );
	end component;

	-- signals	
	signal clk : std_logic := '0'; -- make sure you initialise!
	signal tb_rst, tb_request,tb_write, tb_acknowledge, tb_error, tb_mem_request, tb_mem_write : std_logic := '0';
	signal tb_address, tb_mem_address : std_logic_vector(15 downto 0) := "0000000000000000";
	signal tb_write_data, tb_read_data : std_logic_vector(15 downto 0) := X"0000";
	signal tb_mem_write_data, tb_mem_read_data : std_logic_vector(31 downto 0) := X"00000000";

	-- time_constants
	signal half_period_25_mhz :time := 20 ns;
begin

	dut: ProtectionUnit generic map(address_width => 16) port map(
			clock => clk, 									-- in
			reset => tb_rst,								-- in
			request => tb_request,							-- in
			write => tb_write,								-- in
			acknowledge => tb_acknowledge, 					-- out 
			error => tb_error,								-- out
			address => tb_address,							-- in
			write_data => tb_write_data,					-- in
			read_data => tb_read_data,						-- out
			mem_request => tb_mem_request,					-- out
			mem_write => tb_mem_write,						-- out
			mem_address => tb_mem_address,					-- out
			mem_write_data => tb_mem_write_data,			-- out
			mem_read_data => tb_mem_read_data				-- in
   );

	clk <= not clk after half_period_25_mhz;

process begin

	-- AUTOGEN


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #0 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"aa8b"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00011110001011011000011101010101";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 0 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"351b") report "TEST 0 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #1 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"9c34"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "10011001101010101011010001010101";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 1 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"247b") report "TEST 1 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #2 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"9618"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "10101010010010110111100001111000";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 2 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"48ee") report "TEST 2 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #3 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"add4"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "10000111010101010010110100000000";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 3 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"1b50") report "TEST 3 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #4 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"fafb"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "11100001110011001111111101111000";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 4 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"c9fe") report "TEST 4 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #5 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"1570"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "01111000100110011001100100000000";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 5 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"e220") report "TEST 5 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #6 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"400b"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "01100110000111100010110100011110";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 6 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"d353") report "TEST 6 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #7 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"75d4"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "11001100101101000001111010000111";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 7 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"9731") report "TEST 7 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #8 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"fb78"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00011110110011000010110111111111";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 8 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"395f") report "TEST 8 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #9 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"d9cd"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00101101011110001000011100011110";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 9 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"5e13") report "TEST 9 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #10 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"8150"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00000000011110001001100100110011";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 10 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"0e26") report "TEST 10 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #11 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"ca09"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "10101010000111100111100000000000";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 11 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"43e0") report "TEST 11 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #12 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"52fb"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "11111111000111101010101000011110";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 12 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"f343") report "TEST 12 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #13 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"cc6d"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "01001011110100100001111010101010";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 13 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"8a34") report "TEST 13 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #14 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"8dad"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "11100001001100111101001010101010";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 14 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"c6a4") report "TEST 14 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #15 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"0d9f"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "01111000110011001000011100101101";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 15 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"e915") report "TEST 15 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #16 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"d6d1"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00000000000111101001100110011001";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 16 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"0322") report "TEST 16 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #17 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"4afe"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "10101010001011010110011010101010";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 17 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"45d4") report "TEST 17 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #18 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"cb9b"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00000000010010110110011011010010";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 18 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"08da") report "TEST 18 failed, decoded read data wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #19 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '0';
	tb_address <= X"2e7d"; -- random address
	wait for 40 ns; -- there is a single clock cycle delay on reading from memory
	tb_mem_read_data <= "00110011000111101011010001010101";
	wait for 40 ns; -- protection_unit asserts acknowledge at rising edge after the one clock cycle
	assert (tb_acknowledge = '1') report "TEST 19 failed, acknowledge was not asserted after one clock cycle.";
	assert (tb_read_data = X"637b") report "TEST 19 failed, decoded read data wrong";
	wait for 40 ns;
	

	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #20 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"3f8b"; -- random address
	tb_write_data <= X"716f";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10110100100001110011001111111111") report "TEST 20 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #21 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"db9f"; -- random address
	tb_write_data <= X"6477";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00110011101010101011010010110100") report "TEST 21 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #22 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"8596"; -- random address
	tb_write_data <= X"7baa";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10110100010101011101001011010010") report "TEST 22 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #23 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"c9bd"; -- random address
	tb_write_data <= X"3673";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00011110001100111011010000011110") report "TEST 23 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #24 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"280e"; -- random address
	tb_write_data <= X"4f8b";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10101010111111110100101101010101") report "TEST 24 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #25 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"1165"; -- random address
	tb_write_data <= X"d957";
	wait for 40 ns; 
	assert (tb_mem_write_data = "01100110110011000010110110110100") report "TEST 25 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #26 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"c91d"; -- random address
	tb_write_data <= X"c250";
	wait for 40 ns; 
	assert (tb_mem_write_data = "11100001100110010010110100000000") report "TEST 26 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #27 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"f652"; -- random address
	tb_write_data <= X"2b4c";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10011001010101011010101011100001") report "TEST 27 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #28 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"f4fc"; -- random address
	tb_write_data <= X"2b65";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10011001010101010011001100101101") report "TEST 28 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #29 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"d728"; -- random address
	tb_write_data <= X"3221";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00011110100110011001100110000111") report "TEST 29 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #30 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"58fe"; -- random address
	tb_write_data <= X"2293";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10011001100110011100110000011110") report "TEST 30 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #31 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"f589"; -- random address
	tb_write_data <= X"9510";
	wait for 40 ns; 
	assert (tb_mem_write_data = "11001100001011011000011100000000") report "TEST 31 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #32 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"738d"; -- random address
	tb_write_data <= X"571e";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00101101101101001000011101111000") report "TEST 32 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #33 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"bc8e"; -- random address
	tb_write_data <= X"3043";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00011110000000001010101000011110") report "TEST 33 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #34 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"bbc6"; -- random address
	tb_write_data <= X"f5a0";
	wait for 40 ns; 
	assert (tb_mem_write_data = "11111111001011011101001000000000") report "TEST 34 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #35 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"e3d3"; -- random address
	tb_write_data <= X"2542";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10011001001011011010101010011001") report "TEST 35 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #36 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"477a"; -- random address
	tb_write_data <= X"64ba";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00110011101010100101010111010010") report "TEST 36 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #37 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"b4cb"; -- random address
	tb_write_data <= X"0da1";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00000000011001101101001010000111") report "TEST 37 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #38 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"99f5"; -- random address
	tb_write_data <= X"573e";
	wait for 40 ns; 
	assert (tb_mem_write_data = "00101101101101000001111001111000") report "TEST 38 failed, message encoded wrong";
	wait for 40 ns;
		


	---------------------------------------------------------------------------------------------------
	------------------------------ TEST #39 ----------------------------------------------------
	---------------------------------------------------------------------------------------------------
	wait for 40 ns; -- wait full clock cycle
	tb_request <= '1';
	tb_write <= '1';
	tb_address <= X"e4c5"; -- random address
	tb_write_data <= X"1d55";
	wait for 40 ns; 
	assert (tb_mem_write_data = "10000111011001100010110100101101") report "TEST 39 failed, message encoded wrong";
	wait for 40 ns;
			


    wait for 200 ns;
	std.env.stop;
end process;



end tb;
