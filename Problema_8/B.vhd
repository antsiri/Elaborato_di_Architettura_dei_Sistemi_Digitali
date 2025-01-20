library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B is
      Port ( 
            CLK, RST: in STD_LOGIC;
            REQ: in STD_LOGIC;
            din: in STD_LOGIC_VECTOR(3 downto 0);
            ACK: out STD_LOGIC;
            state: out STD_LOGIC_VECTOR(1 downto 0);
            result: out STD_LOGIC_VECTOR(3 downto 0)
      );
end B;

architecture structural of B is
component unita_operativaB
Port ( 
        CLK, RST: in STD_LOGIC;
        selA: in STD_LOGIC;
        din: in STD_LOGIC_VECTOR(3 downto 0);
        load_A: in STD_LOGIC;
        result: out STD_LOGIC_VECTOR(3 downto 0)
        
  );
end component;

component UCB
Port ( 
        CLK, RST: in STD_LOGIC;
        REQ: in STD_LOGIC;
        state: out STD_LOGIC_VECTOR(1 downto 0);
        EN_WRITE, ACK, selA: out STD_LOGIC
  );
end component;
signal temp_load, temp_en_sum, temp_sel: STD_LOGIC;
begin

uo: unita_operativaB
    port map(
        CLK => CLK,
        RST => RST,
        selA => temp_sel,
        din => din,
        load_A => temp_load,
        result => result
     );

uc: UCB
    port map(
        CLK => CLK,
        RST => RST,
        REQ => REQ,
        state => state,
        EN_WRITE => temp_load,
        ACK => ACK,
        selA => temp_sel
    
    );

end structural;
