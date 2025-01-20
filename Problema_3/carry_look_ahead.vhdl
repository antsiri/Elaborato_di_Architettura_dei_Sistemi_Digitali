library ieee;
use     ieee.std_logic_1164.all;

entity carry_look_ahead is
    port
    (
        X   :   in  std_logic_vector(7 downto 0);
        Y   :   in  std_logic_vector(7 downto 0);
        Cin :   in  std_logic;

        Sum :   out std_logic_vector(7 downto 0);
        Cout:   out std_logic
    );
end entity;

architecture behavioral of carry_look_ahead is
    signal  G               :   std_logic_vector(7 downto 0);
    signal  P               :   std_logic_vector(7 downto 0);

    signal  C               :   std_logic_vector(8 downto 0);

    signal  multiplicand    :   std_logic_vector(7 downto 0);

begin
    process(Cin)
    begin
        Y_value: for k in 0 to 7 loop
            multiplicand(k) <=  Y(k) xor Cin;
        end loop;
    end process; 

    G_P: for k in 0 to 7 generate
        G(k)    <=  X(k) and multiplicand(k);
        P(k)    <=  X(k) xor multiplicand(k); 
    end generate; 

    C(0)    <=  Cin;

    C_value: for i in 1 to 8 generate 
        C(i)    <=  G(i-1) or (P(i-1) and C(i-1));
    end generate;

    sum_value: for i in 0 to 7 generate
        Sum(i) <=  P(i) xor C(i);
    end generate;
    
    Cout    <=  C(8);
end behavioral;