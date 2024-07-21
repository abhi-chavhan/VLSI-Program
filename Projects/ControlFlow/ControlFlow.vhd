library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlFlowInstructions is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        sel : in std_logic_vector(2 downto 0);  -- Selection signal to choose the instruction
        addr : in std_logic_vector(31 downto 0);
        r1 : in std_logic_vector(31 downto 0);
        r2 : in std_logic_vector(31 downto 0);
        PC : inout std_logic_vector(31 downto 0);
        stack : inout std_logic_vector(1023 downto 0); -- Stack memory
        SP : inout std_logic_vector(9 downto 0) -- Stack pointer
    );
end ControlFlowInstructions;

architecture Behavioral of ControlFlowInstructions is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            PC <= (others => '0');
            SP <= (others => '0');
        elsif rising_edge(clk) then
            case sel is
                when "000" => -- JMP operation
                    PC <= addr;
                when "001" => -- BEQ operation
                    if r1 = r2 then
                        PC <= addr;
                    end if;
                when "010" => -- BNE operation
                    if r1 /= r2 then
                        PC <= addr;
                    end if;
                when "011" => -- CALL operation
                    stack(to_integer(SP)) <= PC + 1;
                    SP <= SP - 1;
                    PC <= addr;
                when "100" => -- RET operation
                    SP <= SP + 1;
                    PC <= stack(to_integer(SP));
                when others =>
                    -- No operation
            end case;
        end if;
    end process;
end Behavioral;