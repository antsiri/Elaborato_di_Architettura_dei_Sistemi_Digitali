library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
  Port ( 
        x, y, cin: in std_logic;
        cout: out std_logic;
        s: out std_logic
        
  );
end full_adder;

architecture dataflow of full_adder is

begin
cout <= (x AND y) OR (cin AND (x XOR y));
s <= (x XOR y XOR cin);

end dataflow;
