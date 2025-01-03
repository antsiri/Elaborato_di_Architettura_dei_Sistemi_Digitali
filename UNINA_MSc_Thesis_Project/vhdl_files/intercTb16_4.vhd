library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity interc16_4_tb is
end;

architecture bench of interc16_4_tb is

  component interc16_4 
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
  	end component;

  signal i0: STD_LOGIC;
  signal i1: STD_LOGIC;
  signal i2: STD_LOGIC;
  signal i3: STD_LOGIC;
  signal i4: STD_LOGIC;
  signal i5: STD_LOGIC;
  signal i6: STD_LOGIC;
  signal i7: STD_LOGIC;
  signal i8: STD_LOGIC;
  signal i9: STD_LOGIC;
  signal i10: STD_LOGIC;
  signal i11: STD_LOGIC;
  signal i12: STD_LOGIC;
  signal i13: STD_LOGIC;
  signal i14: STD_LOGIC;
  signal i15: STD_LOGIC;
  signal s0: STD_LOGIC;
  signal s1: STD_LOGIC;
  signal s2: STD_LOGIC;
  signal s3: STD_LOGIC;
  signal s4: STD_LOGIC;
  signal s5: STD_LOGIC;
  signal y0: STD_LOGIC;
  signal y1: STD_LOGIC;
  signal y2: STD_LOGIC;
  signal y3: STD_LOGIC ;

begin

  uut: interc16_4 port map ( i0  => i0,
                             i1  => i1,
                             i2  => i2,
                             i3  => i3,
                             i4  => i4,
                             i5  => i5,
                             i6  => i6,
                             i7  => i7,
                             i8  => i8,
                             i9  => i9,
                             i10 => i10,
                             i11 => i11,
                             i12 => i12,
                             i13 => i13,
                             i14 => i14,
                             i15 => i15,
                             s0  => s0,
                             s1  => s1,
                             s2  => s2,
                             s3  => s3,
                             s4  => s4,
                             s5  => s5,
                             y0  => y0,
                             y1  => y1,
                             y2  => y2,
                             y3  => y3 );

  stimulus: process
  begin

    -- Inizializzazione segnali
    i0  <= '0'; i1  <= '0'; i2  <= '0'; i3  <= '0';
    i4  <= '0'; i5  <= '0'; i6  <= '0'; i7  <= '0';
    i8  <= '0'; i9  <= '0'; i10 <= '0'; i11 <= '0';
    i12 <= '0'; i13 <= '0'; i14 <= '0'; i15 <= '0';
    s0  <= '0'; s1  <= '0'; s2  <= '0'; s3  <= '0';
    s4  <= '0'; s5  <= '0';
    wait for 10 ns;

    -- Test Case 1: Selezione i0
    i0 <= '1'; s0 <= '0'; s1 <= '0'; s2 <= '0'; s3 <= '0'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 2: Selezione i3
    i3 <= '1'; s0 <= '1'; s1 <= '1'; s2 <= '0'; s3 <= '0'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 3: Selezione i7
    i7 <= '1'; s0 <= '1'; s1 <= '1'; s2 <= '1'; s3 <= '0'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 4: Selezione i12
    i12 <= '1'; s0 <= '0'; s1 <= '0'; s2 <= '0'; s3 <= '1'; s4 <= '1'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 5: Selezione i15
    i15 <= '1'; s0 <= '1'; s1 <= '1'; s2 <= '1'; s3 <= '1'; s4 <= '1'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 6: Nessun ingresso attivo
    i0  <= '0'; i1  <= '0'; i2  <= '0'; i3  <= '0';
    i4  <= '0'; i5  <= '0'; i6  <= '0'; i7  <= '0';
    i8  <= '0'; i9  <= '0'; i10 <= '0'; i11 <= '0';
    i12 <= '0'; i13 <= '0'; i14 <= '0'; i15 <= '0';
    s0  <= '0'; s1  <= '0'; s2  <= '0'; s3 <= '0'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 7: Selezione i5
    i5 <= '1'; s0 <= '1'; s1 <= '0'; s2 <= '1'; s3 <= '0'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 8: Selezione i10
    i10 <= '1'; s0 <= '0'; s1 <= '1'; s2 <= '0'; s3 <= '1'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 9: Selezione i6
    i6 <= '1'; s0 <= '1'; s1 <= '0'; s2 <= '1'; s3 <= '1'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 10: Selezione i9
    i9 <= '1'; s0 <= '0'; s1 <= '1'; s2 <= '1'; s3 <= '0'; s4 <= '0'; s5 <= '0';
    wait for 10 ns;

    -- Test Case 11: Selezione i14
    i14 <= '1'; s0 <= '1'; s1 <= '1'; s2 <= '0'; s3 <= '1'; s4 <= '1'; s5 <= '0';
    wait for 10 ns;

    -- Fine del test
    wait;
  end process;

end;
