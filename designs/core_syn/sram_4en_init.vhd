----------------------------------------------------------------------------------------------
--
--      Input file         : sram_4en_init.vhd
--      Design name        : sram_4en_init
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Single Port Synchronous Random Access Memory with 4 write enable
--                           ports.
--                           Initialized with hello world program
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.std_Pkg.ALL;

ENTITY sram_4en_init IS GENERIC
(
    WIDTH : integer := 32;
    SIZE  : integer := 11
);
PORT
(
    dat_o                   : OUT std_logic_vector(WIDTH - 1 DOWNTO 0);
    dat_i                   : IN std_logic_vector(WIDTH - 1 DOWNTO 0);
    adr_i                   : IN std_logic_vector(SIZE - 1 DOWNTO 0);
    wre_i                   : IN std_logic_vector(3 DOWNTO 0);
    ena_i                   : IN std_logic;
    clk_i                   : IN std_logic
);
END sram_4en_init;

ARCHITECTURE arch OF sram_4en_init IS
  TYPE ram_type IS array (0 TO 2 ** SIZE - 1) OF std_logic_vector(WIDTH - 1 DOWNTO 0);
  SIGNAL ram : ram_type := (
    X"B8080050",X"00000000",X"B8080728",X"00000000",X"B8080738",X"00000000",X"00000000",X"00000000",
    X"B8080730",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"31A01028",X"30400F18",X"B0000000",X"30209038",
    X"B9F400C0",X"80000000",X"B9F406E8",X"30A30000",X"B8000000",X"E0601028",X"3021FFE4",X"F9E10000",
    X"BC030014",X"B8000040",X"F8600F20",X"99FC2000",X"80000000",X"E8600F20",X"E8830000",X"BE24FFEC",
    X"30630004",X"B0000000",X"30600000",X"BC030010",X"30A01020",X"99FC1800",X"80000000",X"30600001",
    X"F0601028",X"E9E10000",X"B60F0008",X"3021001C",X"B0000000",X"30600000",X"3021FFE4",X"F9E10000",
    X"30A01020",X"30C0102C",X"BC03000C",X"99FC1800",X"80000000",X"E8601024",X"B0000000",X"30800000",
    X"BC030014",X"30A01024",X"BC04000C",X"99FC2000",X"80000000",X"E9E10000",X"B60F0008",X"3021001C",
    X"2021FFEC",X"F9E10000",X"20C01028",X"20E01028",X"06463800",X"BC720014",X"F8060000",X"20C60004",
    X"06463800",X"BC92FFF4",X"20C01028",X"20E01044",X"06463800",X"BC720014",X"F8060000",X"20C60004",
    X"06463800",X"BC92FFF4",X"B9F405E0",X"80000000",X"B9F40954",X"80000000",X"20C00000",X"20E00000",
    X"B9F40098",X"20A00000",X"32630000",X"B9F4095C",X"80000000",X"B9F405AC",X"80000000",X"C9E10000",
    X"30730000",X"B60F0008",X"20210014",X"3021FFF4",X"FA610008",X"12610000",X"F0B30010",X"3060FFC0",
    X"F8730004",X"E8930004",X"E0730010",X"F0640000",X"10330000",X"EA610008",X"3021000C",X"B60F0008",
    X"80000000",X"3021FFF4",X"FA610008",X"12610000",X"3060FFC0",X"F8730004",X"E8730004",X"E0630000",
    X"90630060",X"10330000",X"EA610008",X"3021000C",X"B60F0008",X"80000000",X"3021FFE0",X"F9E10000",
    X"FA61001C",X"12610000",X"30A00B14",X"B9F4021C",X"80000000",X"10600000",X"E9E10000",X"10330000",
    X"EA61001C",X"30210020",X"B60F0008",X"80000000",X"E9050000",X"E9200F24",X"11450000",X"E0880000",
    X"90E40060",X"C0693800",X"A4630004",X"BE030038",X"10C30000",X"10C00000",X"64660402",X"31080001",
    X"E0A80000",X"10633000",X"10631800",X"10633800",X"90E50060",X"C0893800",X"A4840004",X"BE24FFDC",
    X"30C3FFD0",X"F90A0000",X"B60F0008",X"10660000",X"3021FFDC",X"FAC10020",X"F9E10000",X"FA61001C",
    X"E8660010",X"BE03000C",X"12C60000",X"BC250018",X"E9E10000",X"EA61001C",X"EAC10020",X"B60F0008",
    X"30210024",X"EA660000",X"E8660004",X"16439801",X"BCB2FFE0",X"E0B6000C",X"B9F4FEB4",X"32730001",
    X"E8760004",X"16439801",X"BC52FFEC",X"B800FFC4",X"E8600B24",X"3021FF98",X"E8800B28",X"F861001C",
    X"E8600B2C",X"F8810020",X"E8800B30",X"F8610024",X"E0600B34",X"FAE10058",X"FB210060",X"F061002C",
    X"F9E10000",X"FA610050",X"FAC10054",X"FB01005C",X"FB410064",X"12E60000",X"F8810028",X"10650000",
    X"AA46000A",X"BE1200D4",X"13270000",X"12630000",X"13400000",X"33010030",X"12D80000",X"10B30000",
    X"B9F405A0",X"10D70000",X"10611800",X"E083001C",X"10B30000",X"10D70000",X"F0960000",X"B9F40640",
    X"32D60001",X"BE23FFD8",X"12630000",X"BE1A0010",X"3060002D",X"F0760000",X"32D60001",X"10B80000",
    X"F2760000",X"B9F403C0",X"3276FFFF",X"E8990014",X"10D90000",X"F8790000",X"14A40000",X"80A52000",
    X"A8A5FFFF",X"B9F4FECC",X"64A5001F",X"16589803",X"BC520018",X"E0B30000",X"B9F4FDB4",X"3273FFFF",
    X"16589803",X"BCB2FFF0",X"E8B90014",X"B9F4FEA4",X"10D90000",X"E9E10000",X"EA610050",X"EAC10054",
    X"EAE10058",X"EB01005C",X"EB210060",X"EB410064",X"B60F0008",X"30210068",X"BEA5FF34",X"33400001",
    X"B810FF34",X"16650000",X"F8A10004",X"F8C10008",X"F8E1000C",X"F9010010",X"F9210014",X"F9410018",
    X"3021FFBC",X"3061004C",X"F9E10000",X"FA61003C",X"FAC10040",X"F861001C",X"F8A10020",X"E0650000",
    X"90630060",X"BC230028",X"B80000F4",X"B9F4FD20",X"10A30000",X"E8A10020",X"30650001",X"F8610020",
    X"E0850001",X"90640060",X"BC0300D4",X"AA430025",X"BE32FFDC",X"12600000",X"12D30000",X"E8A10020",
    X"E8E00F24",X"30600020",X"30807FFF",X"F0610030",X"F881002C",X"FA610034",X"FA610038",X"10650000",
    X"30A50001",X"F8A10020",X"E0830001",X"90C40060",X"C0873000",X"A4640004",X"BC03003C",X"BC360064",
    X"AA460030",X"BC12006C",X"B9F4FD48",X"30A10020",X"F8610028",X"30600001",X"F8610034",X"E8A10020",
    X"E8E00F24",X"30A5FFFF",X"F8A10020",X"B810FFB4",X"10650000",X"A4640001",X"BE03000C",X"10860000",
    X"30860020",X"3064FFDB",X"22400053",X"16439003",X"BE52FF48",X"64630402",X"E8830B38",X"98082000",
    X"B9F4FCF0",X"30A10020",X"F861002C",X"B800FFB0",X"30600030",X"F0610030",X"B800FF90",X"E9E10000",
    X"EA61003C",X"EAC10040",X"B60F0008",X"30210044",X"B9F4FC1C",X"30A00025",X"E8A10020",X"B810FF00",
    X"30650001",X"30600001",X"F8610038",X"B810FF34",X"10650000",X"B810FF28",X"32C00001",X"AA460068",
    X"BC120120",X"32400068",X"16469001",X"BC520120",X"AA460061",X"BC120148",X"B9F4FBD4",X"10A60000",
    X"E8A10020",X"E8E00F24",X"30A50001",X"F8A10020",X"B810FEF0",X"10650000",X"E861001C",X"E0A30003",
    X"30630004",X"F861001C",X"B9F4FBA4",X"80000000",X"E8A10020",X"B810FE88",X"30650001",X"E861001C",
    X"30C0000A",X"E8A30000",X"30630004",X"F861001C",X"B9F4FCE0",X"30E10024",X"E8A10020",X"B810FE60",
    X"30650001",X"B810FE98",X"32600001",X"E861001C",X"32C10024",X"EA630000",X"30630004",X"F861001C",
    X"B9F40124",X"10B30000",X"E8810038",X"10D60000",X"F8610024",X"14A40000",X"80A52000",X"A8A5FFFF",
    X"B9F4FC30",X"64A5001F",X"E0730000",X"BC23001C",X"B800002C",X"E0B30000",X"B9F4FB14",X"32730001",
    X"E0730000",X"BC030018",X"E861002C",X"3063FFFF",X"F861002C",X"AA43FFFF",X"BC32FFDC",X"E8A10038",
    X"B9F4FBF0",X"10D60000",X"E8A10020",X"B810FDD0",X"30650001",X"E861001C",X"B810FF4C",X"30C00010",
    X"B9F4FACC",X"30A00008",X"B800FEF8",X"AA46006E",X"BC120018",X"AA460072",X"BC32FEE0",X"B9F4FAB0",
    X"30A0000D",X"B800FEDC",X"B9F4FAA4",X"30A0000D",X"B9F4FA9C",X"30A0000A",X"B800FEC8",X"B9F4FA90",
    X"30A00007",X"B800FEBC",X"B6110000",X"80000000",X"B6910000",X"80000000",X"B62E0000",X"80000000",
    X"B60F0008",X"80000000",X"B60F0008",X"80000000",X"3021FFE0",X"10C00000",X"FA61001C",X"F9E10000",
    X"B9F4007C",X"12650000",X"E8A00F0C",X"E8650028",X"BC03000C",X"99FC1800",X"80000000",X"B9F4F8F4",
    X"10B30000",X"A4650003",X"BE23003C",X"10C50000",X"E8650000",X"B000FEFE",X"3083FEFF",X"B0008080",
    X"A4848080",X"A863FFFF",X"84632000",X"BE03FFE4",X"30A50004",X"30A5FFFC",X"E0650000",X"BC030018",
    X"30A50001",X"E0650000",X"BE23FFFC",X"30A50001",X"30A5FFFF",X"B60F0008",X"14662800",X"E8600F0C",
    X"3021FFC8",X"FB410030",X"FB610034",X"F9E10000",X"FA61001C",X"FAC10020",X"FAE10024",X"FB010028",
    X"FB21002C",X"EB230048",X"13650000",X"BE1900D0",X"13460000",X"E8790004",X"EB190088",X"3263FFFF",
    X"BC5300BC",X"10939800",X"10842000",X"30640008",X"12F91800",X"B810002C",X"12D82000",X"BC180010",
    X"E8760080",X"1643D000",X"BC12001C",X"3273FFFF",X"32D6FFFC",X"AA53FFFF",X"BE120084",X"32F7FFFC",
    X"BC3AFFDC",X"E8790004",X"E8F70000",X"3063FFFF",X"16439800",X"BC120090",X"F8170000",X"BC07FFD0",
    X"BE18004C",X"30800001",X"E8780100",X"A653001F",X"BE120014",X"10840000",X"3252FFFF",X"BE32FFFC",
    X"10842000",X"84641800",X"BC030024",X"E8780104",X"84641800",X"BC030058",X"E8B60000",X"99FC3800",
    X"3273FFFF",X"B810FF90",X"32D6FFFC",X"99FC3800",X"3273FFFF",X"B810FF80",X"32D6FFFC",X"E9E10000",
    X"EA61001C",X"EAC10020",X"EAE10024",X"EB010028",X"EB21002C",X"EB410030",X"EB610034",X"B60F0008",
    X"30210038",X"FA790004",X"B800FF74",X"E8D60000",X"99FC3800",X"10BB0000",X"B810FF38",X"3273FFFF",
    X"3021FFF4",X"FBA10000",X"FBC10004",X"FBE10008",X"BC060094",X"BE050090",X"30600000",X"33C00000",
    X"33A00020",X"06453000",X"BC120080",X"8A453000",X"BEB20010",X"30650000",X"BC460070",X"B800000C",
    X"06453000",X"BC920064",X"BE860020",X"30600000",X"B0007FFF",X"3240FFFF",X"84A59000",X"84C69000",
    X"B8100048",X"04662800",X"BC450010",X"00A52800",X"BEA5FFFC",X"33BDFFFF",X"00A52800",X"08631800",
    X"07E61800",X"BC5F000C",X"8060F800",X"33DE0001",X"33BDFFFF",X"BC1D000C",X"03DEF000",X"B800FFDC",
    X"B8000008",X"80600000",X"EBA10000",X"EBC10004",X"EBE10008",X"B60F0008",X"3021000C",X"3021FFF4",
    X"FBA10000",X"FBC10004",X"FBE10008",X"BC060080",X"BE05007C",X"33C00000",X"33A00020",X"06453000",
    X"BE120070",X"30600001",X"8A453000",X"BEB20010",X"00600000",X"BC46005C",X"B800000C",X"06462800",
    X"BC520050",X"BC86000C",X"B8100048",X"30600001",X"BC450010",X"00A52800",X"BE85FFFC",X"33BDFFFF",
    X"00A52800",X"0BDEF000",X"07E6F000",X"BC5F000C",X"83C0F800",X"30630001",X"33BDFFFF",X"BC1D000C",
    X"00631800",X"B800FFDC",X"B8000008",X"80600000",X"EBA10000",X"EBC10004",X"EBE10008",X"B60F0008",
    X"3021000C",X"E8600B04",X"3021FFE0",X"FA61001C",X"F9E10000",X"32600B04",X"AA43FFFF",X"BC120018",
    X"99FC1800",X"3273FFFC",X"E8730000",X"AA43FFFF",X"BC32FFF0",X"E9E10000",X"EA61001C",X"B60F0008",
    X"30210020",X"3021FFF8",X"D9E00800",X"B9F4F604",X"80000000",X"B9F4FFB0",X"80000000",X"C9E00800",
    X"B60F0008",X"30210008",X"3021FFF8",X"D9E00800",X"B9F4F584",X"80000000",X"C9E00800",X"B60F0008",
    X"30210008",X"FFFFFFFF",X"00000000",X"FFFFFFFF",X"00000000",X"48656C6C",X"6F2C2077",X"6F726C64",
    X"210A0000",X"30313233",X"34353637",X"38394142",X"43444546",X"00000000",X"00000590",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"000005A4",X"000005B4",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"000005BC",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"000005F8",X"0000061C",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"00000498",X"00000644",X"00000498",X"00000498",
    X"00000498",X"00000498",X"00000498",X"00000498",X"0000064C",X"00000498",X"00000498",X"00000498",
    X"00000498",X"000006D4",X"00202020",X"20202020",X"20202828",X"28282820",X"20202020",X"20202020",
    X"20202020",X"20202020",X"20881010",X"10101010",X"10101010",X"10101010",X"10040404",X"04040404",
    X"04040410",X"10101010",X"10104141",X"41414141",X"01010101",X"01010101",X"01010101",X"01010101",
    X"01010101",X"10101010",X"10104242",X"42424242",X"02020202",X"02020202",X"02020202",X"02020202",
    X"02020202",X"10101010",X"20000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"20202020",X"20202020",X"20282828",X"28282020",X"20202020",
    X"20202020",X"20202020",X"20202020",X"88101010",X"10101010",X"10101010",X"10101010",X"04040404",
    X"04040404",X"04041010",X"10101010",X"10414141",X"41414101",X"01010101",X"01010101",X"01010101",
    X"01010101",X"01010110",X"10101010",X"10424242",X"42424202",X"02020202",X"02020202",X"02020202",
    X"02020202",X"02020210",X"10101020",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000F2C",X"43000000",X"00000000",X"00000000",X"00000000",
    X"00000B10",X"00000E0C",X"00000F2C",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000F10",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"FFFFFFFF",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000");

    SIGNAL di0, di1, di2, di3 : std_logic_vector(WIDTH/4 - 1 DOWNTO 0);
