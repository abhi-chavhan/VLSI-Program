library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MemoryAccessInstructions is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        sel : in std_logic;  -- Selection signal to choose between LD (0) and ST (1)
        addr : in std_logic_vector(31 downto 0);
        r1 : inout std_logic_vector(31 downto 0);
        memory : inout std_logic_vector(1023 downto 0) -- Memory array
    );
end MemoryAccessInstructions;

architecture Behavioral of MemoryAccessInstructions is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            -- Initialize memory and registers if needed
        elsif rising_edge(clk) then
            if sel = '0' then
                -- LD operation
                r1 <= memory(to_integer(unsigned(addr)) * 32 + 31 downto to_integer(unsigned(addr)) * 32);
            elsif sel = '1' then
                -- ST operation
                memory(to_integer(unsigned(addr)) * 32 + 31 downto to_integer(unsigned(addr)) * 32) <= r1;
            end if;
        end if;
    end process;
end Behavioral;