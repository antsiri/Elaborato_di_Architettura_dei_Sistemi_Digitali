library ieee;
use     ieee.std_logic_1164.all;

entity stopwatch is
    port 
    (
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        set     :   in  std_logic;
        en      :   in  std_logic;
        set_sec :   in  std_logic_vector(5 downto 0);
        set_min :   in  std_logic_vector(5 downto 0);
        set_hr  :   in  std_logic_vector(4 downto 0);
        seconds :   out std_logic_vector(5 downto 0);
        minutes :   out std_logic_vector(5 downto 0);
        hours   :   out std_logic_vector(4 downto 0)
    );
end stopwatch;

architecture structural of stopwatch is
    signal  en_count    :   std_logic_vector(1 downto 0);

    signal temp_enable  :   std_logic_vector(2 downto 0);

    component counter_mod_60 
        port
        (
            clk     :   in  std_logic;
            en      :   in  std_logic;
            rst     :   in  std_logic;
            set     :   in  std_logic;
            v_set   :   in  std_logic_vector(5 downto 0);
            counter :   out std_logic_vector(5 downto 0);
            count   :   out std_logic
        );
    end component;

    component counter_mod_24
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
    --seconds
    temp_enable(0) <=  en or rst or set;
    counter_seconds:    counter_mod_60
    port map (clk, temp_enable(0), rst, set, set_sec, seconds, en_count(0));

    --minutes
    temp_enable(1) <=  (en and en_count(0)) or rst or set;
    counter_minutes:    counter_mod_60
    port map (clk, temp_enable(1), rst, set, set_min, minutes, en_count(1));

    --hours
    temp_enable(2) <=  (en and en_count(0) and en_count(1)) or rst or set;
    counter_hours:      counter_mod_24
    port map (clk, temp_enable(2), rst, set, set_hr, hours);
end structural;