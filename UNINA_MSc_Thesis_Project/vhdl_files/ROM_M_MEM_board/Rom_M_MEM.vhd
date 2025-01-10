library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rom_M_MEM is
generic(N: integer range 0 to 32:=16);
  Port (  
        START, RST, READ: in std_logic;
        CLK: in std_logic;
        --count: out std_logic_vector(3 downto 0);
        --stato: out STD_LOGIC_VECTOR(1 downto 0);  
        Y: out std_logic_vector(3 downto 0);
        led_out: out std_logic
  );
end Rom_M_MEM;

architecture structural of Rom_M_MEM is
--segnali intermedi:
signal Yc: std_logic_vector(3 downto 0):= "0000";
signal yROM : std_logic_vector(7 downto 0):= "00000000"; --uscita della ROM di 8 bit
signal yM: std_logic_vector(3 downto 0):="0000"; --uscita dalla macchina di trasform di 4 bit
signal ENABLE, WRITE: std_logic;
signal temp_clock: std_logic;

component ROM is
        port(
        CLK: in STD_LOGIC; --La read e' sincrona
        address: in STD_LOGIC_VECTOR(3 downto 0); --l'indirizzo in ingresso me lo da il contatore
        EN_RD: in STD_LOGIC;
        dout: out STD_LOGIC_VECTOR(7 downto 0)
         );
end component;

component M is
        port(
         ingresso: in std_logic_vector(7 downto 0);
         uscita: out std_logic_vector(3 downto 0)
        );
 end component;
 
 component MEM
        port(
        CLK: in std_logic;
        EN_WR: in std_logic; --abilitazione alla scrittura nella locazione di memoria indicata da loc
        ADD: in std_logic_vector(3 downto 0); --l'indirizzo corrisponder? all'uscita del contatore cont(mod16)
        DATA_IN: in std_logic_vector(3 downto 0) --una riga di 4 bit
        );
  end component;

component cont_mod16 is
      Port (
            CLK: in std_logic;
            RST: in std_logic;
            EN_COUNT: in std_logic;
            count: out std_logic_vector(3 downto 0)
         );
            end component;

component control_unit
 Port (
        START, RST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        EN_RD: in STD_LOGIC;
        count: in STD_LOGIC_VECTOR(3 downto 0);
--        stato: out STD_LOGIC_VECTOR(1 downto 0);
        EN_WR, EN_COUNT: out STD_LOGIC
  );
end component;

component frequency_divider is
    Port (
        clock_in : in STD_LOGIC;  -- Clock di ingresso
        reset : in STD_LOGIC;     -- Segnale di reset
        clock_out : out STD_LOGIC -- Clock di uscita, divisore di frequenza
    );
end component;

begin

--collegamenti tra le componenti
ROM0: ROM
        Port map(
            CLK => temp_clock,
            address => Yc,        
            EN_RD => READ,
            dout => yROM
        );
M0: M  
    Port map(
            ingresso => yROM,
            uscita => yM
    );
    
 MEM0: MEM
    Port map(
        CLK => temp_clock,
        EN_WR => WRITE,
        ADD => Yc,
        DATA_IN => yM
    );
    
 cont: cont_mod16
    port map(
    CLK => temp_clock,
    RST => RST,
    EN_COUNT => ENABLE,
    count => Yc 
    );

cu: control_unit
    port map(
        START => START,
        RST => RST,
        CLK => temp_clock,
        count => Yc,
--        stato => stato,
        EN_RD => READ,
        EN_WR => WRITE,
        EN_COUNT => ENABLE
    );

fd: frequency_divider
    Port map(
         clock_in => CLK,  -- Clock di ingresso
        reset => RST,    -- Segnale di reset
        clock_out => temp_clock
        );
Y <= yM;
--Y <= Yc;
led_out <= temp_clock;

end structural;
