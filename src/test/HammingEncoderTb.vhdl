-- -----------------------------------------------------------------------------
--
--  Title      :  Testbench for Hamming SEC-DED encoder
--             :
--  Purpose    :  Exhaustive test of encoder
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.Util.all;

entity HammingEncoderTb is
end entity;

architecture TestBench of HammingEncoderTb is 

    component HammingEncoder is 
        port(
            x           : in  std_logic_vector(3 downto 0);
            x_encoded   : out std_logic_vector(7 downto 0)
        );
    end component;

    signal dut_in:  std_logic_vector(3 downto 0);
    signal dut_out, expected: std_logic_vector(7 downto 0);

begin

    dut: HammingEncoder port map(x => dut_in, x_encoded => dut_out);

    process begin
        check(x"0", "00000001", dut_in, dut_out, expected);
        
        -- add other stimuli here

        std.env.stop(0);
    end process;

end architecture;