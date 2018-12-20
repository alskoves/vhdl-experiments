library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity motorpasso is
	port(
		direcao, enable, clock, reset : in bit;
		motor :	out bit_vector(3 downto 0)
	);
end motorpasso;
	
architecture giroflex of motorpasso is
	type passo is (ZERO, UM, DOIS, TRES, QUATRO, CINCO, SEIS, SETE);
	signal proest, atuest: passo;
begin
	process(clock,reset)
	begin
		if	(reset='1') then
			atuest <= ZERO;
		elsif (clock'event and clock='0') then
			atuest <= proest;
		end if;
	end process;
	process(direcao,enable,proest,atuest)
	begin
		if 	(enable='1') then
			if (direcao='1') then
				case atuest is
					when ZERO	=>
						motor <= "1000";
						proest <= UM;
					when UM		=>
						motor <= "1100";
						proest <= DOIS;
					when DOIS	=>
						motor <= "0100";
						proest <= TRES;
					when TRES	=>
						motor <= "0110";
						proest <= QUATRO;
					when QUATRO	=>
						motor <= "0010";
						proest <= CINCO;
					when CINCO	=>
						motor <= "0011";
						proest <= SEIS;
					when SEIS	=>
						motor <= "0001";
						proest <= SETE;
					when SETE	=>
						motor <= "1001";
						proest <= ZERO;
				end case;
			elsif (direcao='0') then
				case atuest is
					when ZERO	=>
						motor <= "1000";
						proest <= SETE;
					when UM		=>
						motor <= "1100";
						proest <= ZERO;
					when DOIS	=>
						motor <= "0100";
						proest <= UM;
					when TRES	=>
						motor <= "0110";
						proest <= DOIS;
					when QUATRO	=>
						motor <= "0010";
						proest <= TRES;
					when CINCO	=>
						motor <= "0011";
						proest <= QUATRO;
					when SEIS	=>
						motor <= "0001";
						proest <= CINCO;
					when SETE	=>
						motor <= "1001";
						proest <= SEIS;
				end case;
			end if;
		elsif (enable='0') then
			proest <= atuest;
	end if;
	end process;
end giroflex;
