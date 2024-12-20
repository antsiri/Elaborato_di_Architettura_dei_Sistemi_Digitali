library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is 
port
(
    clk:        in  std_logic;
    rst:        in  std_logic;
    en:         in  std_logic;
    y:          in  std_logic_vector(1 downto 0);
    data_in:    in  std_logic_vector(1 downto 0);
    data_out:   out std_logic_vector(7 downto 0)
);
end entity;

architecture structural of shift_register is 
signal  in_mux:     std_logic_vector(0 to 31);
signal  out_mux:    std_logic_vector(0 to 7);
signal  temp_out:   std_logic_vector(0 to 7);

component reg is 
    port 
    (
        data_in:    in  std_logic;
        en:         in  std_logic;
        clk:        in  std_logic;
        rst:        in  std_logic;
        data_out:   out std_logic
    );
end component;

component mux_41 is
    port
    (
        i:      in std_logic_vector(0 to 3);
        y:      in std_logic_vector(1 downto 0);
        output: out std_logic
    );
end component;

begin
    data_out    <=  temp_out;

    mux0to7: for k in 0 to 7 generate 
        m: mux_41 
        port map
        (
            in_mux(4*k to (k*4 + 3)),
            y,
            out_mux(k)
        );
    end generate;

    reg0_to7: for k in 0 to 7 generate
        r: reg
        port map
        (
            out_mux(k),
            en,
            clk,
            rst,
            temp_out(k)
        );
    end generate;

    --assignmet input signals for mux
    --mux_0
    in_mux(0)   <=  data_in(0);
    in_mux(1)   <=  data_in(1);
    in_mux(2)   <=  temp_out(1);
    in_mux(3)   <=  temp_out(2);

    --mux_1
    in_mux(4)   <=  temp_out(0);
    in_mux(5)   <=  data_in(0);
    in_mux(6)   <=  temp_out(2);
    in_mux(7)   <=  temp_out(3);

    --mux_2 to mux_5

    conn_mux2to5: for k in 2 to 5 generate
        in_mux(4*k)     <=  temp_out(k-1);
        in_mux(4*k + 1) <=  temp_out(k-2);
        in_mux(4*k + 2) <=  temp_out(k+1);
        in_mux(4*k + 3) <=  temp_out(k+2);
    end generate;

    --mux_6
    in_mux(24)  <=  temp_out(5);
    in_mux(25)  <=  temp_out(4);
    in_mux(26)  <=  temp_out(7);
    in_mux(27)  <=  data_in(0);

    --mux_7
    in_mux(28)  <=  temp_out(6);
    in_mux(29)  <=  temp_out(5);
    in_mux(30)  <=  data_in(0);
    in_mux(31)  <=  data_in(1);

end structural;