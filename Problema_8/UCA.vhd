library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCA is
  Port (
        START: in STD_LOGIC;
        CLK, RST: in STD_LOGIC;
        ACK: in STD_LOGIC;
        count: in STD_LOGIC_VECTOR(2 downto 0);
        REQ: out STD_LOGIC;
        state: out STD_LOGIC_VECTOR(1 downto 0);
        EN_RD, EN_COUNT: out STD_LOGIC      
        
   );
end UCA;

architecture Behavioral of UCA is
type stati is (IDLE, READ, SEND, INCR_COUNT);

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

change: process(current_state, START, ACK, count)
begin
    EN_RD <= '0';
    EN_COUNT <= '0';
    REQ <= '0';
    CASE current_state is
         when IDLE =>
            EN_COUNT <= '0';
             if (START = '1') then
                EN_RD <= '1';
                next_state <= READ;
             else
                next_state <= current_state;
             end if;
          when READ =>
            EN_COUNT <= '0';
            EN_RD <= '0';
              
            next_state <= SEND;
            
           when SEND =>
           REQ <= '1';                
            if (ACK = '0') then
                next_state <= current_state;
             else
                REQ <= '0';
                next_state <= INCR_COUNT;
             end if;
             
            when INCR_COUNT =>
                EN_COUNT <= '1';
               if count = "111" then 
                    next_state <= IDLE;
                 else
                    EN_RD <= '1';
                    next_state <= READ;
             end if;
            
            end CASE;
end process;
  state <= "00" when current_state = IDLE else
            "01" when current_state = READ else
            "10" when current_state = SEND else
            "11" when current_state = INCR_COUNT;  
end Behavioral;
