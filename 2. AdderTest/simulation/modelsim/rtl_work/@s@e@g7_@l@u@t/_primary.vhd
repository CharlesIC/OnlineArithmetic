library verilog;
use verilog.vl_types.all;
entity SEG7_LUT is
    port(
        oSEG            : out    vl_logic_vector(6 downto 0);
        oSEG_DP         : out    vl_logic;
        iDIG            : in     vl_logic_vector(5 downto 0)
    );
end SEG7_LUT;
