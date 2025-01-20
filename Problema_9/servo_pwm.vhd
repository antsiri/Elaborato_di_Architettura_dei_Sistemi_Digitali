library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity servo_1st is
    PORT (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        close: in STD_LOGIC;
        open_f: in STD_LOGIC;
        servo0 : out STD_LOGIC;
        servo1 : out STD_LOGIC;
        servo2 : out STD_LOGIC
    );
end servo_1st;

architecture Behavioral of servo_1st is
    signal pos: STD_LOGIC_VECTOR(6 downto 0):= (others => '0');
    -- Counter, from 0 to 1279.
    signal cnt : unsigned(10 downto 0);
    -- Temporal signal used to generate the PWM pulse.
    signal pwmi: unsigned(7 downto 0);
begin
    -- Minimum value should be 0.5ms.
    pwmi <= unsigned('0' & pos) + 32;
    -- Counter process, from 0 to 1279.
    counter: process (reset, clk) begin
        if (reset = '1') then
            cnt <= (others => '0');
            
        elsif rising_edge(clk) then
            if close = '1' then
                pos <= "1111100";
            elsif open_f = '1' then
                pos <= (others => '0');
                end if;
            if (cnt = 1279) then
                cnt <= (others => '0');
            else
                cnt <= cnt + 1;
            end if;
           
        end if;
    end process;
    
    servo0 <= '1' when (cnt < pwmi) else '0';
    servo1 <= '1' when (cnt < pwmi) else '0';
    servo2 <= '1' when (cnt < pwmi) else '0';
end Behavioral;