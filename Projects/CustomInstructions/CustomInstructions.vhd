library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CustomInstructions is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        sel : in std_logic_vector(1 downto 0); -- Selection signal for FFT (00), ENC (01), DEC (10)
        r1 : in std_logic_vector(31 downto 0);
        r2 : in std_logic_vector(31 downto 0);
        memory : inout std_logic_vector(1023 downto 0); -- Memory array
        done : out std_logic
    );
end CustomInstructions;

architecture Behavioral of CustomInstructions is
    signal start_fft, start_enc, start_dec : std_logic;
    signal fft_done, enc_done, dec_done : std_logic;
    signal data_in, data_out : std_logic_vector(31 downto 0);
begin
    FFT_INST : entity work.FFT_Module
    Port map (
        clk => clk,
        start => start_fft,
        data_in => data_in,
        data_out => data_out,
        done => fft_done
    );

    ENC_INST : entity work.ENC_Module
    Port map (
        clk => clk,
        start => start_enc,
        data_in => data_in,
        data_out => data_out,
        done => enc_done
    );

    DEC_INST : entity work.DEC_Module
    Port map (
        clk => clk,
        start => start_dec,
        data_in => data_in,
        data_out => data_out,
        done => dec_done
    );

    process(clk, rst)
    begin
        if rst = '1' then
            done <= '0';
            start_fft <= '0';
            start_enc <= '0';
            start_dec <= '0';
        elsif rising_edge(clk) then
            case sel is
                when "00" => -- FFT operation
                    data_in <= memory(to_integer(unsigned(r2)) * 32 + 31 downto to_integer(unsigned(r2)) * 32);
                    start_fft <= '1';
                    if fft_done = '1' then
                        memory(to_integer(unsigned(r1)) * 32 + 31 downto to_integer(unsigned(r1)) * 32) <= data_out;
                        done <= '1';
                        start_fft <= '0';
                    end if;
                when "01" => -- ENC operation
                    data_in <= memory(to_integer(unsigned(r2)) * 32 + 31 downto to_integer(unsigned(r2)) * 32);
                    start_enc <= '1';
                    if enc_done = '1' then
                        memory(to_integer(unsigned(r1)) * 32 + 31 downto to_integer(unsigned(r1)) * 32) <= data_out;
                        done <= '1';
                        start_enc <= '0';
                    end if;
                when "10" => -- DEC operation
                    data_in <= memory(to_integer(unsigned(r2)) * 32 + 31 downto to_integer(unsigned(r2)) * 32);
                    start_dec <= '1';
                    if dec_done = '1' then
                        memory(to_integer(unsigned(r1)) * 32 + 31 downto to_integer(unsigned(r1)) * 32) <= data_out;
                        done <= '1';
                        start_dec <= '0';
                    end if;
                when others =>
                    -- No operation
            end case;
        end if;
    end process;
end Behavioral;