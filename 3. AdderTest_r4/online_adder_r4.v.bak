module online_adder_r4 (
		input  clk, reset, en,		// asynchronous reset to clear all latches; enable signal
		input      signed [2:0] xi,			// (i+2)th digit of the x input
		input      signed [2:0] yi,			// (i+2)th digit of the y input
		output reg signed [2:0] zi			// ith digit of the result
);

parameter r = 4;
parameter a = 3;

reg [2:0] t;								// transfer digit for the previous cycle
//wire signed [2:0] w_hold_net;
//wire signed [2:0] z_hold_net;

reg signed [2:0] w_hold;				// intermediate sum for the current cycle
reg signed [2:0] z_hold;				// previous digit
reg signed [3:0] temp;

reg signed [2:0] w_temp;

always @(posedge clk, posedge reset)
	begin
		if (reset)
			begin
				w_hold = 4'd0;
				z_hold = 4'd0;
				temp   = 4'd0;
				w_temp = 4'd0;
				t = 0;
				zi = 0;
			end
		else if (en)
			begin
				TW(xi, yi, t, w_hold);
				//w_hold <= w_temp;
				
				
//				//add(t, w_hold, z_hold_net);
//				//z_hold <= z_hold_net;
//				//z_hold <= add(t, w_hold);

				zi <= add(t, w_hold);
				
//				//zi <= z_hold;
			end
	end


task TW;										// calculates the transfer digit and intermediate sum
	input  signed [2:0] x, y;
	output signed [2:0] t, w;
	//reg 	 signed [3:0] temp;
begin
	temp = x + y;
	if (temp >= a)
		begin
			t = 4'd1;
			temp = (temp - r);
		end
	else if (temp <= -a)
		begin
			t = -4'd1;
			temp = temp + r;
		end
	else
			t = 4'd0;
	w <= temp[2:0];
end
endtask

function signed [2:0] add;
	input signed [2:0] t, w;
begin
	add = t + w;
end
endfunction

endmodule

