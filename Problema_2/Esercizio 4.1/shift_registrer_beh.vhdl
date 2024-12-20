library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_registrer_beh is 
    generic ( N: integer := 8 );    --lunghezza registro

    port
    (
        clk: in std_logic;
        rst: in std_logic;
        en: in std_logic;
        y: in std_logic_vector(1 downto 0);
        data_in: in std_logic_vector(1 downto 0);
        data_out: out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture behavioral of shift_registrer_beh is
    signal reg: std_logic_vector(N-1 downto 0);

    begin
        process(clk)
        begin
            if (rising_edge(clk)) then
                if (rst = '1') then
                    reg <= (others => '0');
                end if;

                if (en = '1') then
                    case y is 
                        when "00" =>        --shift a sinistra di 1
                            reg(7 downto 1) <= reg(6 downto 0);
                            reg(0) <= data_in(0);
                        when "01" =>        --shift a sinistra di 2
                            reg(7 downto 2) <= reg(5 downto 0);
                            reg(1) <= data_in(1);
                            reg(0) <= data_in(0);
                        when "10" =>        --shift a destra di 1
                            reg(6 downto 0) <= reg(7 downto 1);
                            reg(7) <= data_in(0);
                        when "11" =>        --shif a destra di 2
                            reg(5 downto 0) <= reg(6 downto 1);
                            reg(6) <= data_in(0);
                            reg(7) <= data_in(1);
                        when others =>
                            null;
                    end case;
                end if;
            end if;
        end process;
        data_out <= reg;
end behavioral;