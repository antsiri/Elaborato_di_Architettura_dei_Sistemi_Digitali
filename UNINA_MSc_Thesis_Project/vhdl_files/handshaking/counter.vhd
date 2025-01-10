
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity counter_modN is
generic (N: integer range 0 to 32:= 16);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (3 downto 0));
end counter_modN;

architecture Behavioral of counter_modN is

signal c : std_logic_vector (3 downto 0) := (others => '0');
begin
counter <= c;

counter_process: process(clock)
begin
    
     if(rising_edge(clock)) then	  
	   if reset = '1' then
		  c <= (others => '0');
	   elsif enable = '1' then
		  c <= std_logic_vector(unsigned(c) + 1);
	  end if;
	 end if;
end process;

end Behavioral;