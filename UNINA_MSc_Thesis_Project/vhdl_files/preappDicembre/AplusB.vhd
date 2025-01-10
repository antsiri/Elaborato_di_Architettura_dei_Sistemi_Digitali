library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity AplusB is
 Port ( 
        CLK_A, CLK_B, RST: in STD_LOGIC;
        START: in STD_LOGIC;
        stateA, stateB: out STD_LOGIC_VECTOR(1 downto 0);
        count: out STD_LOGIC_VECTOR(2 downto 0);
        result: out STD_LOGIC_VECTOR(3 downto 0)
 );
end AplusB;

architecture Behavioral of AplusB is
component A
 Port (
        CLK, RST: in STD_LOGIC;
        START, ACK: in STD_LOGIC;
        REQ: out STD_LOGIC;
        state: out STD_LOGIC_VECTOR(1 downto 0);
        count: out STD_LOGIC_VECTOR(2 downto 0);
        dout: out STD_LOGIC_VECTOR(3 downto 0)
   );
end component;

component B
Port ( 
            CLK, RST: in STD_LOGIC;
            REQ: in STD_LOGIC;
            din: in STD_LOGIC_VECTOR(3 downto 0);
            ACK: out STD_LOGIC;
            state: out STD_LOGIC_VECTOR(1 downto 0);
            result: out STD_LOGIC_VECTOR(3 downto 0)
      );
end component;

signal temp_ACK, temp_REQ: STD_LOGIC;
signal uA: STD_LOGIC_VECTOR(3 downto 0);
begin

A0: A 
    port map(
        CLK => CLK_A,
        RST => RST,
        START => START,
        ACK => temp_ACK,
        REQ => temp_REQ,
        state => stateA,
        count => count,
        dout => uA
    );
    
B0: B
    port map(
        CLK => CLK_B,
        RST => RST,
        REQ => temp_REQ,
        din => uA,
        ACK => temp_ACK,
        state => stateB,
        result => result
    );
    
end Behavioral;
