-- -----------------------------------------------------------------------------
--
--  Title      :  Hamming SEC-DED encoder
--             :
--  Purpose    :  Calculates four parity bits for the 4-bit input
--             :  and encodes the message in the format
--             :  p3d3d2d1p2d0p1p0.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity HammingEncoder is 
    port(
        x:          in  std_logic_vector(3 downto 0);
        x_encoded:  out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of HammingEncoder is

    signal hamming_parity: std_logic_vector(2 downto 0);
    signal even_parity: std_logic;

begin

    -- describe combinational logic here
    hamming_parity(0) <= ('0' xor x(0)) xor (x(1) xor x(3));
    hamming_parity(1) <= ('0' xor x(0)) xor (x(2) xor x(3));
    hamming_parity(2) <= ('0' xor x(1)) xor (x(2) xor x(3));
    
    -- unary xor is available in vhdl-2008 and & is the concatenation operator, not AND. 
    even_parity <= (xor (hamming_parity & x));
    
    x_encoded(7 downto 4) <= even_parity & x(3 downto 1);
    x_encoded(3 downto 0) <= hamming_parity(2) & x(0) & hamming_parity(1 downto 0);



end architecture;
