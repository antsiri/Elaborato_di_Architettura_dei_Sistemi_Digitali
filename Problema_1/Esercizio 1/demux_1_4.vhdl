library IEEE; 
use IEEE.std_logic_1164.all;

entity demux_14 is 
    port
    (
        i: in std_logic;
        s: in std_logic_vector(1 downto 0);
        u: out std_logic_vector(0 to 3)
    );
end demux_14;

architecture structural of demux_14 is

    signal mid_u: std_logic_vector(0 to 1);

    component demux_21 is
        port 
        (
            i: in std_logic;
            s: in std_logic;
            u0: out std_logic;
            u1: out std_logic
        );
    end component;

    begin
        dem_1: demux_21
            port map
            (
                i,
                s(0),
                mid_u(0),
                mid_u(1)
            );

        dem1t02: FOR k IN 0 TO 1 GENERATE
            d: demux_21
            port map
            (
                mid_u(k),
                s(1),
                u(k*2),
                u(k*2 + 1)
            );
        end GENERATE;

end structural;