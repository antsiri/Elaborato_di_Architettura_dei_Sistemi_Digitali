
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
    port(
        address: in STD_LOGIC_VECTOR(3 downto 0); 
        dout: out STD_LOGIC_VECTOR(7 downto 0)
         );
end entity ROM;

architecture RTL of ROM is

type MEMORY is array(15 downto 0) of STD_LOGIC_VECTOR(7 downto 0); --memoria da N locazioni che contengono 8 bit
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
main: process(address)
begin
dout<= ROM_N(TO_INTEGER(unsigned(address))); --lettura dalla rom
end process main;
end architecture RTL;
