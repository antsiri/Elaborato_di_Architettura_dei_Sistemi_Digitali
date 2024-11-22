library IEEE;
use IEEE.std_logic_1164.all;

entity mux_161 is
    port 
    (
        x: in std_logic_vector(0 to 15);
        c: in std_logic_vector(3 downto 0);
        u: out std_logic
    );
end mux_161;

library IEEE;
use IEEE.std_logic_1164.all;

architecture structural of mux_161 is

    signal f: std_logic_vector(0 to 3);

    component mux_41 is 
        port 
        (
            b: in std_logic_vector(0 to 3);
            c1: in std_logic_vector(0 to 1);
            f: out std_logic
        );
    end component;

    begin
        mux0to3: FOR i IN 0 TO 3 GENERATE
            m: mux_41
            port map
            (
                b => x((i*4) to (i*4 + 3)),
                c1 => c( 1 downto 0),
                f => f(i)
            );
        end GENERATE;

        mux_2: mux_41
            port map
            (
                b => f,
                c1 => c(3 downto 2),
                f => u
            );

end structural;