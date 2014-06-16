module AdderControl (
	input CLOCK_50
);

reg  signed [2:0] xi, yi;
wire signed [2:0] result;

reg reset;
reg clock;

online_adder_r4 add(
	.clk(clock),
	.reset(reset),
	.xi(xi),
	.yi(yi),
	.zi(result)
);

initial
	begin
		
		#100
		reset = 0;
		#100
		$display("Reset");
		reset = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		reset = 0;
		
		#100
		xi = 3'd1;
		yi = 3'd2;
		clock = 0;
		#100
		$display("Cycle -1");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi =  3'd2;
		yi = -3'd1;
		clock = 0;
		#100
		$display("Cycle 0");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = -3'd3;
		yi = -3'd3;
		clock = 0;
		#100
		$display("Cycle 1");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = 3'd3;
		yi = 3'd3;
		clock = 0;
		#100
		$display("Cycle 2");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = 3'd0;
		yi = 3'd2;
		clock = 0;
		#100
		$display("Cycle 3");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = -3'd1;
		yi =  3'd2;
		clock = 0;
		#100
		$display("Cycle 4");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = 3'd0;
		yi = 3'd0;
		clock = 0;
		#100
		$display("Cycle 5");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = 3'd0;
		yi = 3'd2;
		clock = 0;
		#100
		$display("Cycle 6");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
		xi = 3'd0;
		yi = 3'd0;
		clock = 0;
		#100
		$display("Cycle 7 - extra");
		clock = 1;
		#100
		$display("x=%d, y=%d, z=%d", xi, yi, result);
//		xi = 3'd0;
//		yi = 3'd2;
		clock = 0;
		#100
		
		$stop;
	end


endmodule
