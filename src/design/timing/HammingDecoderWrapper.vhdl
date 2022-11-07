-- -----------------------------------------------------------------------------
--
--  Title      :  Hamming Decoder Wrapper
--             :
--  Purpose    :  Connects registers to all inputs and outputs in order to
--             :  obtain timing information
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity HammingDecoderWrapper is 
    port(
        clock:      in std_logic;
        reset:      in std_logic;
        x_encoded:  in  std_logic_vector(7 downto 0);
        x:          out std_logic_vector(3 downto 0);
        corrected:  out std_logic; -- asserted if error was corrected
        error:      out std_logic  -- asserted if error is detected (single or double)
    );
end entity;

architecture Behavioral of HammingDecoderWrapper is

    component HammingDecoder is 
        port(
            x_encoded:  in  std_logic_vector(7 downto 0);
            x:          out std_logic_vector(3 downto 0);
            corrected:  out std_logic; -- asserted if error was corrected
            error:      out std_logic  -- asserted if error is detected (single or double)
        );
    end component;

    signal decoder_corrected, corrected_reg, decoder_error, error_reg: std_logic;
    signal x_reg, decoder_x: std_logic_vector(3 downto 0);
    signal x_encoded_reg: std_logic_vector(7 downto 0);

begin

    enc: HammingDecoder port map (x_encoded_reg, decoder_x, decoder_corrected, decoder_error);
    
    x <= x_reg;
    corrected <= corrected_reg;
    error <= error_reg;

    process(clock) begin
        if rising_edge(clock) then
            x_encoded_reg <= x"00" when reset = '1' else x_encoded;
            x_reg <= x"0" when reset = '1' else decoder_x;
            corrected_reg <= '0' when reset = '1' else decoder_corrected;
            error_reg <= '0' when reset = '1' else decoder_error;
        end if;
    end process;
    
end architecture;