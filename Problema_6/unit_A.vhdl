library ieee;
use ieee.std_logic_1164.all;

entity unit_A is
    port
    (
        clk     :   in      std_logic;
        rst     :   in      std_logic;

        start   :   in      std_logic;

        TXD     :   out      std_logic
    );
end unit_A;

architecture structural of unit_A is
    component ControlUnit_A is
        port
        (
            clk     :   in  std_logic;
            start   :   in  std_logic;
            rst     :   in  std_logic;
            TBE     :   in  std_logic;
            count   :   in  std_logic_vector(2 downto 0);
            WR      :   out std_logic;
            uart_rst:   out std_logic;
            en_rd   :   out std_logic;
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

    component ROM is
        port
        (
            clk     :   in  std_logic;
            en_rd   :   in  std_logic;
            address :   in  std_logic_vector(2 downto 0);
            d_out   :   out std_logic_vector(7 downto 0)
        );
    end component;

    signal  address_temp    :   std_logic_vector(2 downto 0);
    signal  wr_temp         :   std_logic;
    signal  rst_uart_temp   :   std_logic;
    signal  en_rd_temp      :   std_logic;
    signal  en_cnt_temp     :   std_logic;
    signal  data_temp       :   std_logic_vector(7 downto 0);
    signal  TBE_temp        :   std_logic;

    signal  rst_temp        :   std_logic;

begin
    Count_A: counter_mod_8 
    port map (clk, rst, en_cnt_temp, address_temp);

    memory_A: ROM
    port map (clk, en_rd_temp, address_temp, data_temp);

    rst_temp    <=  rst or rst_uart_temp;

    uart_A: Rs232RefComp
    port map
    (
        TXD     =>  TXD,
        CLK     =>  clk,
        RXD     =>  '1',
        DBIN    =>  data_temp,
        RD      =>  '1',
        WR      =>  wr_temp,
        TBE     =>  TBE_temp,
        RST     =>  rst_temp
    );

    cu_A: ControlUnit_A
    port map(clk, start, rst, TBE_temp, address_temp, wr_temp, rst_uart_temp, en_rd_temp, en_cnt_temp);
end structural;