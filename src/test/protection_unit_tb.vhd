library ieee;
use ieee.std_logic_1164.all;


entity protection_unit_tb is
end entity;




architecture tb of protection_unit_tb is
		

	-- components
	component ProtectionUnit is
		generic(
					address_width: integer := 8
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
	signal tb_address, tb_mem_address : std_logic_vector(7 downto 0) := "00000000";
	signal tb_write_data, tb_read_data : std_logic_vector(15 downto 0) := X"0000";
	signal tb_mem_write_data, tb_meme_read_data : std_logic_vector(31 downto 0) := X"00000000";

	-- time_constants
	signal half_period_25_mhz :time := 20 ns;
begin

	dut: ProtectionUnit generic map(address_width => 8) port map(
			clock => clk,
			reset => tb_rst,
			request => tb_request,
			write => tb_write,
			acknowledge => tb_acknowledge,
			error => tb_error,
			address => tb_address,
			write_data => tb_write_data,
			read_data => tb_read_data,
			mem_request => tb_mem_request,
			mem_write => tb_mem_write,
			mem_address => tb_mem_address,
			mem_write_data => tb_mem_write_data,
			mem_read_data => tb_meme_read_data
   );



process begin
	-- generate a clock
	clk <= not clk after half_period_25_mhz;

	wait for 200 ns;

	std.env.stop;
end process;



end tb;
