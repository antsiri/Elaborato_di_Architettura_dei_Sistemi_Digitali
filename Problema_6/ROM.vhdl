library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;
use ieee.numeric_std.all;

entity ROM is
    port
    (
        clk     :   in  std_logic;
        en_rd   :   in  std_logic;

        address :   in  std_logic_vector(2 downto 0);
        
        d_out   :   out std_logic_vector(7 downto 0)
    );
end entity;

architecture behavioral of ROM is
    type Memory is array(7 downto 0) of std_logic_vector(7 downto 0);

    constant ROM_M: Memory := (
        "01010101",     
        "00000111",
        "11111111",
        "01000110",
        "11110000",
        "10001001",
        "00000000",
        "11001001"      -- location 000
    );

begin
    read_proc: process(clk, en_rd, address)
    begin
        if clk'event and clk='1' then
            if en_rd = '1' then
                d_out   <=  ROM_M(to_integer(unsigned(address)));
            end if;
        end if;
    end process;
end behavioral;