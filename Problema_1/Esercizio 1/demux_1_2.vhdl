library IEEE;
use IEEE.std_logic_1164.all;

entity demux_12 is 
    port
    (
        i: in std_logic;
        s: in std_logic;
        u0: out std_logic;
        u1: out std_logic
    );
end demux_12;

architecture rtl of demux_12 is
    begin
        u0 <= (not s) and i;
        u1 <= s and i; 
end rtl;
