library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_counter_mod_8 is
end tb_counter_mod_8;

architecture testbench of tb_counter_mod_8 is

    -- Component declaration
    component counter_mod_8 is
        port( 
            clk     : in std_logic;
            en      : in std_logic;
            rst     : in std_logic;
            count   : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Signals to connect to the DUT
    signal clk     : std_logic := '0';
    signal en      : std_logic := '0';
    signal rst     : std_logic := '0';
    signal count   : std_logic_vector(2 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the DUT
    uut: counter_mod_8
        port map (
            clk => clk,
            en => en,
            rst => rst,
            count => count
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Test process
    test_process : process
    begin
        -- Reset the counter
        rst <= '1';
        en <= '0';
        wait for clk_period;
        rst <= '0';

        -- Enable and observe counting
        en <= '1';
        wait for 8 * clk_period;

        -- Disable counting and check stability
        en <= '0';
        wait for 4 * clk_period;

        -- Re-enable counting
        en <= '1';
        wait for 8 * clk_period;

        -- Stop the simulation
        wait;
    end process;

end testbench;
