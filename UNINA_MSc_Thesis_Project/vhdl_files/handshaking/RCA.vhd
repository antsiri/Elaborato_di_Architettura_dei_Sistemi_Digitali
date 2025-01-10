library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA is
generic (N: integer range 1 to 32:= 8);
  Port (
    X, Y: in std_logic_vector(N-1 downto 0);
    cin: in std_logic;
    cout: out std_logic;
    sum: out std_logic_vector(N-1 downto 0)
   );
end RCA;

architecture structural of RCA is
signal temp_s: std_logic_vector(N-1 downto 0);
signal temp_c: std_logic_vector(N-1 downto 0);

component full_adder is
    port(
      x, y, cin: in std_logic;
        cout: out std_logic;
        s: out std_logic
    );
end component;

begin
fa0: full_adder
    port map(
        x => X(0),
        y => Y(0),
        cin => cin,
        cout => temp_c(0),
        s => temp_s(0)
    );

fa1toN_1: for i in 1 to N-1 generate
    fa: full_adder
        port map(
        x => X(i),
        y => Y(i),
        cin => temp_c(i-1),
        cout => temp_c(i),
        s => temp_s(i)
        );
end generate;

sum <= temp_s;
cout <= temp_c(N-1);

end structural;
