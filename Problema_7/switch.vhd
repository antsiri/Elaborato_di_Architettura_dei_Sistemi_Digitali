library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
  Port (
        i0: in STD_LOGIC_VECTOR(1 downto 0);
        i1: in STD_LOGIC_VECTOR(1 downto 0);
        source_add: in STD_LOGIC;
        dest_add: in STD_LOGIC;
        u0: out STD_LOGIC_VECTOR(1 downto 0);
        u1: out STD_LOGIC_VECTOR(1 downto 0)
     );
end switch;

architecture structural of switch is
component mux2_1
    Port ( 
            i0: in STD_LOGIC_VECTOR(1 downto 0);
            i1: in STD_LOGIC_VECTOR(1 downto 0);
            s: in STD_LOGIC;
            u: out STD_LOGIC_VECTOR(1 downto 0)
      );
end component;

component demux1_2
    Port (
        i: in STD_LOGIC_VECTOR(1 downto 0);
        s: in STD_LOGIC;
        u0: out STD_LOGIC_VECTOR(1 downto 0);
        u1: out STD_LOGIC_VECTOR(1 downto 0)
   );
end component;
signal u_mux: STD_LOGIC_VECTOR(1 downto 0);
begin
    mux: mux2_1
        port map(
            i0 => i0,
            i1 => i1, 
            s => source_add,
            u => u_mux
        );
        
   demux: demux1_2
        port map(
            i => u_mux,
            s => dest_add,
            u0 => u0,
            u1 => u1
        );

end structural;
