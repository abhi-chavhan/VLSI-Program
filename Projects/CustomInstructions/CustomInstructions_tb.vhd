library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity CustomInstructions_tb is
end entity CustomInstructions_tb;

architecture rtl of CustomInstructions_tb is
    
    constant period_time : time      := 83333 ps;
    signal   finished    : std_logic := '0';
    
    signal CLK : std_logic;
    signal LED : std_logic;
    
    component CustomInstructions is
        port(
            CLK : in     std_logic;
            LED : buffer std_logic := '0'
        );
    end component CustomInstructions;
    
begin

    sim_time_proc: process
    begin
        wait for 200 ms;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin
        while finished /= '1' loop
            CLK <= '0';
            wait for period_time/2;
            CLK <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    
    u1: CustomInstructions
    port map
    (
        CLK => CLK,
        LED => LED
    );

end architecture rtl; 