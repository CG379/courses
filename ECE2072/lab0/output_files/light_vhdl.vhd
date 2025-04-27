--Define the libraries we want to use for compiling
library ieee;
use ieee.std_logic_1164.all;

-- Define our entity
entity light_vhdl is
  port (
    x1    : in  std_logic;
    x2    : in  std_logic;
    f		 : out std_logic
    );
end light_vhdl;
 
-- Define the architecture of our entity
architecture rtl of light_vhdl is

	-- Use a signal instance to implement a xor gate
	signal xor_gate : std_logic;
	begin
	  xor_gate   <= x1 xor x2;
	  f <= xor_gate;
	  
end rtl;
