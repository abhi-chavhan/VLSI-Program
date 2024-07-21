library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ENC_Module is
    Port (
        clk : in std_logic;
        start : in std_logic;
        data_in : in std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0);
        done : out std_logic
    );
end ENC_Module;

entity DEC_Module is
    Port (
        clk : in std_logic;
        start : in std_logic;
        data_in : in std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0);
        done : out std_logic
    );
end DEC_Module;

architecture Behavioral of ENC_Module is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if start = '1' then
                -- Simplified encryption process, replace with actual encryption logic
                data_out <= data_in; -- Placeholder
                done <= '1';
            else
                done <= '0';
            end if;
        end if;
    end process;
end Behavioral;

architecture Behavioral of DEC_Module is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if start = '1' then
                -- Simplified decryption process, replace with actual decryption logic
                data_out <= data_in; -- Placeholder
                done <= '1';
            else
                done <= '0';
            end if;
        end if;
    end process;
end Behavioral;