library ieee;
use     ieee.std_logic_1164.all;

entity counter_mod_24 is
    port
    (
        clk     :   in  std_logic;
        en      :   in  std_logic;
        rst     :   in  std_logic;
        set     :   in  std_logic;
        v_set   :   in  std_logic_vector(4 downto 0);
        counter :   out std_logic_vector(4 downto 0);
        count   :   out std_logic
    );
end counter_mod_24;

architecture structural of counter_mod_24 is
    signal  temp_counter    :   std_logic_vector(4 downto 0);
    signal  last_number_rs  :   std_logic;

    signal reset            :   std_logic;

    component counter_mod_32 is
        port
        (
            clk     :   in  std_logic;
            en      :   in  std_logic;
            rst     :   in  std_logic;
            set     :   in  std_logic;
            v_set   :   in  std_logic_vector(4 downto 0);
            counter :   out std_logic_vector(4 downto 0);
            count   :   out std_logic
        );
    end component;

begin
    last_number_rs  <=  temp_counter(4) and (not temp_counter(3)) and temp_counter(2) and temp_counter(1) and temp_counter(0);

    reset           <=  (last_number_rs and en) or rst;

    counter_32: counter_mod_32  
    port map (clk, en, reset, set, v_set, temp_counter);

    counter         <=  temp_counter;
    count           <=  reset;
end structural;