----------------------------------------------------------------------------------------------
--
--      Input file         : sram_4en.vhd
--      Design name        : sram_4en
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description          : Single Port Synchronous Random Access Memory with 4 write enable
--                             ports.
--      Architecture 'arch'  : Default implementation
--      Architecture 'arch2' : Alternative implementation
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.std_Pkg.ALL;

ENTITY sram_4en IS GENERIC
(
    WIDTH : positive := 32;
    SIZE  : positive := 16
);
PORT
(
    dat_o : OUT std_logic_vector(WIDTH - 1 DOWNTO 0);
    dat_i : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
    adr_i : IN std_logic_vector(SIZE - 1 DOWNTO 0);
    wre_i : IN std_logic_vector(WIDTH/8 - 1 DOWNTO 0);
    ena_i : IN std_logic;
    clk_i : IN std_logic
);
END sram_4en;

-- Although this memory is very easy to use in conjunction with Modelsims mem load, it is not
-- supported by many devices (although it comes straight from the library. Many devices give
-- cryptic synthesization errors on this implementation, so it is not the default.
ARCHITECTURE arch2 OF sram_4en IS

    TYPE ram_type IS array(2 ** SIZE - 1 DOWNTO 0) OF std_logic_vector(WIDTH - 1 DOWNTO 0);
    TYPE sel_type IS array(WIDTH/8 - 1 DOWNTO 0) OF std_logic_vector(7 DOWNTO 0);

    SIGNAL ram: ram_type;
    SIGNAL di: sel_type;
BEGIN
    PROCESS(wre_i, dat_i, adr_i)
    BEGIN
        FOR i IN 0 TO WIDTH/8 - 1 LOOP
            IF wre_i(i) = '1' THEN
                di(i) <= dat_i((i+1)*8 - 1 DOWNTO i*8);
            ELSE
                di(i) <= ram(my_conv_integer(adr_i))((i+1)*8 - 1 DOWNTO i*8);
            END IF;
        END LOOP;
    END PROCESS;

    PROCESS(clk_i)
    BEGIN
        IF rising_edge(clk_i) THEN
            IF ena_i = '1' THEN
                ram(my_conv_integer(adr_i)) <= di(3) & di(2) & di(1) & di(0);
                dat_o <= di(3) & di(2) & di(1) & di(0);
            END IF;
        END IF;
    END PROCESS;
END arch2;

-- Less convenient but very general memory block with four separate write
-- enable signals. (4x8 bit)
ARCHITECTURE arch OF sram_4en IS
BEGIN
   mem: FOR i IN 0 TO WIDTH/8 - 1 GENERATE
       mem : sram GENERIC MAP
       (
           WIDTH   => 8,
           SIZE    => SIZE
       )
       PORT MAP
       (
           dat_o   => dat_o((i+1)*8 - 1 DOWNTO i*8),
           dat_i   => dat_i((i+1)*8 - 1 DOWNTO i*8),
           adr_i   => adr_i,
           wre_i   => wre_i(i),
           ena_i   => ena_i,
           clk_i   => clk_i
       );
   END GENERATE;
END arch;
