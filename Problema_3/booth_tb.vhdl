-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity booth_tb is
end;

architecture bench of booth_tb is

  component booth
      port
      (
          clk     :   in  std_logic;
          rst     :   in  std_logic;
          start   :   in  std_logic;
          X       :   in  std_logic_vector(7 downto 0);
          Y       :   in  std_logic_vector(7 downto 0);
          res     :   out std_logic_vector(15 downto 0)
      );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal start: std_logic;
  signal X: std_logic_vector(7 downto 0);
  signal Y: std_logic_vector(7 downto 0);
  signal prod: std_logic_vector(15 downto 0) ;

  constant clk_period : time := 10 ns;

begin

  uut: booth port map ( clk   => clk,
                        rst   => rst,
                        start => start,
                        X     => X,
                        Y     => Y,
                        res  => prod);

    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    stimulus: process
    begin

        X   <=  "11110011";
        Y   <=  "11110000";
        wait for 10 ns;
        start   <=  '1';

        wait;
    end process;


end;