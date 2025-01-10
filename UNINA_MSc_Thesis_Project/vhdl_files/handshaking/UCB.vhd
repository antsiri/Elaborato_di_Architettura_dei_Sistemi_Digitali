library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCB is
  Port (
        CLK, RST: in STD_LOGIC;
        REQ: in STD_LOGIC;
        count: in STD_LOGIC_VECTOR(3 downto 0);
        ACK: out STD_LOGIC;
        EN_COUNT, EN_RD, EN_WR: out STD_LOGIC
--        stato: out STD_LOGIC_VECTOR(2 downto 0)      
   );
end UCB;

architecture Behavioral of UCB is

type stati is (IDLE, RECEIVE, READ, WRITE);
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
            EN_COUNT <= '0';
            EN_WR <= '0';
            ACK <= '0';
            if REQ = '0' then
                next_state <= current_state;
             else     
                next_state <= RECEIVE;
             end if;
         when RECEIVE =>
            ACK <= '1';
           EN_RD <= '1';
            if REQ = '1' then
                next_state <= current_state;
             else                            
                next_state <= READ;
             end if;
          when READ =>
                ACK <= '0';
               EN_RD <= '0';
               next_state <= WRITE;
          when WRITE =>
            EN_WR <= '1';
            EN_COUNT <= '1';
             next_state <= IDLE;
          end CASE;
end process;
          
--stato <= "000" when current_state = IDLE else
--         "001" when current_state = RECEIVE else
--         "010" when current_state = READ else
--         "011" when current_state = WRITE;    
                  
                
end Behavioral;
