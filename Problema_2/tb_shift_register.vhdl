library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity shift_register_tb is
end;

architecture bench of shift_register_tb is

  component shift_register 
  port
  (
      clk:        in  std_logic;
      rst:        in  std_logic;
      en:         in  std_logic;
      y:          in  std_logic_vector(1 downto 0);
      data_in:    in  std_logic_vector(1 downto 0);
      data_out:   out std_logic_vector(7 downto 0)
  );
  end component;

  signal clk: std_logic := '0';
  signal rst: std_logic := '0';
  signal en: std_logic := '0';
  signal y: std_logic_vector(1 downto 0) := "00";
  signal data_in: std_logic_vector(1 downto 0) := "00";
  signal data_out: std_logic_vector(7 downto 0);

begin

  uut: shift_register port map ( clk      => clk,
                                 rst      => rst,
                                 en       => en,
                                 y        => y,
                                 data_in  => data_in,
                                 data_out => data_out );

  clk_process: process
  begin
    -- Clock generation
    clk <= not clk after 10 ns;
    wait for 10 ns;
  end process;

  stimulus: process
  begin
    -- Test Case 1: Apply reset
    rst <= '1';          -- Assert reset
    wait for 20 ns;      -- Wait for reset to propagate
    rst <= '0';          -- Deassert reset
    wait for 20 ns;

    -- Test Case 2: Enable shift register with y = "00"
    en <= '1';           -- Enable shift register
    y <= "00";           -- Set y to "00"
    data_in <= "01";     -- Apply data "01"
    wait for 40 ns;

    -- Test Case 3: Apply data_in while changing y to "01"
    y <= "01";           -- Change y to "01"
    data_in <= "10";     -- Apply data "10"
    wait for 40 ns;

    -- Test Case 4: Apply data_in while changing y to "10"
    y <= "10";           -- Change y to "10"
    data_in <= "11";     -- Apply data "11"
    wait for 40 ns;

    -- Test Case 5: Disable shift register with y = "11"
    en <= '0';           -- Disable shift register
    y <= "11";           -- Set y to "11"
    data_in <= "00";     -- Change data input
    wait for 40 ns;

    -- Test Case 6: Apply data_in with y = "00" and reset active
    rst <= '1';          -- Assert reset
    y <= "00";           -- Set y to "00"
    data_in <= "10";     -- Apply data "10" while reset is active
    wait for 20 ns;
    rst <= '0';          -- Deassert reset
    wait for 40 ns;

    -- Test Case 7: Apply data_in while y = "01" and enable shifting
    y <= "01";           -- Set y to "01"
    en <= '1';           -- Enable shift register
    data_in <= "11";     -- Apply data "11"
    wait for 40 ns;
    data_in <= "00";     -- Change data to "00"
    wait for 40 ns;

    -- Test Case 8: Apply reset while shifting and changing y
    rst <= '1';          -- Assert reset
    y <= "10";           -- Change y to "10"
    data_in <= "11";     -- Apply data "11"
    wait for 20 ns;
    rst <= '0';          -- Deassert reset
    wait for 40 ns;

    -- Test Case 9: Apply y = "11" and shift continuously with data_in changes
    y <= "11";           -- Set y to "11"
    en <= '1';           -- Enable shift register
    data_in <= "00";     -- Apply data "00"
    wait for 40 ns;
    data_in <= "01";     -- Apply data "01"
    wait for 40 ns;
    data_in <= "10";     -- Apply data "10"
    wait for 40 ns;
    data_in <= "11";     -- Apply data "11"
    wait for 40 ns;

    -- Test Case 10: Reset during shifting with y = "00"
    rst <= '1';          -- Assert reset during shift
    y <= "00";           -- Set y to "00"
    data_in <= "01";     -- Apply data "01"
    wait for 20 ns;
    rst <= '0';          -- Deassert reset
    wait for 40 ns;

    -- Test Case 11: Changing y while shifting with enabled register
    y <= "01";           -- Set y to "01"
    en <= '1';           -- Enable shift register
    data_in <= "01";     -- Apply data "01"
    wait for 40 ns;
    y <= "10";           -- Change y to "10"
    data_in <= "11";     -- Change data to "11"
    wait for 40 ns;

    -- Test Case 12: Apply y = "11" and shift with reset active
    rst <= '1';          -- Assert reset
    y <= "11";           -- Set y to "11"
    data_in <= "10";     -- Apply data "10"
    wait for 20 ns;
    rst <= '0';          -- Deassert reset
    wait for 40 ns;

    -- Test Case 13: Disable shifting during changes in y
    en <= '0';           -- Disable shift register
    y <= "00";           -- Set y to "00"
    data_in <= "11";     -- Change data to "11"
    wait for 40 ns;
    y <= "01";           -- Change y to "01"
    data_in <= "00";     -- Change data to "00"
    wait for 40 ns;

    -- End
  end process;

end;
