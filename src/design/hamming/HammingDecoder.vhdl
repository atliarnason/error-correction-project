-- -----------------------------------------------------------------------------
--
--  Title      :  Hamming SEC-DED decoder
--             :
--  Purpose    :  Verifies integrety of encoded message in format 
--             :  p3d3d2d1p2d0p1p0 using the parity bits. Corrects
--             :  single bit errors and signals double errors.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HammingDecoder is
    port(
        x_encoded:  in  std_logic_vector(7 downto 0):= "00000000";
        x:          out std_logic_vector(3 downto 0);
        corrected:  out std_logic; -- asserted if error was corrected
        error:      out std_logic  -- asserted if error is detected (single or double)
    );
end entity;

architecture Behavioral of HammingDecoder is 
    signal error_pos: std_logic_vector(2 downto 0) := "000";
    signal hamming_parity_bits: std_logic_vector(2 downto 0) := "000";
    signal corrected_message: std_logic_vector(7 downto 0);
    signal data_bits: std_logic_vector(3 downto 0) := "0000";
    signal parity_ok: std_logic;
    signal mask: std_logic_vector(7 downto 0);
begin
    -- first see if parity is correct, since parity is calculated
    -- on the code word. If parity is hi, there is no error.
    
    -- make it easier to work with data and parity bits
    data_bits <= x_encoded(6 downto 4) & x_encoded(2);
    hamming_parity_bits <= x_encoded(3) & x_encoded(1 downto 0);
    
    -- check parity of coded message (ignore the linter, this is legal in vhdl-2008)
    parity_ok <= not (x_encoded(7) xnor (xor x_encoded)); 

    error_pos(0) <= (hamming_parity_bits(0) xor data_bits(0)) xor (data_bits(1) xor data_bits(3));
    error_pos(1) <= (hamming_parity_bits(1) xor data_bits(0)) xor (data_bits(2) xor data_bits(3));
    error_pos(2) <= (hamming_parity_bits(2) xor data_bits(1)) xor (data_bits(2) xor data_bits(3));
    
    -- so when error_pos != 0, there is an error in the message. if the parity is good AND there is an error
    -- we have 2 errors.
    -- mask <= std_logic_vector(to_unsigned(1,8) sll to_integer(unsigned(error_pos))) when error_pos /= "000" else "00000000";
    
    mask <= "00000000" when error_pos = "000" else std_logic_vector(to_unsigned(1,8) sll to_integer(unsigned(error_pos)));

    corrected_message <= x_encoded xor mask;
    x <= corrected_message(6 downto 4) & corrected_message(2);
    
    error <= '1' when (?? (parity_ok)) and ((error_pos) /= "000") else '0';

    corrected <= '1' when ((error_pos) /= "000") else '0';

end architecture;





