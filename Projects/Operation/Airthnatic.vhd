library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ArithmeticUnit is
    Port (
        r1 : inout STD_LOGIC_VECTOR(31 downto 0);
        r2 : in STD_LOGIC_VECTOR(31 downto 0);
        r3 : in STD_LOGIC_VECTOR(31 downto 0);
        opcode : in STD_LOGIC_VECTOR(3 downto 0);
        clk : in STD_LOGIC;
        rst : in STD_LOGIC
    );
end ArithmeticUnit;

architecture Behavioral of ArithmeticUnit is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            r1 <= (others => '0');
        elsif rising_edge(clk) then
            case opcode is
                when "0000" => -- ADD
                    r1 <= r2 + r3;
                when "0001" => -- SUB
                    r1 <= r2 - r3;
                when "0010" => -- MUL
                    r1 <= r2 * r3;
                when "0011" => -- DIV
                    if r3 /= "00000000000000000000000000000000" then
                        r1 <= r2 / r3;
                    else
                        r1 <= (others => 'X'); -- Undefined result for division by zero
                    end if;
                when "0100" => -- INC
                    r1 <= r1 + 1;
                when "0101" => -- DEC
                    r1 <= r1 - 1;
                when others =>
                    r1 <= (others => 'X'); -- Undefined opcode
            end case;
        end if;
    end process;
    end Behavioral;