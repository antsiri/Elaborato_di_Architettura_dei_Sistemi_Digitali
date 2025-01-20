library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity  control_unit is
  Port (
        A: in STD_LOGIC;
        reset: in STD_LOGIC; --bottone BTNC
        load_in: in STD_LOGIC; --comando per carocare il bit in ingresso i (bottone BTNL)
        load_M: in STD_LOGIC; --comando per caricare l'ingresso M (bottone BTNR)
        value_in: in STD_LOGIC;
        M_in: in STD_LOGIC;
        i_out: out STD_LOGIC;
        M_out: out STD_LOGIC
   );
end control_unit;

architecture Behavioral of control_unit is
signal i_value: STD_LOGIC;
signal M_value: STD_LOGIC;

begin
i_out <= i_value;
M_out <= M_value;

main: process(A)
begin
    if (A'event AND A = '1') then
        if (reset = '1') then
            i_value <= '0';
            M_value <= '0';
        else
            if (load_in = '1') then
                i_value <= value_in;
            elsif (load_M = '1') then
                M_value <= M_in;
            end if;
            end if;
            end if;
end process;

end Behavioral;
