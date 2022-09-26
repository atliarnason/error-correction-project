-- -----------------------------------------------------------------------------
--
--  Title      :  Top entity for receiving FPGA
--             :
--  Purpose    :  The received encoded message and error flags are shown by  
--             :  LEDs. The decoded message is shown on seven segment displays.
--             :
-- -----------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

use work.SevenSegment.SevenSegmentControl;

entity ReceiverTop is
    port(
        clock:      in  std_logic;
        reset:      in  std_logic;
        x_encoded:  in  std_logic_vector(7 downto 0);
        corrected:  out std_logic;
        error:      out std_logic;
        leds:       out std_logic_vector(7 downto 0);
        display:    out SevenSegmentControl
    );
end entity;

architecture Structural of ReceiverTop is

    component HammingDecoder is 
        port(
            x_encoded:  in  std_logic_vector(7 downto 0);
            x:          out std_logic_vector(3 downto 0);
            corrected:  out std_logic;
            error:      out std_logic
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

    signal decoder_out: std_logic_vector(3 downto 0);

begin

    leds <= x_encoded;

    dec: HammingDecoder
        port map(
            x_encoded => x_encoded,
            x => decoder_out,
            corrected => corrected,
            error => error
        );
    sev: SevenSegmentDriver 
        generic map(frequency => 100000000) 
        port map(
            clock => clock,
            reset => reset,
            number => x"000" & decoder_out,
            display => display
        );

end architecture;