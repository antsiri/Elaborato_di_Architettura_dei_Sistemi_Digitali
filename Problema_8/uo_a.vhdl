library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity uo_a is 
    port
    (
        clk         :   in  std_logic;
        en_count    :   in  std_logic;
        en_read     :   in  std_logic;
        rst         :   in  std_logic;
        count       :   out std_logic_vector(2 downto 0);
        data        :   out std_logic_vector(3 downto 0) 
    ); 
end entity;

architecture structural of uo_a is
    signal  temp_count: std_logic_vector(2 downto 0);
    component ROM
        port
        (
            clk     :   in  std_logic;
            en      :   in  std_logic;
            address :   in  std_logic_vector(2 downto 0);
            dout    :   out std_logic_vector(3 downto 0)
        );
    end component;

    component counter_mod_8 is
        port( 
            clk     :   in  std_logic;
            en      :   in  std_logic;
            rst     :   in  std_logic;
            count   :   out std_logic_vector(2 downto 0)  
        );  
    end component;
begin
    ROM(clk, en_read, temp_count, data);
    counter_mod_8(clk, en_count, rst, temp_count);
    count   <=  temp_count;
end structural;
