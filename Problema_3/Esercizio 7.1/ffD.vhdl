library ieee;
use     ieee.std_logic_1164.all;

entity ffD is 
    port 
    (
        clk         :   in  std_logic;
        en          :   in  std_logic;
        rst         :   in  std_logic;
        preset      :   in  std_logic;
        input       :   in  std_logic;
        output      :   out std_logic;
        not_output  :   out std_logic
    );
end entity;

architecture behavioral of ffD is
    signal  temp    :   std_logic;

begin
    process(clk)
    begin
        if(clk'event and clk='1') then
            if rst = '1' then
                temp    <=  '0';
            elsif en = '1' then
                if preset = '1' then
                    temp    <=  '1';
                else 
                    temp    <=  input;
                end if;
            end if;
        end if;
    end process;
    output      <=  temp;
    not_output  <=  not temp;
end behavioral;