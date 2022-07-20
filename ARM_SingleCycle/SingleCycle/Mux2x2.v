module Mux2x2  #(
	parameter W = 4
) (
	input 	wire [W-1:0] 	In1,
	input 	wire [W-1:0] 	In2,
	input 	wire  			Sel,
	output 	wire [W-1:0]	Out1,
	output 	wire [W-1:0]	Out2
);

	assign Out1 = (Sel) ? In2 : In1;
	assign Out2 = (Sel) ? In1 : In2;

endmodule