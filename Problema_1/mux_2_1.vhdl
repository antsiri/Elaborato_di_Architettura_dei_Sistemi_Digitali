library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_21 is
    port
    (
        i0, i1: in std_logic;
        s0: in std_logic;
        u: out std_logic
    );
end mux_21;

architecture rtl of mux_21 is
begin
    u <= i0 when s0='0' else
        i1 when s0='1' else
        '-';
end rtl;