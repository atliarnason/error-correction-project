-- -----------------------------------------------------------------------------
--
--  Title      :  ECC memory protection unit
--             :
--  Purpose    :  Adds parity information to data before it is stored in 
--             :  in memory. Decodes data retreived from memory and indicates
--             :  whether a corruption has occured.
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ProtectionUnit is
    generic(
        address_width: integer := 8
    );
    port(
        clock: in std_logic;
        reset: in std_logic;

        request: in std_logic;
        write: in std_logic;
        acknowledge: out std_logic;
        error: out std_logic;
        address: in std_logic_vector(address_width-1 downto 0);
        write_data: in std_logic_vector(15 downto 0);
        read_data: out std_logic_vector(15 downto 0);

        mem_request: out std_logic;
        mem_write: out std_logic;
        mem_address: out std_logic_vector(address_width-1 downto 0);
        mem_write_data: out std_logic_vector(32 downto 0);
        mem_read_data: in std_logic_vector(32 downto 0)
    );
end entity;

architecture Behavioral of ProtectionUnit is

    component HammingEncoder is 
        port(
            x:          in  std_logic_vector(3 downto 0);
            x_encoded:  out std_logic_vector(7 downto 0)
        );
    end component;

    component HammingDecoder is
        port(
            x_encoded:  in  std_logic_vector(7 downto 0);
            x:          out std_logic_vector(3 downto 0);
            corrected:  out std_logic;
            error:      out std_logic
        );
    end component;

begin

end architecture;