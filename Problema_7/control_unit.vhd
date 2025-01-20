library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
 Port (
    enable : in STD_LOGIC_VECTOR(3 downto 0); --segnali di ingresso per la gestione della priorita'
    dest_address0: in STD_LOGIC_VECTOR(1 downto 0);
    dest_address1: in STD_LOGIC_VECTOR(1 downto 0);
    dest_address2: in STD_LOGIC_VECTOR(1 downto 0);
    dest_address3: in STD_LOGIC_VECTOR(1 downto 0);
    source_address : out STD_LOGIC_VECTOR(1 downto 0);
    dest_address   : out STD_LOGIC_VECTOR(1 downto 0)
  );
end control_unit;

architecture Behavioral of control_unit is

signal temp_en: STD_LOGIC_VECTOR(3 downto 0);
signal temp_sel: STD_LOGIC_VECTOR(1 downto 0);
begin
--gestione priorita'
    temp_en(0) <= enable(0);
    temp_en(1) <= (NOT enable(0)) AND enable(1);
    temp_en(2) <= (NOT enable(0)) AND (NOT enable(1)) AND enable(2);
    temp_en(3) <= (NOT enable(0)) AND (NOT enable(1)) AND (NOT enable(2)) AND enable(3); 
    
    
    temp_sel(1) <= ((NOT temp_en(0)) AND (NOT temp_en(1)) AND temp_en(2) AND (NOT temp_en(3))) 
                    OR ((NOT temp_en(0)) AND (NOT temp_en(1)) AND (NOT temp_en(2)) AND temp_en(3)); --MSB
    temp_sel(0) <=  (temp_en(0) AND (NOT temp_en(1)) AND (NOT temp_en(2)) AND (NOT temp_en(3))) 
                    OR ((NOT temp_en(0)) AND temp_en(1) AND (NOT temp_en(2)) AND (NOT temp_en(3))); --LSB
    
    source_address <= temp_sel;
    
    dest_address <= dest_address0 when temp_sel = "00" else
                    dest_address1 when temp_sel = "01" else
                    dest_address2 when temp_sel = "10" else
                    dest_address3 when temp_sel = "11";
    

end Behavioral;
