library verilog;
use verilog.vl_types.all;
entity SubSimulation is
    generic(
        n               : integer := 6;
        c               : integer := 3;
        delay           : integer := 2;
        cycles          : vl_notype;
        numTests        : integer := 9
    );
    port(
        CLOCK_50        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
    attribute mti_svvh_generic_type of c : constant is 1;
    attribute mti_svvh_generic_type of delay : constant is 1;
    attribute mti_svvh_generic_type of cycles : constant is 3;
    attribute mti_svvh_generic_type of numTests : constant is 1;
end SubSimulation;
