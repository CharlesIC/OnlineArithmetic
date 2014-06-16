library verilog;
use verilog.vl_types.all;
entity button_debouncer is
    generic(
        preset_val      : integer := 0;
        counter_max     : integer := 100000
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_in         : in     vl_logic;
        data_out        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of preset_val : constant is 1;
    attribute mti_svvh_generic_type of counter_max : constant is 1;
end button_debouncer;
