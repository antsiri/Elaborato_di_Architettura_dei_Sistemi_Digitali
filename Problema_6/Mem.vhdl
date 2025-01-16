library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;
use ieee.numeric_std.all;

entity Mem is
    port 
    (
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        en_wr   :   in  std_logic;

        addr    :   in  std_logic_vector(2 downto 0);
        data_in :   in  std_logic_vector(7 downto 0)

    );
end entity;

architecture behavioral of Mem is
    type mem_type is array(0 to 7) of std_logic_vector(7 downto 0);
    signal MEM_STORE    :   mem_type;
begin
    process(clk, addr)
    begin
        if clk'event and clk='1' then
            if rst = '1' then
                for i in 0 to 7 loop
                    MEM_STORE(i)  <=  (others=>'0');
                end loop;
            else
                if en_wr = '1' then
                    MEM_STORE(to_integer(unsigned(addr)))  <=  data_in;
                end if;
            end if;
        end if;
    end process;

end behavioral;