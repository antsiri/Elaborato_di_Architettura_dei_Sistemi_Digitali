library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AplusB is
 Port (
        CLK_A, CLK_B, RST: in STD_LOGIC;
        START: in STD_LOGIC;
        X: out std_logic_vector(7 downto 0);
        Y: out std_logic_vector(7 downto 0);
        result: out STD_LOGIC_VECTOR(7 downto 0)
--        count_A: out std_logic_vector(3 downto 0);
--        count_B: out std_logic_vector(3 downto 0);
--        stato_A: out STD_LOGIC_VECTOR(1 downto 0);
--        stato_B: out STD_LOGIC_VECTOR(2 downto 0)
  );
end AplusB;

architecture structural of AplusB is

component nodo_A
Port ( 
        START: in STD_LOGIC;
        CLK, RST: in STD_LOGIC;
        X: out STD_LOGIC_VECTOR(7 downto 0);
        ACK: in STD_LOGIC;
        REQ: out STD_LOGIC
--        count: out std_logic_vector(3 downto 0);
--        stato: out STD_LOGIC_VECTOR(1 downto 0)
          );
end component;

component nodo_B
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
end component;

signal temp_X: STD_LOGIC_VECTOR(7 downto 0);
signal temp_ACK, temp_REQ: STD_LOGIC;
--signal temp_count_A, temp_count_B: STD_LOGIC_VECTOR(3 downto 0);
begin

A: nodo_A
    port map(
        START => START,
        CLK => CLK_A,
        RST => RST,
        X => temp_X,
        ACK => temp_ACK,
        REQ => temp_REQ
--        count => count_A,
--        stato => stato_A
    );

B: nodo_B
    port map(
        CLK => CLK_B,
        RST => RST,
        X => temp_X,
        REQ => temp_REQ,
        ACK => temp_ACK,
--        stato => stato_B,
--        count => count_B,
        Y => Y,
        result => result
    );
X <= temp_X;
-- count_B <= temp_count_B;
end structural;
