library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1_2 is
  Port (
        i: in STD_LOGIC_VECTOR(1 downto 0);
        s: in STD_LOGIC;
        u0: out STD_LOGIC_VECTOR(1 downto 0);
        u1: out STD_LOGIC_VECTOR(1 downto 0)
   );
end demux1_2;

architecture dataflow of demux1_2 is

begin
    u0 <= i when s = '0' else (others => '-');    
    u1 <= i when s = '1' else (others => '-');

end dataflow;
