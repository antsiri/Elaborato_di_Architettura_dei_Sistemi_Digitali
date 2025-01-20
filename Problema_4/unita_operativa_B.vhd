library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa_B is
  Port ( 
        CLK, RST: in STD_LOGIC;
        EN_RD, EN_WR, EN_COUNT: in STD_LOGIC;
        X: in STD_LOGIC_VECTOR(7 downto 0);
        Y: out std_logic_vector(7 downto 0);
        count: out STD_LOGIC_VECTOR(3 downto 0);
        result: out STD_LOGIC_VECTOR(7 downto 0)
  );
end unita_operativa_B;

architecture structural of unita_operativa_B is

component RCA
   generic (N: integer range 1 to 32:= 8);
  Port (
    X, Y: in std_logic_vector(N-1 downto 0);
    cin: in std_logic;
    cout: out std_logic;
    sum: out std_logic_vector(N-1 downto 0)
   );
end component;

component MEM_B
 generic(N: integer range 0 to 32:= 16);
    port(
        CLK: in STD_LOGIC; --La read è sincrona
        address: in STD_LOGIC_VECTOR(3 downto 0); 
        value_in: in STD_LOGIC_VECTOR(7 downto 0);
        EN_RD: in STD_LOGIC;
        EN_WR: in STD_LOGIC;
        dout: out STD_LOGIC_VECTOR(7 downto 0)
         );
end component;

component counter_modN
generic (N: integer range 0 to 32:= 16);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal temp_count: STD_LOGIC_VECTOR(3 downto 0);
signal temp_sum: STD_LOGIC_VECTOR(7 downto 0);
signal operando: STD_LOGIC_VECTOR(7 downto 0);
signal riporto: STD_LOGIC;

begin

mem: MEM_B
     port map(
         CLK => CLK,
         address => temp_count,
         value_in => temp_sum,
         EN_RD => EN_RD,
         EN_WR => EN_WR,
         dout => operando
     );
     
adder: RCA
    port map(
        X => X,
        Y => operando,
        cin => '0',
        cout => riporto,
        sum => temp_sum
    );
    
cont: counter_modN
    port map(
        clock => CLK,
        reset => RST,
        enable => EN_COUNT,
        counter => temp_count
    );
 count <= temp_count;
 res: process(CLK, EN_WR) 
 begin
 if (CLK'event AND CLK = '1') then 
    if (EN_WR = '1') then
        result <= temp_sum;
       end if;
    end if;
end process;
 Y <= operando;
end structural;
