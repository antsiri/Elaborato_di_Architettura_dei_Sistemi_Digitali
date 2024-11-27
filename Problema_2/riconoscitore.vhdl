library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity riconoscitore is
    port
    (
        i: in std_logic;
        A: in std_logic;
        M: in std_logic;
        Y: out std_logic
    );
end riconoscitore;

architecture Behavioral of riconoscitore is
    type state_type is (S0, S1, S2, S3);
    signal current_state, next_state: state_type;

    begin 
    process(A)
    begin
        if rising_edge(A) then              --A'event (quando si simula su FPGA)
            current_state <= next_state;
        end if;
    end process;

    process(current_state, i, M)
    begin
        Y <= '0';
        next_state <= current_state;

        case current_state is 
        when S0 => 
            if i = '1' then
                next_state <= S1;
            end if;
        when S1 => 
            if i = '0' then
                next_state <= S2;
            elsif M='0' then
                next_state <= S1;
            end if;
        when S2 =>
            if i = '1' then
                next_state <= S3;
                Y <= '1';
            else
                next_state <= S0;       -- torno in SO indipendentemente da M
            end if;
        when S3 =>
            Y <= '1'; 
            if M = '0' then
                next_state <= S1;
            else 
                next_state <= S0;
            end if;
        end case;
    end process;    
end Behavioral;