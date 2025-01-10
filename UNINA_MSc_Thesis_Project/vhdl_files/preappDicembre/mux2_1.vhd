library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux2_1 is
   
	port( x0, x1: in std_logic_vector(3 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(3 downto 0)
		  );
end mux2_1;

architecture rtl of mux2_1 is

	begin
	
	y <= x0 when s='0' else 
	    x1 when s='1' else
	    (others => '0');
    end rtl;

		
		