module online_adder_r4 (
		input  clk, reset, en,				// asynchronous reset to clear all latches; enable signal
		input      signed [2:0] xi,		// (i+2)th digit of the x input
		input      signed [2:0] yi,		// (i+2)th digit of the y input
		output reg signed [2:0] zi			// ith digit of the result
);

parameter r = 4;
parameter a = 3;

reg [2:0] t;								// transfer digit for the previous cycle
reg signed [2:0] w;						// intermediate sum for the current cycle

always @(posedge clk, posedge reset)
	begin
		if (reset)
			begin
				t = 0;
				w = 0;
				zi = 0;
			end
		else if (en)
			begin
				TW(xi, yi, t, w);
				SUM(t, w, zi);
				//zi <= add(t, w);
			end
	end


task TW;										// calculates the transfer digit and intermediate sum
	input  signed [2:0] x, y;
	output signed [2:0] t, w;
	reg 	 signed [3:0] temp;
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

task SUM;
	input  signed [2:0] t, w;
	output signed [2:0] zi;
begin
	zi <= t + w;
end
endtask

function signed [2:0] add;
	input signed [2:0] t, w;
begin
	add = t + w;
end
endfunction

endmodule

