library verilog;
use verilog.vl_types.all;
entity AdderControl is
    generic(
        n               : integer := 6;
        c               : integer := 3;
        delay           : integer := 2;
        bits            : vl_notype;
        cycles          : vl_notype
    );
    port(
        CLOCK_50        : in     vl_logic;
        ORG_BUTTON      : in     vl_logic_vector(2 downto 0);
        HEX0_D          : out    vl_logic_vector(6 downto 0);
        HEX0_DP         : out    vl_logic;
        HEX1_D          : out    vl_logic_vector(6 downto 0);
        HEX1_DP         : out    vl_logic;
        HEX2_D          : out    vl_logic_vector(6 downto 0);
        HEX2_DP         : out    vl_logic;
        HEX3_D          : out    vl_logic_vector(6 downto 0);
        HEX3_DP         : out    vl_logic;
        LEDG            : out    vl_logic_vector(9 downto 0);
        SW              : in     vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
    attribute mti_svvh_generic_type of c : constant is 1;
    attribute mti_svvh_generic_type of delay : constant is 1;
    attribute mti_svvh_generic_type of bits : constant is 3;
    attribute mti_svvh_generic_type of cycles : constant is 3;
end AdderControl;
