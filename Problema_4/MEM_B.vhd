library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEM_B is
    generic(N: integer range 0 to 32:= 16);
    port(
        CLK: in STD_LOGIC; --La read è sincrona
        address: in STD_LOGIC_VECTOR(3 downto 0); 
        value_in: in STD_LOGIC_VECTOR(7 downto 0);
        EN_RD: in STD_LOGIC;
        EN_WR: in STD_LOGIC;
        dout: out STD_LOGIC_VECTOR(7 downto 0)
         );
end entity MEM_B;

architecture Behavioral of MEM_B is

type MEMORY is array(N-1 downto 0) of STD_LOGIC_VECTOR(7 downto 0); --memoria da N locazioni che contengono 8 bit
signal MEM_N: MEMORY := (
        15 => "00001000",  -- in locazione 15
        14 => "01000001", 
        13 => "01000010", 
        12 => "01000011", 
        11 => "00010100", 
        10 => "01000101", 
        9  => "00000110", 
        8  => "00000000", 
        7  => "00001000", 
        6  => "00000100", 
        5  => "01001010", 
        4  => "00001000", 
        3  => "00001100", 
        2  => "00000001", 
        1  => "00000000", 
        0  => "00000001"  -- in locazione 0
);


begin
 
lettura: process(EN_RD, address, CLK, value_in)
begin
    if (CLK'event AND CLK = '1') then
    if (EN_RD = '1') then
        dout<= MEM_N(TO_INTEGER(unsigned(address))); --lettura dalla rom
        end if;
    if (EN_WR = '1') then
        MEM_N(TO_INTEGER(unsigned(address))) <= value_in;
        end if;
        end if;
end process;



end architecture Behavioral;
