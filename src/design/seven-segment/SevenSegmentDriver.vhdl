-- -----------------------------------------------------------------------------
--
--  Title      :  Driver for multiplexed 4-digit seven segment display
--             :
--  Purpose    :  4 seven segment digits are multiplexed at a 10KHz rate. The
--             :  16-bit input is shown as a 4-digit hexadecimal number. The
--             :  display LEDs and select signals are active low.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

use work.SevenSegment.SevenSegmentControl;

entity SevenSegmentDriver is
    generic(
        -- frequency of the host system
        frequency:  integer := 100000000
    );
    port(
        clock:      in  std_logic;
        reset:      in  std_logic;
        number:     in  std_logic_vector(15 downto 0);
        display:    out SevenSegmentControl
    );
end entity;

architecture Behavioral of SevenSegmentDriver is

    -- Number of clock cycles to create 10KHz ticks
    constant TICK_COUNT: integer := frequency / 10000;

    -- Counter width has to accomodate number of clock cycles in one tick
    constant W: integer := integer(ceil(log2(real(TICK_COUNT + 1))));

    -- Down-counter to generate 10KHz ticks
    signal counter, counter_next: unsigned(W-1 downto 0);

    -- Asserted for one clock cycle every TICK_COUNT clock cycles
    signal tick: std_logic;

    -- Shift register selecting one of the four digits of the display
    signal digit_select, digit_select_next: std_logic_vector(3 downto 0);

    -- current 4-bit digit sent to the display
    signal digit: std_logic_vector(3 downto 0);

    -- Decoder from binary to control signals for seven segment display LEDs
    component SevenSegmentDecoder is
        port(
            binary:     in  std_logic_vector(3 downto 0);
            encoded:    out std_logic_vector(6 downto 0)
        );
    end component;

begin

    -- The decoder decodes the current digits and outputs LED control signals
    decoder: SevenSegmentDecoder port map(binary => digit, encoded => display.segments);

    -- The down-counter is reset to the TICK_COUNT when it reaches 0
    tick <= '1' when counter = 0 else '0';
    counter_next <= to_unsigned(TICK_COUNT, W) when tick else counter - 1;

    -- The active display rotates at each tick
    digit_select_next <= digit_select(0) & digit_select(3 downto 1) when tick else digit_select;

    -- The current digit is chosen based on the currently selected display
    with digit_select select
        digit <=    number(3 downto 0)   when "1110",
                    number(7 downto 4)   when "1101",
                    number(11 downto 8)  when "1011",
                    number(15 downto 12) when others;

    -- propagate display selecter to output
    display.digit_select <= digit_select;

    -- the seven segment display decimal point is always turned off
    display.dot <= '1';

    -- describe registers with synchronous reset
    process(clock) begin
        if rising_edge(clock) then

            -- The down-counter resets to its maximum value
            counter <= to_unsigned(TICK_COUNT, W) when reset='1' else counter_next;

            -- The display selecter resets to selecting the leftmost display
            digit_select <= "0111" when reset='1' else digit_select_next;

        end if;
    end process;

end architecture;