library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hand_control is
    PORT(
        clk  : IN  STD_LOGIC;
        reset: IN  STD_LOGIC;
        dito: in STD_LOGIC_VECTOR(4 downto 0); --sceglie quale dito abilitare
        close: IN STD_LOGIC;
        open_f: in STD_LOGIC;
        servo0: OUT STD_LOGIC;
        servo1: out STD_LOGIC;
        servo2: OUT STD_LOGIC;
        servo3: out STD_LOGIC;
        servo4: out STD_LOGIC
    );
end hand_control;

architecture Behavioral of hand_control is
    COMPONENT freq_div
        PORT(
            clk    : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            clk_out: out STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT servo_1st
        PORT (
      clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        close: in STD_LOGIC;
        open_f: in STD_LOGIC;
        servo0 : out STD_LOGIC;
        servo1 : out STD_LOGIC;
        servo2 : out STD_LOGIC
    );
    END COMPONENT;
    
    COMPONENT servo_2nd
       PORT (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        close: in STD_LOGIC;
        open_f: in STD_LOGIC;
        servo3 : out STD_LOGIC;
        servo4: out STD_LOGIC
    );
end COMPONENT;
    
    signal clk_out : STD_LOGIC := '0';
    signal servo0_temp, servo1_temp, servo2_temp, servo3_temp, servo4_temp: STD_LOGIC;
    
begin
    fd_map: freq_div PORT MAP(
        clk, reset, clk_out
    );
    
    servo_pwm_map: servo_1st PORT MAP(
        clk_out, reset, close, open_f, servo0_temp, servo1_temp, servo2_temp
    );
    
    servo_pwm_2_map: servo_2nd 
        Port map(clk_out, reset, close, open_f, servo3_temp, servo4_temp
        );
        
    servo: process(dito)
    begin
        if dito(0) = '1' then
            servo0 <= servo0_temp;
        end if;
        if dito(1) = '1' then
            servo1 <= servo1_temp;
        end if;
        if dito(2) = '1' then
            servo2 <= servo2_temp;
        end if;
        if dito(3) = '1' then
            servo3 <= servo3_temp;
        end if;
        if dito(4) = '1' then
            servo4 <= servo4_temp;
        end if;
    end process;
end Behavioral;