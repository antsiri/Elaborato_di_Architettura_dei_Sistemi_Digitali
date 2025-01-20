library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
 Port (
        START, RST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        EN_RD: in STD_LOGIC;
        count: in STD_LOGIC_VECTOR(3 downto 0);
--        stato: out STD_LOGIC_VECTOR(1 downto 0); 
        EN_WR, EN_COUNT: out STD_LOGIC
  );
end control_unit;

architecture Behavioral of control_unit is
type stati is (idle, read, m_work, write);
signal current_state: stati;
signal next_state: stati;

begin

reg_stato: process(CLK, RST)
begin
    if (CLK'event AND CLK = '1') then
        if RST = '1' then
            current_state <= idle;
        else
            current_state <= next_state;
        end if;
        end if;
end process;

change: process(CLK, START, count)
begin
    CASE current_state is
        WHEN idle =>
            EN_COUNT <= '0';
            if (START = '0') then
                next_state <= idle;
            else
                if(EN_RD = '1') then
                    next_state <= read;
                else
                    next_state <= idle;
                end if;
            end if;
        WHEN read => 
            EN_COUNT <= '0';
            next_state <= M_work;
        WHEN M_work =>
            EN_WR <= '1';
            next_state <= write;
        WHEN write => 
            EN_WR <= '0';
            EN_COUNT <= '1';
            if (count = "1111") then
                next_state <= idle;
            else 
                if EN_RD = '1' then 
                    next_state <= read;
                else
                    EN_COUNT <= '0';
                    next_state <= current_state;
                end if;
            end if;
            
         end CASE;

end process;

--stato <= "00" when current_state = idle else
--         "01" when current_state = read else
--         "10" when current_state = m_work else
--         "11" when current_state = write;  -- Associare a ogni stato un codice binario

end Behavioral;
