library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cron_onBOARD is
  Port ( 
        CLK, RST, SET: in STD_LOGIC;
        load_s, load_m, load_h: in STD_LOGIC;
        value_in: in STD_LOGIC_VECTOR(5 downto 0);
        anodes_out : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre, sono un output del topmodule
		cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0)
  );
end cron_onBOARD;

architecture Behavioral of cron_onBOARD is
component control_unit
      Port ( 
        CLK, RST, SET: in STD_LOGIC; 
        load_s, load_m, load_h: in STD_LOGIC;
        value_in: in STD_LOGIC_VECTOR(5 downto 0);
        sec_out, min_out: out STD_LOGIC_VECTOR(5 downto 0);
        h_out: out STD_LOGIC_VECTOR(4 downto 0)
  );
end component;

component stopwatch
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
end component;

component frequency_divider is
    Port (
        clock_in : in STD_LOGIC;  -- Clock di ingresso
        reset : in STD_LOGIC;     -- Segnale di reset
        clock_out : out STD_LOGIC -- Clock di uscita, divisore di frequenza
    );
end component;

component display_seven_segments is
Generic( 
        CLKIN_freq : integer := 100000000; 
        CLKOUT_freq : integer := 500
		);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component sep_h_m_s 
  Port (
        CLK: in STD_LOGIC;
        sec, min: in STD_LOGIC_VECTOR(5 downto 0);
        hours: in STD_LOGIC_VECTOR(4 downto 0);
        sec_uni, min_uni, h_uni, sec_dec, min_dec, h_dec: out STD_LOGIC_VECTOR(3 downto 0)
     );
end component;


signal s_cu, m_cu: STD_LOGIC_VECTOR(5 downto 0);
signal h_cu: STD_LOGIC_VECTOR(4 downto 0);
signal sec_temp, min_temp: STD_LOGIC_VECTOR(5 downto 0);
signal h_temp: STD_LOGIC_VECTOR(4 downto 0);
signal fd_out: STD_LOGIC;
signal  temp_sec_uni, temp_min_uni, temp_h_uni, temp_sec_dec, temp_min_dec, temp_h_dec: STD_LOGIC_VECTOR(3 downto 0);
begin
cu: control_unit
    port map(
        CLK => CLK,
        RST => RST,
        SET => SET,
        load_s => load_s,
        load_m => load_m,
        load_h => load_h,
        value_in => value_in,
        sec_out => s_cu,
        min_out => m_cu,
        h_out => h_cu
    );
    
cron: stopwatch
    port map(
         clk  => fd_out,
         rst => RST,
         set => SET,
         en => '1',
         set_sec => s_cu,
         set_min => m_cu,
         set_hr => h_cu,
         seconds => sec_temp,
         minutes => min_temp,
         hours  => h_temp
    );

fd: frequency_divider
    port map(
        clock_in => CLK,
        reset => '0', 
        clock_out => fd_out
    );
    
sep: sep_h_m_s
    port map(
        CLK => CLK,
        sec => sec_temp,
        min => min_temp,
        hours => h_temp,
        sec_uni => temp_sec_uni,
        min_uni => temp_min_uni, 
        h_uni => temp_h_uni, 
        sec_dec => temp_sec_dec, 
        min_dec => temp_min_dec, 
        h_dec => temp_h_dec 
    );
    
dss: display_seven_segments
    port map(
        CLK =>  CLK,
        RST => RST,
        VALUE(3 downto 0) => temp_sec_uni,
        VALUE(7 downto 4) => temp_sec_dec,
        VALUE(11 downto 8) => temp_min_uni,
        VALUE(15 downto 12) => temp_min_dec,
        VALUE(19 downto 16) => temp_h_uni,
        VALUE(23 downto 20) => temp_h_dec,
        VALUE(31 downto 24) => (others => '0'),
        ENABLE => "11111111",
        DOTS => "01010100",
        anodes => anodes_out,
		cathodes => cathodes_out
        );
        
end Behavioral;