library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
  Port ( 
        A, reset: in STD_LOGIC;
        load_in, load_sel: in STD_LOGIC;
        value_in: in STD_LOGIC;
        sel_in: in STD_LOGIC;
        value_out: out STD_LOGIC;
        sel_out: out STD_LOGIC
  );
end control_unit;

architecture Behavioral of control_unit is
signal reg_value: STD_LOGIC;
signal reg_sel: STD_LOGIC;

begin
value_out <= reg_value;
sel_out <= reg_sel;

main: process(A)
begin
    if (A'event AND A = '1') then
        if (reset = '1') then 
            reg_value <= '0';
            reg_sel <= '0';
        elsif (load_sel = '1') then
            reg_sel <= sel_in;
        elsif(load_in = '1') then
            reg_value <= value_in;
        end if;
        end if;
end process;
end Behavioral;
