library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity interc_16_4onBoard is
Port(
		  clock : in  STD_LOGIC; --clock board
		  reset : in  STD_LOGIC; --reset, associato al bottone BTNC
		  load_first_part : in  STD_LOGIC; --comando di caricamento 8 bit meno significativi
		  load_second_part : in  STD_LOGIC; --comando di caricaernto 16bit piu' significativi
		  value8_in : in STD_LOGIC_VECTOR(7 downto 0);  --input di 8 bit inserito tramite switch (di volta in volta
		     --in base al segnale di controllo corrispondera' alle due meta' del valore da visualizzare
		  selection_in: in STD_LOGIC_VECTOR(5 downto 0); -- selezione acquisita dagli switch
		  load_selection: in STD_LOGIC; --comando per caricare i segnali di selezione: BTNU
		  y0, y1, y2, y3: out STD_LOGIC
			  );
end interc_16_4onBoard;

architecture structural of interc_16_4onBoard is
component control_unit is
Port ( 
		  clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   load_first_part : in  STD_LOGIC;
           load_second_part : in  STD_LOGIC;
           load_selection: in STD_LOGIC;
		   value8_in : in STD_LOGIC_VECTOR(7 downto 0); --valore acquisito da 8 switch alla volta
		   value16_out: out STD_LOGIC_VECTOR(15 downto 0);
		    selection_in: in STD_LOGIC_VECTOR(5 downto 0);
		   sel_out: out STD_LOGIC_VECTOR(5 downto 0)
			  );
end component;

component interc16_4 is
 port( 
            i0 : in STD_LOGIC;
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
end component;

signal cu_value: STD_LOGIC_VECTOR(15 downto 0);
signal cu_sel: STD_LOGIC_VECTOR( 5 downto 0);

begin
cu: control_unit 
    port map(
      clock => clock,
      reset => reset,
      load_first_part => load_first_part,
      load_second_part => load_second_part,
      load_selection => load_selection,
      value8_in => value8_in,
      value16_out => cu_value,
      selection_in => selection_in,
      sel_out => cu_sel
    );

ri: interc16_4 
    port map(
        i0 => cu_value(0),
         i1 => cu_value(1),
         i2 => cu_value(2),
         i3 => cu_value(3),
         i4 => cu_value(4),
         i5 => cu_value(5),
         i6 => cu_value(6),
         i7 => cu_value(7),
         i8 => cu_value(8),
         i9 => cu_value(9),
         i10 => cu_value(10),
         i11 => cu_value(11),
         i12 => cu_value(12),
         i13 => cu_value(13),
         i14 => cu_value(14),
         i15 => cu_value(15),
         s0 => cu_sel(0),
         s1 => cu_sel(1),
         s2 => cu_sel(2),
         s3 => cu_sel(3),
         s4 => cu_sel(4),
         s5 => cu_sel(5),
         y0 => y0,
         y1 => y1,
         y2 => y2, 
         y3 => y3
    );

end structural;
