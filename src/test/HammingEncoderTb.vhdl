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

    -- Even parity, so changed parity bit in expected result to 0 for x'0';
    process begin
        check(x"0", "00000000", dut_in, dut_out, expected);
        check(x"1", "10000111", dut_in, dut_out, expected);        
        check(x"2", "10011001", dut_in, dut_out, expected);        
        check(x"3", "00011110", dut_in, dut_out, expected);        
        check(x"4", "10101010", dut_in, dut_out, expected);        
        check(x"5", "00101101", dut_in, dut_out, expected);        
        check(x"6", "00110011", dut_in, dut_out, expected);        
        check(x"7", "10110100", dut_in, dut_out, expected);        
        check(x"8", "01001011", dut_in, dut_out, expected);        
        check(x"9", "11001100", dut_in, dut_out, expected);        
        check(x"a", "11010010", dut_in, dut_out, expected);        
        check(x"b", "01010101", dut_in, dut_out, expected);        
        check(x"c", "11100001", dut_in, dut_out, expected);        
        check(x"d", "01100110", dut_in, dut_out, expected);        
        check(x"e", "01111000", dut_in, dut_out, expected);        
        check(x"f", "11111111", dut_in, dut_out, expected);        











        -- add other stimuli here

        std.env.stop(0);
    end process;

end architecture;
