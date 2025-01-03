library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity interc16_4 is 
            port( i0 : in STD_LOGIC;
			i1 : in STD_LOGIC;
			i2 : in STD_LOGIC;
			i3 : in STD_LOGIC;
			i4 : in STD_LOGIC;
			i5 : in STD_LOGIC;
			i6 : in STD_LOGIC;
			i7 : in STD_LOGIC;
			i8 : in STD_LOGIC;
			i9 : in STD_LOGIC;
			i10 : in STD_LOGIC;
			i11 : in STD_LOGIC;
			i12 : in STD_LOGIC;
			i13 : in STD_LOGIC;
			i14 : in STD_LOGIC;
			i15 : in STD_LOGIC;
			s0 : in STD_LOGIC;
			s1 : in STD_LOGIC;
			s2 : in STD_LOGIC;
			s3 : in STD_LOGIC;
			s4 : in STD_LOGIC;
			s5 : in STD_LOGIC;
			y0 : out STD_LOGIC;  
			y1 : out STD_LOGIC;  
			y2 : out STD_LOGIC;  
			y3 : out STD_LOGIC
			);
	end interc16_4;  

architecture structural of interc16_4 is
signal a0 : STD_LOGIC;
	
component mux16_1
        port(	i0 : in STD_LOGIC;
			i1 : in STD_LOGIC;
			i2 : in STD_LOGIC;
			i3 : in STD_LOGIC;
			i4 : in STD_LOGIC;
			i5 : in STD_LOGIC;
			i6 : in STD_LOGIC;
			i7 : in STD_LOGIC;
			i8 : in STD_LOGIC;
			i9 : in STD_LOGIC;
			i10 : in STD_LOGIC;
			i11 : in STD_LOGIC;
			i12 : in STD_LOGIC;
			i13 : in STD_LOGIC;
			i14 : in STD_LOGIC;
			i15 : in STD_LOGIC;
			s0 : in STD_LOGIC;
			s1 : in STD_LOGIC;
			s2 : in STD_LOGIC;
			s3 : in STD_LOGIC;
			y0 : out STD_LOGIC
		);	
	end component;
	
component demux1_4
		port(	i0 	: in STD_LOGIC;
				s0 	: in STD_LOGIC;
				s1 	: in STD_LOGIC;
				y0 	: out STD_LOGIC;
				y1 	: out STD_LOGIC;
				y2 	: out STD_LOGIC;
				y3 	: out STD_LOGIC
			);	
	end component;


	
begin
        mux_0: mux16_1
                Port map(
                     i0 => i0,
                     i1 => i1,
                     i2 => i2,
                     i3 => i3,
                     i4 => i4,
                     i5 => i5,
                     i6 => i6,
                     i7 => i7,
                     i8 => i8,
                     i9 => i9,
                     i10 => i10,
                     i11 => i11,
                     i12 => i12,
                     i13 => i13,
                     i14 => i14,
                     i15 => i15,
                     s0 => s0,
                     s1 => s1,
                     s2 => s2,
                     s3 => s3,
                     y0 => a0
                );
                
         demux0: demux1_4
                Port map(
                    i0 => a0,
                    s0 => s4,
                    s1 => s5,
                    y0 => y0,
                    y1 => y1,
                    y2 => y2,
                    y3 => y3
                    );

end structural;

