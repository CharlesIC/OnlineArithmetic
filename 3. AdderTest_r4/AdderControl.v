module AdderControl
	(
		// Clock input //
		input CLOCK_50,				// 50 MHz
		
		// Push buttons //
		input [2:0] ORG_BUTTON,	// Pushbutton[2:0]
		
		// 7-SEG Display //
		output [6:0] HEX0_D,			// Seven Segment Digit 0
		output reg	 HEX0_DP,		// Seven Segment Digit DP 0
		output [6:0] HEX1_D,			// Seven Segment Digit 1
		output reg   HEX1_DP,		// Seven Segment Digit DP 1
		output [6:0] HEX2_D,			// Seven Segment Digit 2
		output reg	 HEX2_DP,		// Seven Segment Digit DP 2
		output [6:0] HEX3_D,			// Seven Segment Digit 3
		output reg	 HEX3_DP,		// Seven Segment Digit DP 3
		
		// LED //
		output reg [9:0] LEDG,				// LED Green[9:0]
		
		// Switches //
		input [9:0] SW							// Toggle Switch[9:0]
	);


//===================================
//		Test parameters
//===================================
parameter n = 6;						// No. of digits
parameter c = 3;						// Bits per digit
parameter delay = 2;
parameter bits = n * c;
parameter cycles = n + delay;	


//===================================
//		REG/WIRE declarations
//===================================
wire BUTTON[2:0];						// Button after debounce
reg  out_BUTTON_1;					// Button1 register output
reg  out_BUTTON_2;					// Button2 register output

wire counter_1 = ((BUTTON[1] == 0) && (out_BUTTON_1 == 1)) ?1:0;			// Counter for Button[1]
wire counter_2 = ((BUTTON[2] == 0) && (out_BUTTON_2 == 1)) ?1:0;			// Counter for Button[2]

wire clock = CLOCK_50;				// Clock signal
wire reset = BUTTON[0];				// Reset signal
reg  adder_reset;						// Adder reset signal
reg  adder_enable;						// Adder clock signal

reg [5:0] iDIG_0;						// 7 Seg Digit 0
reg [5:0] iDIG_1;						// 7 Seg Digit 1
reg [5:0] iDIG_2;						// 7 Seg Digit 2
reg [5:0] iDIG_3;						// 7 Seg Digit 3

// Variables to display the result //
reg  [4:0] section;					// 4-digit section of the result currently being displayed
wire [9:0] shift = section * (c*4);	// The number of bits already displayed

// Test variables //
wire signed [c-1:0] zi;
reg  signed [c-1:0] xi, yi;
reg  signed [(n+1)*c-1:0] result;

wire signed [n*c-1:0] x, y;
wire signed [(n+1)*c-1:0] expected;

wire correct = (result == expected);


