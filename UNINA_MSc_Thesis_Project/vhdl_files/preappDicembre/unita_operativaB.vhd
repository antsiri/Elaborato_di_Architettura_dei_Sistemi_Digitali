library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativaB is
  Port ( 
        CLK, RST: in STD_LOGIC;
        selA: in STD_LOGIC;
        din: in STD_LOGIC_VECTOR(3 downto 0);
        load_A: in STD_LOGIC;
        result: out STD_LOGIC_VECTOR(3 downto 0)
        
  );
end unita_operativaB;

architecture Behavioral of unita_operativaB is

component CarryLookAhead 
generic (N: integer range 1 to 32:= 4);
 Port ( 
    X, Y: in std_logic_vector(N-1 downto 0);   
    cin: in std_logic;
    cout: out std_logic;
    sum : out std_logic_vector(N-1 downto 0)
 );
end component;

component registro4 
port( 
      A: in std_logic_vector(3 downto 0);
      clk, res, load: in std_logic;
      B: out std_logic_vector(3 downto 0));
end component;

component mux2_1
port( x0, x1: in std_logic_vector(3 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(3 downto 0)
		  );
end component;

signal A_in, u_carry: STD_LOGIC_VECTOR(3 downto 0);
signal op2: STD_LOGIC_VECTOR(3 downto 0);
signal riporto: STD_LOGIC;

begin

reg: registro4
    port map(
        A => A_in,
        clk => CLK,
        res => RST,
        load => load_A,
        B => op2
    );

CLA: CarryLookAhead 
    port map(
        X => op2,
        Y => din,
        cin => '0',
        cout => riporto,
        sum => u_carry
    );

mux: mux2_1
    port map(
        x0 => (others => '0'),
        x1 => u_carry,
        s => selA,
        y => A_in
    );

res: process(CLK, load_A) 
 begin
 if (CLK'event AND CLK = '1') then 
    if (load_A = '1') then
        result <= u_carry;
       end if;
    end if;
end process;

end Behavioral;
