library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    generic(N: integer range 0 to 32:= 16);
    port(
        CLK: in STD_LOGIC; --read sincrona
        address: in STD_LOGIC_VECTOR(3 downto 0); --l'indirizzo in ingresso viene dal contatore
        EN_RD: in STD_LOGIC;
        dout: out STD_LOGIC_VECTOR(7 downto 0)
         );
end entity ROM;

architecture Behavioral of ROM is

type MEMORY is array(N-1 downto 0) of STD_LOGIC_VECTOR(7 downto 0); --memoria da N locazioni che contengono 8 bit
constant ROM_N: MEMORY := (
    "01000000",  -- in locazione 15
    "01000001", 
    "01000010", 
    "01000011", 
    "00010100", 
    "01000101", 
    "00000110", 
    "01000111", 
    "00001000", 
    "00001001", 
    "01001010", 
    "00001011", 
    "00001100", 
    "00001101", 
    "10001010", 
    "00001001"  --in locazione 0
);


begin
 
lettura: process(EN_RD, address, CLK)
begin
    if (CLK'event AND CLK = '1') then
    if (EN_RD = '1') then
        dout<= ROM_N(TO_INTEGER(unsigned(address))); --lettura dalla rom
        end if;
        end if;
end process;



end architecture Behavioral;
