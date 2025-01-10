library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A is
  Port (
        CLK, RST: in STD_LOGIC;
        START, ACK: in STD_LOGIC;
        REQ: out STD_LOGIC;
        state: out STD_LOGIC_VECTOR(1 downto 0);
        count: out STD_LOGIC_VECTOR(2 downto 0);
        dout: out STD_LOGIC_VECTOR(3 downto 0)
   );
end A;

architecture structural of A is

component unita_operativa
 Port (
        CLK, RST, EN_COUNT: in STD_LOGIC;
        READ: in STD_LOGIC;
        count: out STD_LOGIC_VECTOR(2 downto 0);
        dout: out STD_LOGIC_VECTOR(3 downto 0)       
         );
end component;

component UCA
 Port (
        START: in STD_LOGIC;
        CLK, RST: in STD_LOGIC;
        ACK: in STD_LOGIC;
        count: in STD_LOGIC_VECTOR(2 downto 0);
        REQ: out STD_LOGIC;
        state: out STD_LOGIC_VECTOR(1 downto 0);
        EN_RD, EN_COUNT: out STD_LOGIC            
   );
end component;

signal temp_count: STD_LOGIC_VECTOR(2 downto 0);
signal temp_RD, temp_enable: STD_LOGIC; 
begin
uo: unita_operativa
    port map(
        CLK => CLK,
        RST => RST,
        EN_COUNT => temp_enable,
        READ => temp_RD,
        count => temp_count,
        dout => dout
    );
    
uc: UCA
    port map(
        START => START,
        CLK => CLK,
        RST => RST,
        ACK => ACK,
        count => temp_count,
        REQ => REQ,
        state => state,
        EN_RD => temp_RD,
        EN_COUNT => temp_enable
    );

count <= temp_count;

end structural;
