library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa_A is
  Port (    
        CLK, RST: in STD_LOGIC;
        EN_RD, EN_COUNT: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR(3 downto 0);
        X: out STD_LOGIC_VECTOR(7 downto 0)
   );
end unita_operativa_A;

architecture structural of unita_operativa_A is

component counter_modN
generic (N: integer range 0 to 32:= 16);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component MEM_A
generic(N: integer range 0 to 32:= 16);
    port(
        CLK: in STD_LOGIC; --La read è sincrona
        address: in STD_LOGIC_VECTOR(3 downto 0); --l'indirizzo in ingresso me lo da il contatore
        EN_RD: in STD_LOGIC;
        dout: out STD_LOGIC_VECTOR(7 downto 0)
         );
end component;

signal temp_c: STD_LOGIC_VECTOR(3 downto 0);

begin
counter: counter_modN
        port map(
            clock => CLK,
            reset => RST,
            enable => EN_COUNT,
            counter => temp_c
        );
        
mem: MEM_A
        port map(
            CLK => CLK,
            address => temp_c,
            EN_RD => EN_RD,
            dout => X        
        );
count <= temp_c;
end structural;
