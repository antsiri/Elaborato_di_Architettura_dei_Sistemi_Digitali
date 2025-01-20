library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodo_A is
  Port ( 
        START: in STD_LOGIC;
        CLK, RST: in STD_LOGIC;
        X: out STD_LOGIC_VECTOR(7 downto 0);
        ACK: in STD_LOGIC;
        REQ: out STD_LOGIC
--        count: out std_logic_vector(3 downto 0);
--        stato: out STD_LOGIC_VECTOR(1 downto 0)
          );
end nodo_A;

architecture structural of nodo_A is

component unita_operativa_A
Port (    
        CLK, RST: in STD_LOGIC;
        EN_RD, EN_COUNT: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR(3 downto 0);
        X: out STD_LOGIC_VECTOR(7 downto 0)
   );
end component;

component UCA
Port (
           START, CLK, RST: in STD_LOGIC;
           ACK: in STD_LOGIC;
           count: in STD_LOGIC_VECTOR(3 downto 0);
           REQ: out STD_LOGIC;
           EN_COUNT, EN_RD: out STD_LOGIC
--           stato: out STD_LOGIC_VECTOR(1 downto 0)
         );
end component;

signal en_rd_temp, en_count_temp: STD_LOGIC;
signal temp_count : STD_LOGIC_VECTOR(3 downto 0);

begin
uo: unita_operativa_A
    port map(
        CLK => CLK,
        RST  => RST,
        EN_RD => en_rd_temp,
        EN_COUNT => en_count_temp,
        count  => temp_count,
        X => X
    );

uc: UCA
    port map(
        START => START,
        CLK => CLK,
        RST => RST,
        ACK => ACK,
        count => temp_count,
        REQ => REQ,
        EN_COUNT =>en_count_temp,
        EN_RD => en_rd_temp
--        stato  => stato
    );
--count <= temp_count;
end structural;
