library ieee;
use ieee.std_logic_1164.all;

entity System is 
port
(
    clk     :   in  std_logic;
    rst     :   in  std_logic;

    start   :   in  std_logic

);
end System;

architecture structural of System is
    component unit_A is
        port
        (
            clk     :   in      std_logic;
            rst     :   in      std_logic;
            start   :   in      std_logic;
            TXD     :   out     std_logic
        );
    end component;

    component unit_B is
        port
        (
            clk     :   in      std_logic;
            rst     :   in      std_logic;
            RXD     :   in      std_logic
        );
    end component;

    signal  channel  :   std_logic;

begin
    A: unit_A
    port map(clk, rst, start, channel);

    B: unit_B
    port map(clk, rst, channel);
end structural;