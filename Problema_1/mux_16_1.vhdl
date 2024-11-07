library IEEE;
use IEEE.std_logic_1164.all;

entity mux_161 is
    port 
    (
        x: in std_logic_vector(0 to 15);
        c: in std_logic_vector(3 downto 0);
        u: out std_logic;
    );
end mux_161;

architecture structural of mux_161 is

    signal f: std_logic_vector(0 to 3);

    component mux_41 is 
        port 
        (
            b: in std_logic_vector(0 to 3);
            c1: in std_logic_vector(1 downto 0);
            f: out std_logic
        )

        begin
            mux0to3: FOR 1 IN 0 TO 3 GENERATE
                m: mux_41
                port map
                (
                    x(i*4 to i*4 + 15);
                    s( 1 downto 0);
                );
            end GENERATE;
    
            mux_2: mux_41
                port map
                (
                    f(0);
                    f(1);
                    f(2);
                    f(3);
                    c1(2);
                    c1(3);
                    f;
                );

end structural;