library IEEE;
use IEEE.std_logic_1164.all;

entity mux_41 is
    port
    (
        b: in std_logic_vector(0 to 3);
        c1: in std_logic_vector(1 downto 0);
        f: out std_logic
    );
end mux_41;

architecture structural of mux_41 is
    signal u: std_logic_vector(0 to 1);

    component mux_21 is 
        port (
                a0, a1: in std_logic;
                c0: in std_logic;
                z: out std_logic
            );
    end component;

    begin
        mux0to1: FOR i IN 0 TO 1 GENERATE
            m: mux_21
            port map
            (
                b(i*2),
                b(i*2 + 1),
                c1(0),
                u(i)
            );
        end GENERATE;

        mux_2: mux_21
            port map
            (
                u(0),
                u(1),
                c1(1),
                f
            );

end structural;

