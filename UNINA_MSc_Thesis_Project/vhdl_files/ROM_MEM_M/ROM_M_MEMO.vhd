library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rom_M_MEM is
generic(N: integer range 0 to 32:=16);
  Port (  
        START, RST: in std_logic;
        CLK: in std_logic;
        stato: out STD_LOGIC_VECTOR(1 downto 0); 
        count: out STD_LOGIC_VECTOR(3 downto 0);
        Y: out std_logic_vector(3 downto 0)
  );
end Rom_M_MEM;

architecture structural of Rom_M_MEM is
--segnali intermedi:
signal Yc: std_logic_vector(3 downto 0);
signal yROM : std_logic_vector(7 downto 0); --uscita della ROM di 8 bit
signal yM: std_logic_vector(3 downto 0); --uscita dalla macchina di trasform di 4 bit
signal ENABLE, WRITE, READ: std_logic;

component ROM is
        port(
        CLK: in STD_LOGIC; 
        address: in STD_LOGIC_VECTOR(3 downto 0); 
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
        EN_WR: in std_logic; 
        ADD: in std_logic_vector(3 downto 0);
        DATA_IN: in std_logic_vector(3 downto 0) 
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
        count: in STD_LOGIC_VECTOR(3 downto 0);
        stato: out STD_LOGIC_VECTOR(1 downto 0); 
        EN_RD, EN_WR, EN_COUNT: out STD_LOGIC
  );
end component;

begin

--collegamenti tra le componenti
ROM0: ROM
        Port map(
            CLK => CLK,
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
        CLK => CLK,
        EN_WR => WRITE,
        ADD => Yc,
        DATA_IN => yM
    );
    
 cont: cont_mod16
    port map(
    CLK => CLK,
    RST => RST,
    EN_COUNT => ENABLE,
    count => Yc --l'uscita del contatore deve andare in ingresso ad address della ROM e della mem
    );

cu: control_unit
    port map(
        START => START,
        RST => RST,
        CLK => CLK,
        count => Yc,
        stato => stato,
        EN_RD => READ,
        EN_WR => WRITE,
        EN_COUNT => ENABLE
    );

Y <= yM;
count <= Yc;

end structural;
