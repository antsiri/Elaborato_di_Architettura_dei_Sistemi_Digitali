-- Testbench for riconoscitore (sequence 101 detection)
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity riconoscitore_tb is
end;

architecture bench of riconoscitore_tb is

  component riconoscitore
      port
      (
          RST:    in  std_logic;
          i:      in  std_logic;  -- Input signal
          A:      in  std_logic;  -- Clock signal
          M:      in  std_logic;  -- Mode or another input (adjust as needed)
          Y:      out std_logic   -- Output signal (detects "101")
      );
  end component;

  signal RST: std_logic := '0';
  signal i: std_logic := '0';
  signal A: std_logic := '0';  -- Clock
  signal M: std_logic := '0';
  signal Y: std_logic;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean := false;

begin

  uut: riconoscitore port map (
    RST => RST,
    i   => i,
    A   => A,
    M   => M,
    Y   => Y
  );

  -- Clock generation
  clocking: process
  begin
    while not stop_the_clock loop
      A <= '0';
      wait for clock_period/2;
      A <= '1';
      wait for clock_period/2;
    end loop;
    wait;
  end process;

  -- Stimulus process
  stimulus: process
  begin
    -- Initialization
    RST <= '1';
    wait for 2 * clock_period; -- Hold reset for 2 clock cycles
    RST <= '0';
    wait for clock_period;

    M <=  '1';
    wait for 2 * clock_period;    
    i <= '1';
    wait for clock_period; 
    i <= '1';
    wait for clock_period; 
    i <= '0';
    wait for clock_period; 
    i <= '1';
    wait for clock_period; 
    i <= '0';
    wait for clock_period; 
    i <= '0';
    wait for clock_period;
    i <= '1';
    wait for clock_period; 
    i <= '0';
    wait for clock_period; 
    i <= '1';
    wait for clock_period;

    RST <= '1';
    wait for 2 * clock_period;
    RST <= '0';
    wait for clock_period;

    M <=  '0';
    wait for 2 * clock_period;
    i <= '1';
    wait for clock_period; 
    i <= '1';
    wait for clock_period; 
    i <= '0';
    wait for clock_period; 
    i <= '1';
    wait for clock_period; 
    i <= '0';
    wait for clock_period; 
    i <= '1';
    wait for clock_period;
    i <= '1';
    wait for clock_period; 
    i <= '0';
    wait for clock_period; 
    i <= '1';
    wait for clock_period;


    -- End simulation
    stop_the_clock <= true;
    wait;
  end process;

end bench;
