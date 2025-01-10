library ieee;
use     ieee.std_logic_1164.all;

entity  counter_mod_8 is
    port 
    (
        clk     :   in  std_logic;
        en      :   in  std_logic;
        rst     :   in  std_logic;
        counter :   out std_logic_vector(2 downto 0)
    );
end entity;

architecture structural of counter_mod_8 is
    signal  temp_counter    :   std_logic_vector(2 downto 0)    :=  (others => '0');
    signal  back            :   std_logic;
    
    signal resets           :   std_logic_vector(4 downto 0);
    signal counters         :   std_logic_vector(2 downto 0);


    component ffD is 
    port 
    (
        clk         :   in  std_logic;
        en          :   in  std_logic;
        rst         :   in  std_logic;
        preset      :   in  std_logic;
        input       :   in  std_logic;
        output      :   out std_logic;
        not_output  :   out std_logic
    );
end component;
    
begin

    resets(0)   <=  rst;

    counter_0 : ffD 
        port map (
            clk, 
            en, 
            resets(0),
            '0',
            back,
            temp_counter(0),
            back
        );

    resets(1)   <=  rst;
    counters(1) <=  temp_counter(0) xor temp_counter(1);

    counter_1 : ffD 
        port map (
            clk, 
            en, 
            resets(1),
            '0',
            counters(1),
            temp_counter(1)
        );

    resets(2)   <=  rst;
    counters(2) <=  (temp_counter(0) and temp_counter(1)) xor temp_counter(2);

    counter_2 : ffD 
    port map (
        clk, 
        en, 
        resets(2),
        '0',
        counters(2),
        temp_counter(2)
    );

    counter <=  temp_counter;
end structural;