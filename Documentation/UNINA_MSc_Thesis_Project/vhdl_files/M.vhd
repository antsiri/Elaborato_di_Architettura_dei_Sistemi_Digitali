library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity M is
    port(
    ingresso: in std_logic_vector(7 downto 0);
    uscita: out std_logic_vector(3 downto 0)
    );
    
end entity M;

architecture Behavioral of M is
begin
    process(ingresso)
    begin
        -- Somma dei 4 bit più significativi e dei 4 meno significativi
     uscita <= std_logic_vector(unsigned(ingresso(7 downto 4)) + unsigned(ingresso(3 downto 0)));
    end process;
end Behavioral;


