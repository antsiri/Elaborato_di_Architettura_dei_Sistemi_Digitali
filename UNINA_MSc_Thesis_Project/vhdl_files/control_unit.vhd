library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( 
		  clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   load_first_part : in  STD_LOGIC;
           load_second_part : in  STD_LOGIC;
           load_selection: in STD_LOGIC;
		   value8_in : in STD_LOGIC_VECTOR(7 downto 0); --valore acquisito dai primi 8 switch 
		   value16_out: out STD_LOGIC_VECTOR(15 downto 0);
		   selection_in: in STD_LOGIC_VECTOR(5 downto 0);
		   sel_out: out STD_LOGIC_VECTOR(5 downto 0)
			  );
end control_unit;

architecture Behavioral of control_unit is

signal reg_value : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
 signal selection_value: STD_LOGIC_VECTOR(5 downto 0);

begin
value16_out <= reg_value;
sel_out <= selection_value;

main: process(clock)
begin

	if clock'event and clock = '1' then
	   if reset = '1' then
		  reg_value <= (others => '0');
	   else
		  if load_first_part = '1' then
			reg_value(7 downto 0) <= value8_in;
		  elsif load_second_part = '1' then
			reg_value(15 downto 8) <= value8_in;
	      elsif load_selection = '1' then
	        selection_value <= selection_in;
		  end if;
	 end if;
	end if;

end process;


end Behavioral;

