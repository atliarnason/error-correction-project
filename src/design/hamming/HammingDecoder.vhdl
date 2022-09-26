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

entity HammingDecoder is
    port(
        x_encoded:  in  std_logic_vector(7 downto 0);
        x:          out std_logic_vector(3 downto 0);
        corrected:  out std_logic;
        error:      out std_logic
    );
end entity;

architecture Behavioral of HammingDecoder is 

    -- define necessary signals here

begin

    -- describe combinational logic here

    -- dummy connections
    x <= x_encoded(6 downto 4) & x_encoded(2);
    corrected <= '0';
    error <= '0';
    -- dummy connections

end architecture;