-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity System_tb is
end;

architecture bench of System_tb is

  component System 
  port
  (
      clk     :   in  std_logic;
      rst     :   in  std_logic;
      start   :   in  std_logic
  );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal start: std_logic ;

begin

  uut: System port map ( clk   => clk,
                         rst   => rst,
                         start => start );

  clock_process: process
  begin
    clk <= '0';
    while True loop
      wait for 20 ns; -- Periodo del clock (adattare a seconda delle esigenze)→
      clk <= not clk;
    end loop;
  end process;

  stimulus: process
  begin
    start   <=  '1';

    wait;

  end process;

  process
    begin
    wait until rising_edge(clk);
    report "Clock is high at time: " & time'image(now);
  end process;

   


end;