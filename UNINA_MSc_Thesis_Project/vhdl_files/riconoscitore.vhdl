library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity riconoscitore is
    port
    (
        RST:    in  std_logic;
        i:      in  std_logic;
        A:      in  std_logic;
        M:      in  std_logic;
        Y:      out std_logic
    );
end riconoscitore;

architecture Behavioral of riconoscitore is
    type state_type is (S0, S1, S2, S3, S4, S5 , S6, S7, S8);
    signal current_state, next_state: state_type;
    signal temp_y: std_logic;

    begin 
    process(A, RST)
    begin
        if rising_edge(A) then              -- (A'event and A='1')
            if RST = '1' then
                current_state   <=  S0;
                Y               <=  '0';
            else
                current_state   <=  next_state;
                Y               <=  temp_y;
            end if;
        end if;
    end process;

    process(current_state, i, M)
    begin
        next_state              <=  current_state;
        --Y                       <=  '0';

        case current_state is 
        when S0 => 
            if M = '1' then
                next_state      <=  S1;
                temp_y          <=  '0';
            elsif M = '0' then
                next_state      <=  S4;
                temp_y          <=  '0';
            end if;
        when S1 => 
            if i = '0' then
                next_state      <=  current_state;
                temp_y          <=  '0';
            elsif i = '1' then
                next_state      <=  S2;
                temp_y          <=  '0';
            end if;
        when S2 =>
            if i = '1' then
                next_state      <=  current_state;
                temp_y          <=  '0';
            elsif i = '0' then
                next_state      <=  S3;
                temp_y          <=  '0';
            end if;
        when S3 => 
            next_state          <=  S1;
            if i = '0' then
                temp_y          <=  '0';
            elsif i = '1' then 
                temp_y          <=  '1';
            end if;

        when S4 =>
            if i = '0' then
                next_state      <=  S7;
                temp_y          <=  '0';
            elsif i = '1' then
                next_state      <=  S5;
                temp_y          <=  '0';
            end if;

        when S5 =>
            if i = '1' then
                next_state      <=  S8;
                temp_y          <=  '0';
            elsif i = '0' then
                next_state      <=  S6;
                temp_y          <=  '0';
            end if;
        when S6 =>
            next_state          <=  S4;
            if i = '1' then
                temp_y          <=  '1';
            end if;
        when S7 =>
            next_state          <=  S8;
            temp_y              <=  '0';
        when S8 =>
            next_state          <=  S4;
            temp_y              <=  '0';
        end case;
    end process;    
end Behavioral;