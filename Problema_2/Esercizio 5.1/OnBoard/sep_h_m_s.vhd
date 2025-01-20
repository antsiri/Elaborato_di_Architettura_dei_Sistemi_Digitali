library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sep_h_m_s is
  Port (
        CLK: in STD_LOGIC;
        sec, min: in STD_LOGIC_VECTOR(5 downto 0);
        hours: in STD_LOGIC_VECTOR(4 downto 0);
        sec_uni, min_uni, h_uni, sec_dec, min_dec, h_dec: out STD_LOGIC_VECTOR(3 downto 0)
     );
end sep_h_m_s;

architecture Behavioral of sep_h_m_s is

component separator
port(
    num_in : in std_logic_vector (5 downto 0);
    clk : in std_logic;
    unit : out std_logic_vector (3 downto 0);
    dec : out std_logic_vector (3 downto 0)
 );
end component;

signal h_temp: STD_LOGIC_VECTOR(5 downto 0);

begin

sec_separator: separator
    port map(
        num_in => sec,
        clk => CLK,
        unit => sec_uni,
        dec => sec_dec
    );
    
min_separator: separator
    port map(
        num_in => min,
        clk => CLK,
        unit => min_uni,
        dec => min_dec
    );
    
h_temp <= '0' & hours;

h_separator: separator
    port map(
        num_in => h_temp,
        clk => CLK,
        unit => h_uni,
        dec => h_dec
    );

end Behavioral;
