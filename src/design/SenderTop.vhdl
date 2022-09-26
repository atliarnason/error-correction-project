-- -----------------------------------------------------------------------------
--
--  Title      :  Top entity for sender FPGA
--             :
--  Purpose    :  The entered 4-bit message is shown on the seven segment
--             :  display. The encoded message is shown by LEDs and sent 
--             :  to the receiver FPGA.
--             :
-- -----------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

use work.SevenSegment.SevenSegmentControl;

entity SenderTop is
    port(
        clock:      in  std_logic;
        reset:      in  std_logic;
        x:          in  std_logic_vector(3 downto 0);
        x_encoded:  out std_logic_vector(7 downto 0);
        leds:       out std_logic_vector(7 downto 0);
        display:    out SevenSegmentControl
    );
end entity;

architecture Structural of SenderTop is

    component HammingEncoder is 
        port(
            x:          in  std_logic_vector(3 downto 0);
            x_encoded:  out std_logic_vector(7 downto 0)
        );
    end component;

    component SevenSegmentDriver is
        generic(
            frequency:  integer := 100000000
        );
        port(
            clock:      in  std_logic;
            reset:      in  std_logic;
            number:     in  std_logic_vector(15 downto 0);
            display:    out SevenSegmentControl
        );
    end component;

    signal encoder_out: std_logic_vector(7 downto 0);

begin

    leds <= encoder_out;
    x_encoded <= encoder_out;

    enc: HammingEncoder 
        port map(
            x => x, 
            x_encoded => encoder_out
        );
    sev: SevenSegmentDriver 
        generic map(frequency => 100000000) 
        port map(
            clock => clock,
            reset => reset,
            number => x"000" & x,
            display => display
        );

end architecture;