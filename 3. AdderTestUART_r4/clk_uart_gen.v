module clk_uart_gen
	#(parameter period = 8680556)
(
	output reg clk
);

initial clk = 1'b0;

always
	#(period/2) clk = ~clk;

endmodule

