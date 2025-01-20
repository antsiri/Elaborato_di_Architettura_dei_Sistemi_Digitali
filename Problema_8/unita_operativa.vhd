library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa is
  Port (
        CLK, RST, EN_COUNT: in STD_LOGIC;
        READ: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR(2 downto 0);
        dout: out STD_LOGIC_VECTOR(3 downto 0)
        
         );
end unita_operativa;

architecture Behavioral of unita_operativa is

component counter_mod8
 Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component ROM
 Port (
        address: in std_logic_vector(2 downto 0);
        CLK, EN_RD: in std_logic;
        dout: out std_logic_vector(3 downto 0)
   );
end component;

signal temp_count: STD_LOGIC_VECTOR(2 downto 0);

begin

counter: counter_mod8
    port map(
        clock => CLK,
        reset => RST,
        enable => EN_COUNT,
        counter => temp_count
    );

mem: ROM
    port map(
        address => temp_count,
        CLK => CLK,
        EN_RD => READ,
        dout => dout
    );
    
count <= temp_count;
end Behavioral;
