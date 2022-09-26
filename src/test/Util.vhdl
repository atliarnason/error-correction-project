-- -----------------------------------------------------------------------------
--
--  Title      :  Utility functions and procedures for testing
--             :
--  Purpose    :  Provides testing function for Hamming SEC-DED encoder
--             :  and a std_logic_vector to string conversion function.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package Util is

    -- applies stimuli to DUT and asserts that output takes expected value
    procedure check(
        constant stimuli:        std_logic_vector(3 downto 0); 
        constant expected:       std_logic_vector(7 downto 0);
        signal dut_in:       out std_logic_vector(3 downto 0);
        signal dut_out:      in  std_logic_vector(7 downto 0);
        signal expected_out: out std_logic_vector(7 downto 0)
    );

    -- converts bit vector to string
    function to_bstring(vec: std_logic_vector) return string;

end package;


package body Util is

    procedure check(
        constant stimuli:        std_logic_vector(3 downto 0); 
        constant expected:       std_logic_vector(7 downto 0);
        signal dut_in:       out std_logic_vector(3 downto 0);
        signal dut_out:      in  std_logic_vector(7 downto 0);
        signal expected_out: out std_logic_vector(7 downto 0)
    ) is begin

        dut_in <= stimuli; expected_out <= expected; wait for 10 ns;

        assert dut_out = expected 
        report LF & LF & "Error for X=" & to_bstring(stimuli) & ": expected " & to_bstring(expected) & " but got " & to_bstring(dut_out) & LF
        severity error;

    end procedure;

    function to_bstring(vec: std_logic_vector) return string is
        constant vec_norm: std_logic_vector(1 to vec'length) := vec;
        variable val: string(1 to 3);
    begin
        if (vec'length > 0) then
            val := std_logic'image(vec_norm(1));
            return val(2) & to_bstring(vec_norm(2 to vec'length));
        else
            return "";
        end if;
    end function;

end package body;