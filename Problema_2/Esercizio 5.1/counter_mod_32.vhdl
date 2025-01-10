library ieee;
use     ieee.std_logic_1164.all;

entity  counter_mod_32 is
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
end entity;

architecture structural of counter_mod_32 is
    signal  temp_counter    :   std_logic_vector(4 downto 0)    :=  (others => '0');
    signal  back            :   std_logic;
    
    signal resets           :   std_logic_vector(4 downto 0);
    signal sets             :   std_logic_vector(4 downto 0);
    signal counters         :   std_logic_vector(4 downto 0);


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
    sets(0)     <=  set and v_set(0);

    counter_0 : ffD 
        port map (
            clk, 
            en, 
            resets(0),
            sets(0),
            back,
            temp_counter(0),
            back
        );

    resets(1)   <=  rst;
    sets(1)     <=  set and v_set(1);
    counters(1) <=  temp_counter(0) xor temp_counter(1);

    counter_1 : ffD 
        port map (
            clk, 
            en, 
            resets(1),
            sets(1),
            counters(1),
            temp_counter(1)
        );

    resets(2)   <=  rst;
    sets(2)     <=  set and v_set(2);
    counters(2) <=  (temp_counter(0) and temp_counter(1)) xor temp_counter(2);

    counter_2 : ffD 
    port map (
        clk, 
        en, 
        resets(2),
        sets(2),
        counters(2),
        temp_counter(2)
    );

    resets(3)   <=  rst;
    sets(3)     <=  set and v_set(3);
    counters(3) <=  (temp_counter(0) and temp_counter(1) and temp_counter(2)) xor temp_counter(3);

    counter_3 : ffD 
    port map (
        clk, 
        en, 
        resets(3),
        sets(3),
        counters(3),
        temp_counter(3)
    );

    resets(4)   <=  (set and not v_set(4)) or rst;
    sets(4)     <=  set and v_set(4);
    counters(4) <=  (temp_counter(0) and temp_counter(1) and temp_counter(2) and temp_counter(3)) xor temp_counter(4);

    counter_4 : ffD 
    port map (
        clk, 
        en, 
        resets(4),
        sets(4),
        counters(4),
        temp_counter(4)
    );

    counter <=  temp_counter;
    count   <=  temp_counter(4);
end structural;