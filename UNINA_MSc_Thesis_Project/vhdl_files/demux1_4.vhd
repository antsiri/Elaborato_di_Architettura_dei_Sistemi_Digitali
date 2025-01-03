library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1_4 is
            port(
                i0  :in STD_LOGIC;
                s0  :in STD_LOGIC;
                s1  :in STD_LOGIC;
                y0  :out STD_LOGIC;
                y1  :out STD_LOGIC;
                y2  :out STD_LOGIC;
                y3  :out STD_LOGIC  
            );
end demux1_4;

architecture structural of demux1_4 is
    signal u0: STD_LOGIC := '0';
	signal u1: STD_LOGIC := '0';


component demux1_2
		port(	
              a0: in STD_LOGIC;
              s0: in STD_LOGIC;
              y0: out STD_LOGIC;
              y1: out STD_LOGIC
			);	
	end component;

	begin
	
		demux0: demux1_2 
			Port map(	
                     a0 =>i0,
                     s0 =>s0,
                     y0 =>u0,
                     y1 =>u1
					);
		demux1: demux1_2
			Port map(
                     a0 =>u0,
                     s0 =>s1,
                     y0 =>y0,
                     y1 =>y1
					);
	     demux2: demux1_2
			Port map(	
                     a0 =>u1,
                     s0 =>s1,
                     y0 =>y2,
                     y1 =>y3
					);
	
end structural;


