-- -----------------------------------------------------------------------------
--
--  Title      :  Testbench for Hamming SEC-DED decoder
--             :
--  Purpose    :  Non-exhaustive test of decoder
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity HammingDecoderTb is
end entity;

architecture TestBench of HammingDecoderTb is 

    component HammingDecoder is 
        port(
            x_encoded:  in  std_logic_vector(7 downto 0);
            x:          out std_logic_vector(3 downto 0);
            corrected:  out std_logic;
            error:      out std_logic
        );
    end component;

    signal encoded:  std_logic_vector(7 downto 0);
    signal decoded: std_logic_vector(3 downto 0);
    signal corrected, error: std_logic;

begin

    dut: HammingDecoder 
        port map(
            x_encoded => encoded, 
            x => decoded,
            corrected => corrected,
            error => error
        );

    process begin
        
        -- add your stimuli here

        std.env.stop(0);
    end process;

end architecture;