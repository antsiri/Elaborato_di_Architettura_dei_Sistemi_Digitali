library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROMplusM is
      Port (
        A: in std_logic_vector(3 downto 0); --indirizzo in ingresso al sistema
        bout: out std_logic_vector(3 downto 0) --uscita complessiva del sistema
       );
end ROMplusM;

architecture structural of ROMplusM is
signal u0 : std_logic_vector(7 downto 0) := "00000000";

component ROM
            port(
                address: in STD_LOGIC_VECTOR(3 downto 0);
                dout: out STD_LOGIC_VECTOR(7 downto 0)
            );
            end component;
component M 
           port(
            ingresso: in std_logic_vector(7 downto 0);
            uscita: out std_logic_vector(3 downto 0)
           );
           end component;
           
begin
-- Istanza della ROM
rom_instance: ROM
    port map(
        address => A,
        dout => u0
    );
-- Istanza della macchina combinatoria M
    transform: M
        port map(
            ingresso => u0,
            uscita => bout
        );
end structural;
