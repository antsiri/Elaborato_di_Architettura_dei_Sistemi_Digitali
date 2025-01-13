library ieee;
use ieee.std_logic_1164.all;

entity unit_B is
    port
    (
        clk     :   in      std_logic;
        rst     :   in      std_logic;

        RXD     :   in      std_logic
    );
end unit_B;

architecture structural of unit_B is
    component ControlUnit_B is
        port
        (
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            RDA     :   in  std_logic;
            RD      :   out std_logic;
            uart_rst:   out std_logic;
            en_wr   :   out std_logic;
            en_cnt  :   out std_logic
    
        );
    end component;

    component counter_mod_8 is
        port
        (
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            en_cnt  :   in  std_logic;
            cnt     :   out std_logic_vector(2 downto 0)    
        );
    end component;

    component Rs232RefComp is
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;					--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
            RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
            WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0'              --Master Reset
            );			
    end component;

    component Mem is
        port 
        (
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            en_wr   :   in  std_logic;

            addr    :   in  std_logic_vector(2 downto 0);
            data_in :   in  std_logic_vector(7 downto 0)

        );
    end component;

    signal  address_temp    :   std_logic_vector(2 downto 0);
    signal  rd_temp         :   std_logic;
    signal  rst_uart_temp   :   std_logic;
    signal  en_wr_temp      :   std_logic;
    signal  en_cnt_temp     :   std_logic;
    signal  RDA_temp        :   std_logic;
    signal  data            :   std_logic_vector(7 downto 0);
    signal  rst_temp        :   std_logic;

begin
    Count_B: counter_mod_8 
    port map (clk, rst, en_cnt_temp, address_temp);

    memory_B: mem
    port map (clk, rst, en_wr_temp, address_temp, data);

    rst_temp    <=  rst or rst_uart_temp;

    uart_B: Rs232RefComp
    port map
    (
        RXD     =>  RXD,
        CLK     =>  clk,
        RDA     =>  RDA_temp,
        RD      =>  '0',
        WR      =>  '0',
        DBIN    =>  (others => '0'),
        DBOUT   =>  data,
        RST     =>  rst_temp
    );

    cu_B: ControlUnit_B
    port map(clk, rst, RDA_temp, rd_temp, rst_uart_temp, en_wr_temp, en_cnt_temp);
end structural;