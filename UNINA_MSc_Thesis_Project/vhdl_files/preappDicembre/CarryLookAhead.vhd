library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarryLookAhead is
generic (N: integer range 1 to 32:= 4);
 Port ( 
    X, Y: in std_logic_vector(N-1 downto 0);
    cin: in std_logic;
    cout: out std_logic;
    sum : out std_logic_vector(N-1 downto 0)
 );
end CarryLookAhead;

architecture Behavioral of CarryLookAhead is
signal c: std_logic_vector(N-1 downto 0);
signal temp_sum: std_logic_vector(N-1 downto 0);

component full_adder is
Port ( 
        x, y, cin: in std_logic;
        cout: out std_logic;
        s: out std_logic
        
  );
end component;

begin
c(0) <= cin;

cin1toN_1: for i in 1 to N-1 generate
    c(i) <= (X(i-1) and Y(i-1)) OR (c(i-1) and (X(i-1) XOR Y(i-1)));
end generate;

fa0: full_adder
    port map(
        x => X(0),
        y => Y(0),
        cin => c(0),
        cout => open,
        s => temp_sum(0)
        );

fa1toN_2: for i in 1 to N-2 generate
    fa: full_adder
        port map(
         x => X(i),
        y => Y(i),
        cin => c(i),
        cout => open,
        s => temp_sum(i)
        );
end generate;

faN_1: full_adder
    port map(
        x => X(N-1),
        y => Y(N-1),
        cin => c(N-1),
        cout => cout,
        s => temp_sum(N-1)
        );


sum <= temp_sum;

        
end Behavioral;
