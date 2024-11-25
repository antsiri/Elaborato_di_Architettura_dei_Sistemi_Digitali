library IEEE;
use IEEE.std_logic_1164.all;

entity mux_161 is
    port 
    (
        i: in std_logic_vector(0 to 15);
        s: in std_logic_vector(3 downto 0);
        u: out std_logic
    );
end mux_161;

architecture structural of mux_161 is

    signal u_mid: std_logic_vector(0 to 3);

    component mux_41 is 
        port 
        (
            i: in std_logic_vector(0 to 3);
            s: in std_logic_vector(0 to 1);
            u: out std_logic
        );
    end component;

    begin
        mux0to3: FOR k IN 0 TO 3 GENERATE
            m: mux_41
            port map
            (
                i => i((k*4) to (k*4 + 3)),
                s => s(1 downto 0),
                u => u_mid(k)
            );
        end GENERATE;

        mux_2: mux_41
            port map
            (
                i => u_mid,
                s => s(3 downto 2),
                u => u 
            );

end structural;