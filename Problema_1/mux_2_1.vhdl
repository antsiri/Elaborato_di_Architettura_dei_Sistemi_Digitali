library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_21 is
    port
    (
        a0, a1: in std_logic;
        c0: in std_logic;
        z: out std_logic
    );
end mux_21;

architecture rtl of mux_21 is
begin
    z <= a0 when c0='0' else
        a1 when c0='1' else
        '-';
end rtl;