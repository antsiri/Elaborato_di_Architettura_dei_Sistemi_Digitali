library IEEE;
use IEEE.std_logic_1164.all;

entity mux_41 is
    port
    (
        i: in std_logic_vector(0 to 3);
        s: in std_logic_vector(1 downto 0);
        u: out std_logic
    );
end mux_41;

architecture structural of mux_41 is
    signal u_mid: std_logic_vector(0 to 1);

    component mux_21 is 
        port (
                i0, i1: in std_logic;
                s0: in std_logic;
                u: out std_logic
            );
    end component;

    begin
        mux0to1: FOR k IN 0 TO 1 GENERATE
            m: mux_21
            port map
            (
                i(k*2),
                i(k*2 + 1),
                s(0),
                u_mid(k)
            );
        end GENERATE;

        mux_2: mux_21
            port map
            (
                u_mid(0),
                u_mid(1),
                s(1),
                u
            );

end structural;

