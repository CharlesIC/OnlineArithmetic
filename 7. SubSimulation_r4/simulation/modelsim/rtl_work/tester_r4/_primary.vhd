library verilog;
use verilog.vl_types.all;
entity tester_r4 is
    generic(
        n               : integer := 6;
        c               : integer := 3
    );
    port(
        testSelect      : in     vl_logic_vector(3 downto 0);
        x               : out    vl_logic_vector;
        y               : out    vl_logic_vector;
        z               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
    attribute mti_svvh_generic_type of c : constant is 1;
end tester_r4;
