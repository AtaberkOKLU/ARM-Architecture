/*
 *		Module		:	Constant Value Generator
 * 	Description	: 	Generates n-bit v value
 *		Inputs		: 	*
 *						: 	*
 *						:	*
 *						:	*
 *						:	*
 *
 *		Outputs		: 	Constant V
 */

module ConstantValueGenerator
#(
	parameter WIDTH = 4,
	parameter VALUE = 1
)(
	output wire [WIDTH-1:0] Out
);

	assign Out = VALUE;


endmodule
