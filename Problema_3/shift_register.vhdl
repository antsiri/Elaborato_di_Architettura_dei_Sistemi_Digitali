library ieee;
use     ieee.std_logic_1164.all;

entity shift_register is
    port
    (
        clk         :   in  std_logic;
        rst         :   in  std_logic;

        en_wrt      :   in  std_logic;
        en_shf      :   in  std_logic;
        
        value_rst   :   in  std_logic_vector(7 downto 0);
        value_in    :   in  std_logic_vector(7 downto 0);

        bit_in      :   in  std_logic;

        value_out   :   out std_logic_vector(7 downto 0);
        bit_out     :   out std_logic
    );
end shift_register;

architecture behavioral of shift_register is
    signal  temp_out    :   std_logic_vector(7 downto 0);

begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            if rst = '1' then
                temp_out    <=  value_rst;

            else
                if en_wrt = '1' then
                    temp_out    <=  value_in;
                elsif en_shf = '1' then
                    temp_out(6 downto 0)    <= temp_out(7 downto 1);
                    temp_out(7)             <=  bit_in;
                end if;
            end if;
        end if;
        value_out   <=  temp_out;
        bit_out     <=  temp_out(0);
    end process;

end behavioral;
