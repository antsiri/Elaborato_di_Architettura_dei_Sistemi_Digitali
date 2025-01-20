library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seqRecOnBoard is
  Port (
        A: in STD_LOGIC;
        in_value, M_value: in STD_LOGIC;
        reset: in STD_LOGIC;
        load_in, load_M: in STD_LOGIC;
        Y_b: out STD_LOGIC
   );
end seqRecOnBoard;

architecture structural of seqRecOnBoard is
component seqRec
    Port (
            i: in std_logic; 
            reset: in std_logic;
            A: in std_logic;
            M: in std_logic; 
            Y: out std_logic
          );
end component;

component control_unit
Port (
        A: in STD_LOGIC;
        reset: in STD_LOGIC; 
        load_in: in STD_LOGIC; 
        load_M: in STD_LOGIC; 
        value_in: in STD_LOGIC;
        M_in: in STD_LOGIC;
        i_out: out STD_LOGIC;
        M_out: out STD_LOGIC
   );
end component;

signal i_cu: STD_LOGIC;
signal M_cu: STD_LOGIC;
begin

cu: control_unit
    port map(
        A => A,
        reset => reset,
        load_in => load_in,
        load_M => load_M,
        value_in => in_value,
        M_in => M_value,
        i_out => i_cu,
        M_out => M_cu      
    );

rec: seqRec 
    port map(
        i => i_cu,
        reset => reset,
        A => A,
        M => M_cu,
        Y => Y_b
    );

end structural;