//===================================
//		Structural Coding
//===================================
//*********************************
// 	Button debounce circuits
//*********************************
// Button[0] Debounce Circuit //
button_debouncer button_0 (
	.clk		 (CLOCK_50),
	.rst_n	 (1'b1),
	.data_in  (ORG_BUTTON[0]),
	.data_out (BUTTON[0])
);

// Button[1] Debounce Circuit //
button_debouncer button_1 (
	.clk		 (CLOCK_50),
	.rst_n	 (1'b1),
	.data_in	 (ORG_BUTTON[1]),
	.data_out (BUTTON[1])
);

// Button[2] Debounce Circuit //
button_debouncer button_2 (
	.clk		 (CLOCK_50),
	.rst_n	 (1'b1),
	.data_in	 (ORG_BUTTON[2]),
	.data_out (BUTTON[2])
);

//*********************************
// 	7 Segment Display
//*********************************
// SEG0 Display //
SEG7_LUT SEG0(
	.oSEG		(HEX0_D),
	.oSEG_DP(),
	.iDIG		(iDIG_0)
);

// SEG1 Display //
SEG7_LUT SEG1(
	.oSEG		(HEX1_D),
	.oSEG_DP(),
	.iDIG		(iDIG_1)
);

// SEG2 Display //
SEG7_LUT SEG2(
	.oSEG		(HEX2_D),
	.oSEG_DP(),
	.iDIG		(iDIG_2)
);

// SEG3 Display //
SEG7_LUT SEG3(
	.oSEG		(HEX3_D),
	.oSEG_DP(),
	.iDIG		(iDIG_3)
);


//*********************************
// 	Adder UUT (Unit Under Test)
//*********************************
online_adder_r4 uut(
	.clk(~clock),
	.reset(adder_reset),
	.en(adder_enable),
	.xi(xi),
	.yi(yi),
	.zi(zi)
);

tester_r4 addTest(
	.testSelect(SW),
	.x(x),
	.y(y),
	.z(expected)
);


//========================================
// After debounce output with register
//========================================
always @ (posedge clock)
	begin
		out_BUTTON_1 <= BUTTON[1];
		out_BUTTON_2 <= BUTTON[2];
		
		// Display a dot if digit is negative
		HEX0_DP <= ~result[shift+c-1];
		HEX1_DP <= ~result[shift+2*c-1];
		HEX2_DP <= ~result[shift+3*c-1];
		HEX3_DP <= ~result[shift+4*c-1];
	end


//========================================
// 			Display process
//========================================
always @ (posedge clock or negedge reset)
begin
	if (!reset)
		begin
			// Reset LEDs to show first 4 digits
			section = 0;
			LEDG = 0;
		end
	else
		begin
			if (counter_1)
				if (shift + (c*4) >= bits)
					begin
						// Reset LEDs to show first 4 digits
						section = 0;
						LEDG = 0;
					end
				else
					section = section + 1'd1;
			else if (!BUTTON[2])
				begin
					if (correct)
						begin
							// Display "Corr" for "Correct"
							iDIG_3 = 6'hC;			// 'C'
							iDIG_2 = 6'h0;			// '0'
							iDIG_1 = 6'h2F;		// 'r'
							iDIG_0 = 6'h2F;		// 'r'
						end
					else
						begin
							// Display "Err" for "Error"
							iDIG_3 = 6'hE;			// 'E'
							iDIG_2 = 6'h2F;		// 'r'
							iDIG_1 = 6'h2F;		// 'r'
							iDIG_0 = 6'h7F;		// segment off
						end
				end
			else
				begin
					LEDG[section] = 1;
													// Parametrise 3'b000 in Java
					if (~HEX0_DP) begin
						iDIG_0 <= {3'b000, -result[shift+:c]};
						end
					else begin
						iDIG_0 <=  result[shift+:c];
						end
						
					if (~HEX1_DP) begin
						iDIG_1 <= {3'b000, -result[shift+c+:c]};
						end
					else begin
						iDIG_1 <=  result[shift+c+:c];
						end
						
					if (~HEX2_DP) begin
						iDIG_2 <= {3'b000, -result[shift+2*c+:c]};
						end
					else begin
						iDIG_2 <=  result[shift+2*c+:c];
						end
						
					if (~HEX3_DP) begin
						iDIG_3 <= {3'b000, -result[shift+3*c+:c]};
						end
					else begin
						iDIG_3 <=  result[shift+3*c+:c];
						end
				end
		end
end

		
//========================================
// 			Test process
//========================================
reg [9:0] oldTest;
reg [3:0] i;							// Parametrise size in Java +1
reg ready;

initial begin
	i = 0;
	xi = 0;
	yi = 0;
	ready = 1;
	oldTest = 0;
	adder_reset = 0;
	adder_enable = 0;
end

always @(posedge clock)
begin
	if (oldTest != SW || !ready) begin
		if (ready) begin
			adder_enable = 0;
			adder_reset = 1;
			oldTest = SW;
			result = 0;
			ready = 0;
			i <= 0;
			end
		else begin
			adder_reset = 0;
			adder_enable = 0;
//			xi <= x[c*(n-i)-1];
//			yi <= y[c*(n-i)-1];
//			adder_enable <= 1;
			ready = 1;
			end
		end
	else begin
		if (i < cycles) begin
			xi = x[c*(n-i)-1-:c];
			yi = y[c*(n-i)-1-:c];
			adder_enable <= 1;
			result[c*(n+1-i)+2-:c] = zi;
			i <= i + 1'b1;
			end
		else begin
			adder_enable <= 0;
			end
	end
end

//always @(posedge clock)
//begin
//// Reset adder
//	if (i == 5) begin
//		adder_enable = 0;
//		adder_reset = 0;
//		i <= 6;
//		end
//	else if (i == 6) begin
//		adder_reset = 1;
//		i <= 7;
//		end
//	else if (i == 7) begin
//		adder_reset = 0;
//		xi <= x[8:6];
//		yi <= y[8:6];
//		adder_enable <= 1;
//		i <= 0;
//		end
//	else if (i == 0) begin
//		xi <= x[5:3];
//		yi <= y[5:3];
//		//adder_clock = 1;
//		result[14:12] <= zi;
//		$display("zi = %d", zi);
//		i <= 1;
//		end
//	else if (i == 1) begin
//		xi <= x[2:0];
//		yi <= y[2:0];
//		//adder_clock = 1;
//		result[11:9] <= zi;
//		$display("zi = %d", zi);
//		i <= 2;
//		end
//	else if (i == 2) begin
//		xi <= 0;
//		yi <= 0;
//		//adder_clock = 1;
//		result[8:6] <= zi;
//		$display("zi = %d", zi);
//		i <= 3;
//		end
//	else if (i == 3) begin
//		xi <= 0;
//		yi <= 0;
//		//adder_clock = 1;
//		result[5:3] <= zi;
//		$display("zi = %d", zi);
//		i <= 4;
//		end
//	else if (i == 4) begin
//		//adder_clock = 1;
//		result[2:0] <= zi;
//		$display("zi = %d", zi);
//		i <= 5;
//		adder_enable <= 0;
//		$stop;
//		end
//end

endmodule
