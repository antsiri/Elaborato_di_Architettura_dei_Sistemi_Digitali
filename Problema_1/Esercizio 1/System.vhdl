library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity System is
    port
    (
        addr: in std_logic_vector(3 downto 0);      -- 4 bits address
        y: out std_logic_vector(3 downto 0) 
    ); 
end System;

architecture behavioral of System is
    type ROM_type is array(0 to 15) of std_logic_vector(7 downto 0);

    signal ROM : ROM_type := (
        "00000000", "00000001", "00000010", "00000011",
        "00000100", "00000101", "00000100", "00000101",
        "00001010", "00001011", "00001000", "00001001",
        "00001110", "00001111", "00001100", "00001101"
    );

    signal ROM_Data : std_logic_vector(7 downto 0);

begin
    process(addr)
    begin 
        ROM_Data <= ROM(to_integer(unsigned(addr)));
    end process;

    -- M: return 4 LSB
    process(ROM_Data)
    begin
        y <= ROM_Data(3 downto 0);
    end process;

end behavioral;
