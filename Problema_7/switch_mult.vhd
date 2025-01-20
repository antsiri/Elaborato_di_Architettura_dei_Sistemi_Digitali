library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_mult is
     Port ( 
            en: in STD_LOGIC_VECTOR(3 downto 0);
            in0, in1, in2, in3: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in0: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in1: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in2: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in3: in STD_LOGIC_VECTOR(1 downto 0);
            out0, out1, out2, out3: out STD_LOGIC_VECTOR(1 downto 0)
     );
end switch_mult;

architecture structural of switch_mult is

component omega_network
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
end component;

component control_unit
Port (
    enable : in STD_LOGIC_VECTOR(3 downto 0); --segnali di ingresso per la gestione della priorita'
    dest_address0: in STD_LOGIC_VECTOR(1 downto 0);
    dest_address1: in STD_LOGIC_VECTOR(1 downto 0);
    dest_address2: in STD_LOGIC_VECTOR(1 downto 0);
    dest_address3: in STD_LOGIC_VECTOR(1 downto 0);
    source_address : out STD_LOGIC_VECTOR(1 downto 0);
    dest_address   : out STD_LOGIC_VECTOR(1 downto 0)
  );
end component;

signal temp_source_add, temp_dest_add: STD_LOGIC_VECTOR(1 downto 0);

begin

cu: control_unit
    port map(
        enable => en,
        dest_address0 => destination_in0,
        dest_address1 => destination_in1,
        dest_address2 => destination_in2,
        dest_address3 => destination_in3,
        source_address => temp_source_add,
        dest_address  => temp_dest_add
    );
    
ou: omega_network
    port map(
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
        source_add => temp_source_add,
        dest_add => temp_dest_add,
        out0 => out0,
        out1 => out1,
        out2 => out2,
        out3 => out3
    );

end structural;
