library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodo_B is
  Port (
        CLK, RST: in STD_LOGIC;
        X: in STD_LOGIC_VECTOR(7 downto 0);
        REQ: in STD_LOGIC;
        ACK: out STD_LOGIC;
--        stato: out STD_LOGIC_VECTOR(2 downto 0);
--        count: out std_logic_vector(3 downto 0);
        Y: out std_logic_vector(7 downto 0);
        result: out STD_LOGIC_VECTOR(7 downto 0)
   );
end nodo_B;

architecture structural of nodo_B is

component unita_operativa_B
Port ( 
        CLK, RST: in STD_LOGIC;
        EN_RD, EN_WR, EN_COUNT: in STD_LOGIC;
        X: in STD_LOGIC_VECTOR(7 downto 0);
        Y: out std_logic_vector(7 downto 0);
        count: out STD_LOGIC_VECTOR(3 downto 0);
        result: out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;

component UCB
Port (
        CLK, RST: in STD_LOGIC;
        REQ: in STD_LOGIC;
        count: in STD_LOGIC_VECTOR(3 downto 0);
        ACK: out STD_LOGIC;
        EN_COUNT, EN_RD, EN_WR: out STD_LOGIC
--        stato: out STD_LOGIC_VECTOR(2 downto 0)      
   );
end component;

signal temp_en_rd, temp_en_wr, temp_en_count: STD_LOGIC;
signal temp_count: STD_LOGIC_VECTOR(3 downto 0);

begin

uo: unita_operativa_B
    port map(
        CLK => CLK,
        RST => RST,
        EN_RD => temp_en_rd,
        EN_WR => temp_en_wr,
        EN_COUNT => temp_en_count,
        X => X,
        Y => Y,
        count => temp_count,
        result => result
    );

uc: UCB
    port map(
        CLK => CLK,
        RST => RST,
        REQ => REQ,
        count => temp_count,
        ACK => ACK,
        EN_COUNT => temp_en_count,
        EN_RD => temp_en_rd,
        EN_WR => temp_en_wr
--        stato => stato
    );
--count <= temp_count;

end structural;
