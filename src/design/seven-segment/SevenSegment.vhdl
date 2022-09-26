-- -----------------------------------------------------------------------------
--
--  Title      :  Seven segment display package
--             :
--  Purpose    :  Contains interface control record for seven segment display.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package SevenSegment is

    type SevenSegmentControl is record
        segments:       std_logic_vector(6 downto 0);
        digit_select:   std_logic_vector(3 downto 0);
        dot:            std_logic;
    end record;

end package;