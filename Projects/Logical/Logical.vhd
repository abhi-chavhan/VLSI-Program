library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LogicalInstructions is
    Port (
        r2 : in std_logic_vector(31 downto 0);
        r3 : in std_logic_vector(31 downto 0);
        sel : in std_logic_vector(1 downto 0);  -- Selection signal to choose the operation
        r1 : out std_logic_vector(31 downto 0)
    );
end LogicalInstructions;

architecture Behavioral of LogicalInstructions is
begin
    process(r2, r3, sel)
    begin
        case sel is
            when "00" => -- AND operation
                r1 <= r2 and r3;
            when "01" => -- OR operation
                r1 <= r2 or r3;
            when "10" => -- XOR operation
                r1 <= r2 xor r3;
            when "11" => -- NOT operation (only r2 is used, r3 is ignored)
                r1 <= not r2;
            when others =>
                r1 <= (others => '0'); -- Default case
        end case;
    end process;
end Behavioral;