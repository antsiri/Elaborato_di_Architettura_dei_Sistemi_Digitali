library IEEE;
use IEEE.std_logic_1164.all;

entity inter_164 is
    port
    (
        i: in std_logic_vector(0 to 15);
        s: in std_logic_vector(5 downto 0);
        u: out std_logic_vector(0 to 3)
    );
end inter_164;

architecture structural of inter_164 is
    signal mid_u: std_logic;
    
    component mux_161 is 
        port
        (
            i1: in std_logic_vector(0 to 15);
            s1: in std_logic_vector(3 downto 0);
            u1: out std_logic
        );
    end component;

    component demux_14 is
        port
        (
            i2: in std_logic;
            s2: in std_logic_vector(1 downto 0);
            u2: out std_logic_vector(0 to 3)
        );
    end component;

    begin
        mux: mux_161
            port map
            (
                i,
                s(3 downto 0),
                mid_u
            );

        dem: demux_14
            port map
            (
                mid_u,
                s(5 downto 4),
                u
            );

end structural;