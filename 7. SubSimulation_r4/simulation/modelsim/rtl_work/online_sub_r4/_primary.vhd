library verilog;
use verilog.vl_types.all;
entity online_sub_r4 is
    generic(
        r               : integer := 4;
        a               : integer := 3
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        en              : in     vl_logic;
        xi              : in     vl_logic_vector(2 downto 0);
        yi              : in     vl_logic_vector(2 downto 0);
        zi              : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of r : constant is 1;
    attribute mti_svvh_generic_type of a : constant is 1;
end online_sub_r4;