BEGIN
    process(wre_i, dat_i, adr_i)
    begin
       if wre_i(0) = '1' then
          di0 <= dat_i(WIDTH/4 - 1 DOWNTO 0);
       else
          di0 <= ram(my_conv_integer(adr_i))(WIDTH/4 - 1 DOWNTO 0);
       end if;

       if wre_i(1) = '1' then
          di1 <= dat_i(WIDTH/2 - 1 DOWNTO WIDTH/4);
       else
          di1 <= ram(my_conv_integer(adr_i))(WIDTH/2 - 1 DOWNTO WIDTH/4);
       end if;

       if wre_i(2) = '1' then
          di2 <= dat_i(3*WIDTH/4 - 1 DOWNTO WIDTH/2);
       else
          di2 <= ram(my_conv_integer(adr_i))(3*WIDTH/4 - 1 DOWNTO WIDTH/2);
       end if;

       if wre_i(3) = '1' then
          di3 <= dat_i(WIDTH-1 DOWNTO 3*WIDTH/4);
       else
          di3 <= ram(my_conv_integer(adr_i))(WIDTH-1 DOWNTO 3*WIDTH/4);
       end if;
    end process;

    process(clk_i)
    begin
       if rising_edge(clk_i) then
          if (ena_i = '1') then
             ram(my_conv_integer(adr_i)) <= di3 & di2 & di1 & di0;
          end if;
          dat_o <= ram(my_conv_integer(adr_i));
       end if;
    end process;
END arch;