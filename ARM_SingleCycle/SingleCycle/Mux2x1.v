/*
 *		Module		:	Mux_Nx1
 * 	Description	: 	N x 1 Multiplexer
 *		Inputs		: 	In  [of N-bit]
 *
 *		Outputs		: 	Out [of 1-bit]
 */

module Mux2x1
#(
	parameter W = 4
)
(
	input 	wire [W-1:0] 	In1,
	input 	wire [W-1:0] 	In2,
	input 	wire  			Sel,
	output 	wire [W-1:0]	Out
);

	assign Out = (Sel) ? In2 : In1;

endmodule
