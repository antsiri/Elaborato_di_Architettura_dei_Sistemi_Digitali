library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit_A is
    port
    (
        clk     :   in  std_logic;
        start   :   in  std_logic;
        rst     :   in  std_logic;

        TBE     :   in  std_logic;
        count   :   in  std_logic_vector(2 downto 0);

        WR      :   out std_logic;
        uart_rst:   out std_logic;
        en_rd   :   out std_logic;
        en_cnt  :   out std_logic

    );
end ControlUnit_A;

architecture behavioral of ControlUnit_A is
    type state_type is (IDLE, RETREIVE, START_COMMUNICATION, END_COMMUNICATION, INCR_COUNT);
    signal  current_state   :   state_type  :=  IDLE;
    signal  next_state      :   state_type  :=  IDLE;

begin
    clk_proc: process(clk)
    begin
        if clk'event and clk='1' then
            if rst = '1' then
                current_state   <=  IDLE;
            else
                current_state   <=  next_state;
            end if;
        end if;
    end process;

    fs_machine: process(current_state, start)
    begin
        uart_rst    <=  '0';
        en_cnt      <=  '0';
        en_rd       <=  '0';

        case current_state is
            when IDLE =>
            if start = '0' then
                next_state  <=  current_state;
            elsif start = '1' then
                next_state  <=  RETREIVE;
            end if;

            when RETREIVE =>
            en_rd       <=  '1';
            next_state  <=  START_COMMUNICATION;  

            when START_COMMUNICATION =>
            WR          <=  '1';
            if TBE = '1' then
                next_state  <=  current_state;
            else  
                next_state  <= END_COMMUNICATION;
            end if;

            when END_COMMUNICATION =>
            WR          <=  '0';
            if TBE = '1' then
                next_state  <=  INCR_COUNT;
                if count = "111" then
                    next_state  <=  IDLE;
                end if;
            end if;

            when INCR_COUNT =>
            en_cnt  <=  '1';
            uart_rst<=  '1';
            next_state  <=  RETREIVE;
        end case;
    end process;
end behavioral;