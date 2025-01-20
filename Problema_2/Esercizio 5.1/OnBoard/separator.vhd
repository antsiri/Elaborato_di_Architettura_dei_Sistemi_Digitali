library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity separator is 
port(
    num_in : in std_logic_vector (5 downto 0);
    clk : in std_logic;
    unit : out std_logic_vector (3 downto 0);
    dec : out std_logic_vector (3 downto 0)
 );
end separator;

 architecture Behavioral of separator is
  signal temp_dec, temp_un : integer;
  begin
 
  calc : process(clk)
  begin
 
  temp_dec <= (to_integer(unsigned(num_in))) / 10;
  temp_un <= (to_integer(unsigned(num_in))) mod 10;
 
  end process;
 
 unit <= std_logic_vector(to_unsigned(temp_un, 4));
 dec <= '0' & std_logic_vector(to_unsigned(temp_dec, 3));
 
 end Behavioral;