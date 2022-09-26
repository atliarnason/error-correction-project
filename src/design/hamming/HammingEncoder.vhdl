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

    -- define necessary signals here

begin

    -- describe combinational logic here

    -- dummy connections
    x_encoded <= x"00";
    -- dummy connections

end architecture;