library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit_B is
    port
    (
        clk     :   in  std_logic;
        rst     :   in  std_logic;

        RDA     :   in  std_logic;

        RD      :   out std_logic;
        uart_rst:   out std_logic;
        en_wr   :   out std_logic;
        en_cnt  :   out std_logic

    );
end ControlUnit_B;

architecture behavioral of ControlUnit_B is
    type state_type is (IDLE, RECEIVING, OK_RECEIVE, INCR_COUNT);
    signal  current_state   :   state_type  :=  IDLE;
    signal  next_state      :   state_type  :=  IDLE;
begin
    clk_proc: process(clk, rst)
    begin
        if clk'event and clk='1' then
            if rst = '1' then
                current_state   <=  IDLE;
            else
                current_state   <=  next_state;
            end if;
        end if;
    end process;

    fs_machine: process(current_state, RDA)
    begin
        RD      <=  '0';
        en_wr   <=  '0';
        en_cnt  <=  '0';
        uart_rst<=  '0';

        case current_state is
            when IDLE =>
            if RDA = '0' then
                next_state  <=  current_state;
            elsif RDA = '1' then
                next_state  <= RECEIVING;
            end if;

            when RECEIVING =>
            en_wr       <=  '1';
            next_state  <=  OK_RECEIVE;

            when OK_RECEIVE =>
            uart_rst    <=  '1';
            if RDA = '1' then
                next_state  <=  current_state;
            elsif RDA = '0' then
                next_state  <=  INCR_COUNT;
            end if;

            when INCR_COUNT =>
            en_cnt  <=  '1';
            next_state  <=  IDLE;
        end case;
    end process;
end behavioral;