library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seqRecOnBoard is
 Port ( 
        A, reset: in STD_LOGIC;
        load_i, load_M: in STD_LOGIC;
        i, M: in STD_LOGIC;
        Y: out STD_LOGIC;
        led_out: out STD_LOGIC
        
 );
end seqRecOnBoard;

architecture structural of seqRecOnBoard is
component control_unit
    Port ( 
        A, reset: in STD_LOGIC;
        load_in, load_sel: in STD_LOGIC;
        value_in: in STD_LOGIC;
        sel_in: in STD_LOGIC;
        value_out: out STD_LOGIC;
        sel_out: out STD_LOGIC
  );
end component;

component riconoscitore is
    port
    (
        RST:    in  std_logic;
        i:      in  std_logic;
        A:      in  std_logic;
        M:      in  std_logic;
        Y:      out std_logic
    );
end component;

component frequency_divider is
    Port (
        clock_in : in STD_LOGIC;  -- Clock di ingresso
        reset : in STD_LOGIC;     -- Segnale di reset
        clock_out : out STD_LOGIC -- Clock di uscita, divisore di frequenza
    );
 end component;

signal M_cu: STD_LOGIC;
signal i_cu: STD_LOGIC;
signal clock_temp: STD_LOGIC;

begin
cu: control_unit
    port map(
        A => A,
        reset => reset,
        load_in => load_i,
        load_sel => load_M,
        value_in => i,
        sel_in => M,
        value_out => i_cu,
        sel_out => M_cu
    );

sr: riconoscitore 
    port map(  
         RST => reset,
        i => i_cu,
        A => clock_temp,
        M => M_cu,     
        Y => Y
    );
    
fd: frequency_divider
    port map(
        clock_in => A, 
        reset => reset,
        clock_out => clock_temp
    );
led_out <= clock_temp;
end structural;
