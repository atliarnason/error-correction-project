-- -----------------------------------------------------------------------------
--
--  Title      :  Protection Unit Wrapper
--             :
--  Purpose    :  Connects registers to all inputs and outputs in order to
--             :  obtain timing information
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ProtectionUnitWrapper is
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
        mem_write_data: out std_logic_vector(31 downto 0);
        mem_read_data: in std_logic_vector(31 downto 0)
    );
end entity;

architecture Behavioral of ProtectionUnitWrapper is

    component ProtectionUnit is 
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
            mem_write_data: out std_logic_vector(31 downto 0);
            mem_read_data: in std_logic_vector(31 downto 0)
        );
    end component;

    signal request_reg, write_reg: std_logic;
    signal acknowledge_reg, prot_acknowledge: std_logic;
    signal error_reg, prot_error: std_logic;
    signal address_reg: std_logic_vector(address_width-1 downto 0);
    signal write_data_reg: std_logic_vector(15 downto 0);
    signal read_data_reg, prot_read_data: std_logic_vector(15 downto 0);

    signal mem_request_reg, prot_mem_request: std_logic;
    signal mem_write_reg, prot_mem_write: std_logic;
    signal mem_address_reg, prot_mem_address: std_logic_vector(address_width-1 downto 0);
    signal mem_write_data_reg, prot_mem_write_data: std_logic_vector(31 downto 0);
    signal mem_read_data_reg: std_logic_vector(31 downto 0);

begin

    prot: ProtectionUnit port map (
        clock,
        reset,
        request_reg,
        write_reg,
        prot_acknowledge,
        prot_error,
        address_reg,
        write_data_reg,
        prot_read_data,
        prot_mem_request,
        prot_mem_write,
        prot_mem_address,
        prot_mem_write_data,
        mem_read_data_reg
    );

    acknowledge <= acknowledge_reg;
    error <= error_reg;
    read_data <= read_data_reg;
    mem_request <= mem_request_reg;
    mem_write <= mem_write_reg;
    mem_address <= mem_address_reg;
    mem_write_data <= mem_write_data_reg;

    process(clock) begin
        if rising_edge(clock) then
            request_reg <= '0' when reset = '1' else request;
            write_reg <= '0' when reset = '1' else write;
            acknowledge_reg <= '0' when reset = '1' else prot_acknowledge;
            error_reg <= '0' when reset = '1' else prot_error;
            address_reg <= (others => '0') when reset = '1' else address;
            write_data_reg <= (others => '0') when reset = '1' else write_data;
            read_data_reg <= (others => '0') when reset = '1' else prot_read_data;
            mem_request_reg <= '0' when reset = '1' else prot_mem_request;
            mem_write_reg <= '0' when reset = '1' else prot_mem_write;
            mem_address_reg <= (others => '0') when reset = '1' else prot_mem_address;
            mem_write_data_reg <= (others => '0') when reset = '1' else prot_mem_write_data;
            mem_read_data_reg <= (others => '0') when reset = '1' else mem_read_data;
        end if;
    end process;

end architecture;