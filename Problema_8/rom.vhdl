library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port(
        clk     :   in  std_logic;
        en      :   in  std_logic;
        address :   in  std_logic_vector(2 downto 0);
        dout    :   out std_logic_vector(3 downto 0)
    );
end entity ROM;

architecture beh of ROM is
type MEMORY_8_4 is array (0 to 7) of std_logic_vector(3 downto 0);
constant ROM_8_4 : MEMORY_8_4 := ("0010", "1001", "1111", "0101", "1110", "0101", "1010", "0001");
begin
    main : process(address)
    begin
        if (clk'event and clk='1') then
            if (en = '1') then
                dout <= ROM_8_4(to_integer(unsigned(address)));
            end if;
        end if;
    end process main;
end architecture beh;