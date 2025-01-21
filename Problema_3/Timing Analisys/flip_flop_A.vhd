----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2025 13:42:14
-- Design Name: 
-- Module Name: flip_flop_A - Behavioral
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

entity flip_flop_A is
  Port ( 
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        
        start_in   :   in  std_logic;  
        
        X_in      :   in  std_logic_vector(7 downto 0);
        Y_in       :   in  std_logic_vector(7 downto 0);
        start_out   :  out  std_logic;  
        
        X_out      :   out  std_logic_vector(7 downto 0);
        Y_out       :  out  std_logic_vector(7 downto 0)
        );
end flip_flop_A;

architecture Behavioral of flip_flop_A is

begin
start_out <= start_in;
X_out <= X_in;
Y_out <= Y_in;

end Behavioral;
