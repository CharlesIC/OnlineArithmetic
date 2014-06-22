module SEG7_LUT	(oSEG,oSEG_DP,iDIG	);
input	[5:0]	iDIG;
output	[6:0]	oSEG;
output			oSEG_DP;

reg		[6:0]	oSEG;
reg				oSEG_DP;

always @(iDIG)
begin
		case(iDIG)
		6'h1:  oSEG = 7'b1111001; 		// ---t----
		6'h2:  oSEG = 7'b0100100; 		// |	  |
		6'h3:  oSEG = 7'b0110000; 		// lt	 rt
		6'h4:  oSEG = 7'b0011001; 		// |	  |
		6'h5:  oSEG = 7'b0010010; 		// ---m----
		6'h6:  oSEG = 7'b0000010; 		// |	  |
		6'h7:  oSEG = 7'b1111000; 		// lb	 rb
		6'h8:  oSEG = 7'b0000000; 		// |	  |
		6'h9:  oSEG = 7'b0011000; 		// ---b----
		6'ha:  oSEG = 7'b0001000;
		6'hb:  oSEG = 7'b0000011;
		6'hc:  oSEG = 7'b1000110;
		6'hd:  oSEG = 7'b0100001;
		6'he:  oSEG = 7'b0000110;
		6'hf:  oSEG = 7'b0001110;
		6'h0:  oSEG = 7'b1000000;
		6'h2f: oSEG = 7'b0101111;		// 'r'
		6'h7f: oSEG = 7'b1111111;		// turn segment off
		default: oSEG = 7'b1000000;
		endcase
end

always @(iDIG)
begin
		case(iDIG)
		4'h1: oSEG_DP = 1'b0;
		4'h2: oSEG_DP = 1'b1;
		4'h3: oSEG_DP = 1'b0;
		4'h4: oSEG_DP = 1'b1;
		4'h5: oSEG_DP = 1'b0;
		4'h6: oSEG_DP = 1'b1;
		4'h7: oSEG_DP = 1'b0;
		4'h8: oSEG_DP = 1'b1;
		4'h9: oSEG_DP = 1'b0;
		4'ha: oSEG_DP = 1'b1;
		4'hb: oSEG_DP = 1'b0;
		4'hc: oSEG_DP = 1'b1;
		4'hd: oSEG_DP = 1'b0;
		4'he: oSEG_DP = 1'b1;
		4'hf: oSEG_DP = 1'b0;
		4'h0: oSEG_DP = 1'b1;
		endcase
end
endmodule
