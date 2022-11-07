-- -----------------------------------------------------------------------------
--
--  Title      :  Hamming Encoder Wrapper
--             :
--  Purpose    :  Connects registers to all inputs and outputs in order to
--             :  obtain timing information
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity HammingEncoderWrapper is 
    port(
        clock:      in std_logic;
        reset:      in std_logic;
        x:          in  std_logic_vector(3 downto 0);
        x_encoded:  out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of HammingEncoderWrapper is

    component HammingEncoder is 
        port(
            x:          in  std_logic_vector(3 downto 0);
            x_encoded:  out std_logic_vector(7 downto 0)
        );
    end component;

    signal x_reg: std_logic_vector(3 downto 0);
    signal x_encoded_reg, encoder_out: std_logic_vector(7 downto 0);

begin

    enc: HammingEncoder port map (x_reg, encoder_out);
    
    x_encoded <= x_encoded_reg;

    process(clock) begin
        if rising_edge(clock) then
            x_reg <= x"0" when reset = '1' else x;
            x_encoded_reg <= x"00" when reset = '1' else encoder_out;
        end if;
    end process;
    
end architecture;