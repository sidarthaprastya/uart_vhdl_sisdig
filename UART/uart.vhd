library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity uart is
port ( 	clk   : in std_logic;      -----system clock i/p
       	reset : in std_logic;      -----switch input
		din   : in  std_logic;     -----fpga receive i/p
		do    : out std_logic);   ------fpga transmit o/p
end uart;

architecture Behavioral of uart is
    type state is (ready,b0,b1,b2,b3,b4,b5,b6,b7,b8);   ----fsm for receive
    signal ps : state := ready;
    type state1 is (ready1,b01,b11,b21,b31,b41,b51,b61,b71,b81);  -----fsm for transmit
    signal ps1 : state1 := ready1;
    signal start,stop : std_logic := '0';
    signal store : std_logic_vector(7 downto 0) := "00000000";  ----storing of recived value

    begin
        process(reset,clk)
        variable i : integer := 0 ;
        variable word: integer := 0;
        begin
            if reset = '1' then
                if clk'event and clk = '1' then
                    if ps = ready then     ----logic to detect the transmission start
                        start <= din;
                    end if;

                    if start = '0' then
                        ps <= b0;
                    elsif start = '1' then
                        ps <= ready;
                    end if;
                ------------------------------------------1
                    if ps = b0 then
                        store(0) <= din;        -----receive and store of each bit
                        i := i + 1;
                        ps <= b0;
                        if i = 5209 then    -----timing delay to receive bit
                            i := 0;
                            ps <= b1;
                        end if;
                    end if;
                ------------------------------------------2
                    if ps = b1 then
                        store(1) <= din;
                        i := i + 1;
                        ps <= b1;
                        if i = 5209 then
                            i := 0;
                            ps <= b2;
                        end if;
                    end if;
                -----------------------------------------3
                    if ps = b2 then
                        store(2) <= din;
                        i := i + 1;
                        ps <= b2;
                        if i = 5209 then
                            i := 0;
                            ps <= b3;
                        end if;
                    end if;
                ----------------------------------------4
                    if ps = b3 then
                        store(3) <= din;
                        i := i + 1;
                        ps <= b3;
                        if i = 5209 then
                            i := 0;
                            ps <= b4;
                        end if;
                    end if;
                ---------------------------------------5
                    if ps = b4 then
                        store(4) <= din;
                        i := i + 1;
                        ps <= b4;
                        if i = 5209 then
                            i := 0;
                            ps <= b5;
                        end if;
                    end if;
                ---------------------------------------6
                    if ps = b5 then
                        store(5) <= din;
                        i := i + 1;
                        ps <= b5;
                        if i = 5209 then
                            i := 0;
                            ps <= b6;
                        end if;
                    end if;
                ---------------------------------------7
                    if ps = b6 then
                        store(6) <= din;
                        i := i + 1;
                        ps <= b6;
                        if i = 5209 then
                            i := 0;
                            ps <= b7;
                        end if;
                    end if;
                --------------------------------------8
                    if ps = b7 then
                        store(7) <= din;
                        i := i + 1;
                        ps <= b7;
                        if i = 5209 then
                            i := 0;
                            ps <= b8;
                        end if;
                    end if;
                --------------------------------------9
                    if ps = b8 then
                        stop <= din;
                        i := i + 1;
                        ps <= b8;
                        if i = 5209 then
                            i := 0;
                            ps <= ready;
                        end if;
                    end if;
                -------------------------------------10
                end if;
            end if;
        end process;
    ----------------------------------------------------------------------transmit
        process(reset,clk)
        variable i : integer := 0 ;
        begin
            if reset = '1' then
                if clk'event and clk = '1' then
                    if ps1 = ready1 then
                        if start = '0' then     -----logic to indicate the communication to the partner
                            do <= '0';
                            i := i + 1;
                            ps1 <= ready1;
                            if i = 5209 then
                                i := 0;
                                ps1 <= b01;
                            end if;
                        elsif start = '1' then
                            ps1 <= ready1;
                        end if;
                    end if;
                ------------------------------------------1
                    if ps1 = b01 then
                        do <= store(0);     ----transmission of each bit
                        i := i + 1;
                        ps1 <= b01;
                        if i = 5209 then    ----timing delay for transmission of each bit
                            i := 0;
                            ps1 <= b11;
                        end if;
                    end if;
                ------------------------------------------2
                    if ps1 = b11 then
                        do <= store(1);
                        i := i + 1;
                        ps1 <= b11;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b21;
                        end if;
                    end if;
                -----------------------------------------3
                    if ps1 = b21 then
                        do <= store(2);
                        i := i + 1;
                        ps1 <= b21;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b31;
                        end if;
                    end if;
                ----------------------------------------4
                    if ps1 = b31 then
                        do <= store(3);
                        i := i + 1;
                        ps1 <= b31;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b41;
                        end if;
                    end if;
                ---------------------------------------5
                    if ps1 = b41 then
                        do <= store(4);
                        i := i + 1;
                        ps1 <= b41;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b51;
                        end if;
                    end if;
                ---------------------------------------6
                    if ps1 = b51 then
                        do <= store(5);
                        i := i + 1;
                        ps1 <= b51;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b61;
                        end if;
                    end if;
                ---------------------------------------7
                    if ps1 = b61 then
                        do <= store(6);
                        i := i + 1;
                        ps1 <= b61;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b71;
                        end if;
                    end if;
                --------------------------------------8
                    if ps1 = b71 then
                        do <= store(7);
                        i := i + 1;
                        ps1 <= b71;
                        if i = 5209 then
                            i := 0;
                            ps1 <= b81;
                        end if;
                    end if;
                --------------------------------------9
                    if ps1 = b81 then
                        do <= '1';
                        i := i + 1;
                        ps1 <= b81;
                        if i = 5209 then
                            i := 0;
                            ps1 <= ready1;
                        end if;
                    end if;
                -------------------------------------10
                end if;
            end if;
        end process;
end Behavioral;