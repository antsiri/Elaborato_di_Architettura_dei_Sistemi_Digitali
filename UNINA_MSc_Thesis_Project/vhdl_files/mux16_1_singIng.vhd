library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux16_1 is 
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
end mux16_1;

architecture structural of mux16_1 is
    signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';
	signal u2 : STD_LOGIC := '0';
	signal u3 : STD_LOGIC := '0';
	
component mux_2_1
		port(	a0 	: in STD_LOGIC;
				a1 	: in STD_LOGIC;
				s 	: in STD_LOGIC;
				y 	: out STD_LOGIC
			);	
	end component;
	
component mux_4_1
        port(	b0 : in STD_LOGIC;
                b1 : in STD_LOGIC;
                b2 : in STD_LOGIC;
                b3 : in STD_LOGIC;
                s0 : in STD_LOGIC;
                s1 : in STD_LOGIC;
                y0 : out STD_LOGIC
		);
	end component;

begin
        mux_0: mux_4_1
            Port map(   b0 => i0,
                        b1 => i1,
                        b2 => i2,
                        b3 => i3,
                        s0 => s0,
                        s1 => s1,
                        y0 => u0
                      );
                      
         mux_1: mux_4_1
            Port map(   b0 => i4,
                        b1 => i5,
                        b2 => i6,
                        b3 => i7,
                        s0 => s0,
                        s1 => s1,
                        y0 => u1
                      );
          mux_2: mux_4_1
            Port map(   b0 => i8,
                        b1 => i9,
                        b2 => i10,
                        b3 => i11,
                        s0 => s0,
                        s1 => s1,
                        y0 => u2
                      );
                      
                  
            mux_3: mux_4_1
            Port map(   b0 => i12,
                        b1 => i13,
                        b2 => i14,
                        b3 => i15,
                        s0 => s0,
                        s1 => s1,
                        y0 => u3
                      );    
                      
            mux_4: mux_4_1
            Port map(   b0 => u0,
                        b1 => u1,
                        b2 => u2,
                        b3 => u3,
                        s0 => s2,
                        s1 => s3,
                        y0 => y0
                      );        
                        
end structural;
