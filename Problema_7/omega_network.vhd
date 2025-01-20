library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity omega_network is
 Port (
       in0: in STD_LOGIC_VECTOR(1 downto 0);
       in1: in STD_LOGIC_VECTOR(1 downto 0);
       in2: in STD_LOGIC_VECTOR(1 downto 0);
       in3: in STD_LOGIC_VECTOR(1 downto 0);
       source_add: in STD_LOGIC_VECTOR(1 downto 0);
       dest_add: in STD_LOGIC_VECTOR(1 downto 0);
       out0: out STD_LOGIC_VECTOR(1 downto 0);
       out1: out STD_LOGIC_VECTOR(1 downto 0);
       out2: out STD_LOGIC_VECTOR(1 downto 0);
       out3: out STD_LOGIC_VECTOR(1 downto 0)
        
  );
end omega_network;

architecture Behavioral of omega_network is
component switch
    Port (
        i0: in STD_LOGIC_VECTOR(1 downto 0);
        i1: in STD_LOGIC_VECTOR(1 downto 0);
        source_add: in STD_LOGIC;
        dest_add: in STD_LOGIC;
        u0: out STD_LOGIC_VECTOR(1 downto 0);
        u1: out STD_LOGIC_VECTOR(1 downto 0)
     );
end component;
signal interm_0, interm_1, interm_2, interm_3 : STD_LOGIC_VECTOR(1 downto 0);
begin
--primo stadio
sw0: switch
    port map(
        i0 =>  in0,
        i1 => in2,
        source_add => source_add(0),
        dest_add => dest_add(0),
        u0 => interm_0,
        u1 => interm_1
    );
 
 sw1: switch
    port map(
        i0 =>  in1,
        i1 => in3,
        source_add => source_add(0),
        dest_add => dest_add(0),
        u0 => interm_2,
        u1 => interm_3
    );
    --secondo stadio
 sw2: switch
    port map(
        i0 =>  interm_0,
        i1 => interm_2,
        source_add => source_add(1),
        dest_add => dest_add(1),
        u0 => out0,
        u1 => out1
    );

 sw3: switch
    port map(
        i0 =>  interm_1,
        i1 => interm_3,
        source_add => source_add(1),
        dest_add => dest_add(1),
        u0 => out2,
        u1 => out3
    );


end Behavioral;
