module AdderSimulation (
	input CLOCK_50
);

//===================================
//		Test parameters
//===================================
parameter n = 6;						// No. of digits
parameter c = 3;						// Bits per digit
parameter delay = 2;
parameter cycles = n + delay;
parameter numTests = 8;


//===================================
//		REG/WIRE declarations
//===================================
reg  adder_reset;						// Adder reset signal
reg  adder_enable;					// Adder enable signal
reg  adder_clock;						// Adder clock signal

// Test variables //
wire signed [c-1:0] zi;
reg  signed [c-1:0] xi, yi;
reg  signed [(n+delay)*c-1:0] result;

//wire signed [n*c-1:-delay*c] x, y;
wire signed [n*c-1:0] x, y;
wire signed [(n+1)*c-1:0] expected;

wire correct = (result[(n+1)*c-1:0] == expected);

reg [2:0] testNo;					// Parametrise size in Java
reg [3:0] i;						// Parametrise size in Java			// Current cycle in a test


//*********************************
// 	Adder UUT (Unit Under Test)
//*********************************
online_adder_r4 uut(
	.clk(adder_clock),
	.reset(adder_reset),
	.en(adder_enable),
	.xi(xi),
	.yi(yi),
	.zi(zi)
);

tester_r4 addTest(
	.testSelect(testNo),
	.x(x),
	.y(y),
	.z(expected)
);


//========================================
// 			Test process
//========================================
initial begin
	i = 0;
	xi = 0;
	yi = 0;
	testNo = 0;
	adder_reset = 0;
	adder_clock = 0;
	adder_enable = 0;
	
	// The outer loop switches between tests
	// The inner loop controls the flow of the current test
	
	repeat (numTests) begin
		// Reset the adder
		adder_reset = 1;
		#200
		adder_reset = 0;
		adder_enable = 1;
		
		$display("x = %d, y = %d", x, y);
		
		i = 0;
		repeat (cycles) begin
			adder_clock = 1;
			#100 
			
			if (i < n) begin
				xi = x[c*(n-i)-1-:c];					// Load the next x digit
				yi = y[c*(n-i)-1-:c];					// Load the next y digit
				end
			else begin
				xi = 0;
				yi = 0;
				end
			
			result[c*(n+1-i)+2-:c] = zi;			// Read the previous digit of the result
			
			i = i + 1'b1;
			adder_clock = 0;
			#100
			
			$display("xi = %d, yi = %d, zi = %d", xi, yi, zi);
		end
		
		$display("z = %d", result[(n+1)*c-1:0]);
		if (correct) $display("Correct\n");
		else			 $display("Error\n");
		
		adder_enable = 0;
		testNo = testNo + 1'b1;
	end
	
	// End simulation
	$stop;
end

endmodule
