----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.01.2025 12:47:35
-- Design Name: 
-- Module Name: mux2_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2_1 is
      Port ( 
            i0: in STD_LOGIC_VECTOR(1 downto 0);
            i1: in STD_LOGIC_VECTOR(1 downto 0);
            s: in STD_LOGIC;
            u: out STD_LOGIC_VECTOR(1 downto 0)
      );
end mux2_1;

architecture dataflow of mux2_1 is
	
	begin
		u 	<= 	i0 when s = '0' else	
				i1 when s = '1' else
				(others => '-'); --specifico cosa succede quando s non assume valore 0 o 1
				-- perchè s è uno STD_LOGIC, non un BIT
				
		

end dataflow;
