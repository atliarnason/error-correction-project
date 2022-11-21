-- -----------------------------------------------------------------------------
--
--  Title      :  ECC memory protection unit
--             :
--  Purpose    :  Adds parity information to data before it is stored in 
--             :  in memory. Decodes data retreived from memory and indicates
--             :  whether a corruption has occured.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity ProtectionUnit is
    generic(
        address_width: integer := 8
    );
    port(
        clock: in std_logic;
        reset: in std_logic;

        request: in std_logic;
        write: in std_logic;
        acknowledge: out std_logic := '0';
        error: out std_logic;
        address: in std_logic_vector(address_width-1 downto 0);
	write_data: in std_logic_vector(15 downto 0); -- we assume that this is 4 x 4 bits that are to be encoded
        read_data: out std_logic_vector(15 downto 0) := X"0000"; -- vice versa

        mem_request: out std_logic;
        mem_write: out std_logic;
        mem_address: out std_logic_vector(address_width-1 downto 0);
        mem_write_data: out std_logic_vector(31 downto 0);
        mem_read_data: in std_logic_vector(31 downto 0):= X"00000000"
    );
end entity;

architecture Behavioral of ProtectionUnit is
	
    component HammingEncoder is 
        port(
            x:          in  std_logic_vector(3 downto 0);
            x_encoded:  out std_logic_vector(7 downto 0)
        );
    end component;

    component HammingDecoder is
        port(
            x_encoded:  in  std_logic_vector(7 downto 0);
            x:          out std_logic_vector(3 downto 0);
            corrected:  out std_logic;
            error:      out std_logic
        );
    end component;

    -- types
	type state is (state_read,state_write,state_idle, state_waiting  );

    -- signals
	signal crt_state, next_state : state := state_idle;
	signal waiting : std_logic := '0';
begin

   	-- we have 4 parallel encoders and decoders, this might take up some space, but this saves
       	-- us from having to a lot of clocked stuff	

	encoders: for i in 3 downto 0 generate
		encoder: HammingEncoder port map(x => write_data((i+1)*4-1 downto i*4 ), x_encoded => mem_write_data((i+1)*8-1 downto i*8 ));
	end generate encoders;

	decoders: for i in 3 downto 0 generate
		decoder: HammingDecoder port map(
											x_encoded => mem_read_data((i+1)*8-1 downto i*8 ),
											x => read_data((i+1)*4-1 downto i*4 ),
											error => error,
											corrected => open		
										);
	end generate decoders;


	-- we need a state machine to talk to the memory
	-- and next-state logic - dependent on the 'write' flag
	next_state <= state_write when (??request) and (write = '1') and (waiting = '0') else 
				  state_read when ((??request) and (write = '0')) and (waiting = '0') else
				  state_waiting when (waiting = '1') else
				  state_idle; 


	process(clock)	
	begin
		if rising_edge(clock) then
			if reset = '1' then
				-- reset
			else
				crt_state <= next_state;
			end if;
		end if;
	end process;

	process(crt_state) begin
		case crt_state is
			when state_read =>	
								mem_address <= address;
								mem_request <= request;
								mem_write <= write;
								acknowledge <= '0';
								waiting <= '1';
			when state_write =>
								mem_request <= request;
								mem_write <= write;
								mem_address <= address;
			when state_idle =>
								null;
			when state_waiting => 
								acknowledge <= '1';
								waiting <= '0';
		end case;
	end process;

end Behavioral;
