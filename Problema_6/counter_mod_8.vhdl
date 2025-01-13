library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.ALL;
use     IEEE.std_logic_unsigned.ALL;

entity counter_mod_8 is
    port
    (
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        en_cnt  :   in  std_logic;

        cnt     :   out std_logic_vector(2 downto 0)    
    ); 
end counter_mod_8;

architecture behavioral of counter_mod_8 is
    signal temp_cnt :   std_logic_vector(2 downto 0)    :=  "000";
begin
    process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                temp_cnt <=  "000";
            else
                if en_cnt = '1' then
                    temp_cnt <=  temp_cnt + 1;
                end if;
            end if;
        end if;

        cnt <=  temp_cnt;
    end process;  
end behavioral;