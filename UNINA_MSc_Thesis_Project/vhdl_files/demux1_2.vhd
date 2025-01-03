library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1_2 is
            port(
                a0  :in STD_LOGIC;
                s0  :in STD_LOGIC;
                y0  :out STD_LOGIC;
                y1  :out STD_LOGIC
                
            );
end demux1_2;


architecture dataflow of demux1_2 is

begin
        y0 <= (not s0 AND a0);
        y1 <= (s0 AND a0);


end dataflow;
