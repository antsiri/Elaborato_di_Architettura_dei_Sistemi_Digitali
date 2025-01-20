library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
  Port (
        address: in std_logic_vector(2 downto 0);
        CLK, EN_RD: in std_logic;
        dout: out std_logic_vector(3 downto 0)
   );
end ROM;

architecture Behavioral of ROM is
type MEMO is array(0 to 7) of std_logic_vector(3 downto 0);

constant ROM: MEMO :=(
    "0000",
    "1100",
    "0010",
    "1010",
    "0001",
    "1111",
    "0101",
    "0011"
);

begin
main: process(CLK)
begin
    if (CLK'event AND CLK = '1') then
        if (EN_RD = '1') then
         dout <= ROM(TO_INTEGER(unsigned(address)));
         end if;
     end if;
   end process;

end Behavioral;
