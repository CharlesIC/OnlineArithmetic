module tester_r4
	#(parameter n = 6, parameter c = 3)
(
	input  [9:0] testSelect,
	output reg [n*c-1:0] x,			// First number to add
	output reg [n*c-1:0] y,			// Second number to add
	output reg [(n+1)*c-1:0] z				// Correct result
);

//parameter n = 6;						// No. of digits
//parameter c = 3;						// Bits per digit

always @(testSelect)
	case (testSelect)
		10'b0000000000:
			begin
				x = 0;
				y = 0;
				z = 0;
			end
			
		10'b0000000001:
			begin
				x = {3'd1, 3'd2, -3'd3, 3'd3, 3'd0, -3'd1};
				y = {3'd2, -3'd1, -3'd3, 3'd3, 3'd2, 3'd2};
				z = {3'd0, 3'd0, -3'd1, 3'd0, 3'd0, -3'd3, 3'd1};
			end
			
		10'b0000000010:
			begin
				x = {3'd0, 3'd0, 3'd0, 3'd1, 3'd2, -3'd2};
				y = {3'd0, 3'd0, 3'd0, 3'd1, -3'd1, 3'd3};
				z = {3'd0, 3'd0, 3'd0, 3'd0, 3'd1, -3'd2, -3'd1};
			end
			
			10'b0000000100:
			begin
				x = {6{3'd1}};
				y = {6{3'd1}};
				z = {3'd0, {6{3'd0}}};
			end
			
			10'b00000001000:
			begin
				x = {6{3'd2}};
				y = {6{3'd1}};
				z = {3'd0, {6{3'd1}}};
			end
			
			10'b0000010000:
			begin
				x = {6{3'd2}};
				y = {6{3'd2}};
				z = {{6{3'd0}}, 3'd0};
			end
			
			10'b0000100000:
			begin
				x = {6{3'd3}};
				y = {6{3'd3}};
				z = {3'd0, {6{3'd0}}};
			end
				
			10'b0001000000:
			begin
				x = {6{-3'd1}};
				y = {-3'd2, -3'd3, -3'd3, -3'd1, 3'd0, 3'd2};
				z = {3'd0, 3'd1, 3'd2, 3'd2, 3'd0, -3'd2, 3'd1};
			end
			
			10'b0010000000:
			begin
				x =       {3'd0, 3'd0, 3'd0, 3'd2, 3'd2, 3'd3};
				y =       {3'd0, 3'd0, 3'd0, 3'd1, 3'd1, 3'd2};
				z = {3'd0, 3'd0, 3'd0, 3'd0, 3'd1, 3'd1, 3'd1};
			end
				
		default:
			begin
				x = 0;
				y = 0;
				z = 0;
			end
	endcase

endmodule

