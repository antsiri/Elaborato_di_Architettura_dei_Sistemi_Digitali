library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity uc_a is 
    port
    (
        start   :   in  std_logic;
        ack     :   in  std_logic;
        clk     :   in  std_logic;
        reset   :   in  std_logic;
        count   :   in  std_logic_vector(3 downto 0);
        en_read :   out std_logic;
        en_count:   out std_logic;
        req     :   out std_logic
    );
end entity;

architecture structural of uc_a is 
type state_type is (IDLE, READ, SEND, INCR_COUNTER);
signal  current_state, next_state: state_type;

begin
    change_state: process(clk, current_state)
    begin
        if (clk'event and clk='1') then
            if reset = '1' then
                current_state   <=  IDLE;
            else
                current_state   <=  next_state;
            end if;
        end if;
    end process change_state;

    automa: process(current_state, start, count, ack)
    begin
        case current_state is
            when IDLE =>
            if start = '0' then
                next_state  <=  current_state;
            else
                en_count    <=  '0';
                en_read     <=  '1';
                next_state  <=  READ;
            end if;

            when READ =>
            en_read     <=  '0';
            req         <=  '1';
            next_state  <=  SEND;

            when SEND =>
            if ack = '0' then
                next_state  <= current_state;
            else
                req         <=  '0';
                en_count    <=  '1';
            end if;
            
            when INCR_COUNTER =>
            if count = "111" then
                en_count    <=  '0';
                next_state  <=  IDLE;
            else
                en_read     <=  '1';
                en_count    <=  '0';
                next_state  <=  READ;
            end if;
        end case;
    end process automa;
end structural;