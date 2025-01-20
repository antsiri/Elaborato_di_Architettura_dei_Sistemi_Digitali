library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for Rom_M_MEM entity

entity tb_Rom_M_MEM is
end entity;

architecture Behavioral of tb_Rom_M_MEM is

  -- Signals for the testbench
  signal CLK: std_logic := '0';
  signal RST: std_logic := '1';
  signal START: std_logic := '0';
    signal Y: std_logic_vector(3 downto 0);

begin

  -- Clock generation
  process
  begin
    wait for 5 ns;
    CLK <= not CLK;
  end process;

  -- Test stimulus
  process
  begin
    wait for 10 ns; -- Wait

    -- Reset the system
    RST <= '0';
    wait for 10 ns;
    RST <= '1';
    wait for 10 ns;
     RST <= '0';
    wait for 10 ns;
    -- Start the operation
    START <= '1';
    wait for 10 ns;
    START <= '0';
    wait for 10 ns;

    wait for 100 ns; 

    -- End of simulation
    wait;
  end process;

  uut: entity work.Rom_M_MEM
    generic map (N => 16) 
    port map (
      CLK => CLK,
      RST => RST,
      START => START,
      Y => Y
    );

end Behavioral;