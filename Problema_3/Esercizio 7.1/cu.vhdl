library ieee;
use     ieee.std_logic_1164.all;

entity cu is
    port
    (
        clk         :   in  std_logic;
        rst         :   in  std_logic;

        start       :   in  std_logic;

        Q0          :   in  std_logic;
        Q_1         :   in  std_logic;
        cnt         :   in  std_logic_vector(2 downto 0);

        inizialize  :   out std_logic;

        sub_val     :   out std_logic;

        en_wr       :   out std_logic;
        en_sh       :   out std_logic;
        en_cnt      :   out std_logic
    );
end entity;

architecture behavioral of cu is
    type    type_state  is  (IDLE, STARTING, CHOOSE_OP, SHIFT, COUNT, RESULT);
    signal  current_state   :   type_state  := IDLE; 
    signal  next_state      :   type_state  := IDLE;
begin

    change_state_process: process(clk, rst)
    begin
        if (clk'event and clk='1') then
            if rst = '1' then
                current_state   <=  IDLE;
            else
                current_state   <=  next_state;
            end if;
        end if;
    end process;

    sf_machine: process(current_state)
    begin
        inizialize  <=  '0';
        en_wr       <=  '0';
        en_sh       <=  '0';    
        en_cnt      <=  '0';

        case current_state is
            when IDLE =>
            if start = '0' then
                next_state  <=  current_state;
            else
                inizialize  <=  '1';
                next_state  <=  STARTING;
            end if; 

            when STARTING   =>
            next_state  <=  CHOOSE_OP;
            
            when CHOOSE_OP =>
            if Q0 = Q_1 then
                next_state  <=  SHIFT;
            else 
                if Q0 = '1' and Q_1 = '0' then
                    sub_val     <=  '1';
                elsif Q0 = '0' and Q_1 = '1' then 
                    sub_val     <=  '0';
                end if;
                next_state  <=  SHIFT;
                en_wr   <=  '1';
            end if;

            when SHIFT =>
            en_sh       <=  '1';
            if cnt = "111" then
                next_state  <=  RESULT;
            else
                next_state  <=  COUNT;
            end if;

            when COUNT =>
            en_cnt  <=  '1';
            next_state  <=  CHOOSE_OP;

            when RESULT =>
                
        end case;
    end process;
end behavioral;