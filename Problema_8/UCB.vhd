library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCB is
  Port ( 
        CLK, RST: in STD_LOGIC;
        REQ: in STD_LOGIC;
        state: out STD_LOGIC_VECTOR(1 downto 0);
        ACK: out STD_LOGIC;
        selA, EN_WRITE: out STD_LOGIC:= '0'
  );
end UCB;

architecture Behavioral of UCB is
type stati is (IDLE, RECEIVE, WRITE);

signal current_state: stati;
signal next_state: stati;

begin

reg_stato: process(CLK, RST)
begin
    if (CLK'event AND CLK = '1') then
        if (RST = '1') then
            current_state <= IDLE;
         else
            current_state <= next_state;
         end if;
   end if;
end process;

change: process(current_state, REQ)
begin

    CASE current_state is
        when IDLE =>
            EN_WRITE <= '0';
            ACK <= '0';
            if REQ = '0' then
                next_state <= current_state;
            else 
                next_state <= RECEIVE;
            end if;
         when RECEIVE =>
                ACK <= '1';
                if REQ = '1' then
                    next_state <= current_state;
                else
                    selA <= '1';
                    next_state <= WRITE;
                end if;
        
         when WRITE =>
            EN_WRITE <= '1';
            next_state <= IDLE;
         
         end CASE;
         
end process;
         state <= "00" when current_state = IDLE else
            "01" when current_state = RECEIVE else
            "10" when current_state = WRITE;    

end Behavioral;
