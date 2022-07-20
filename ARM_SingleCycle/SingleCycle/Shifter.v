module Shifter #(
	parameter WIDTH = 32
) (
	input wire [7:0] 			Shift,
	input wire [WIDTH-1:0]	Number,
	output wire [WIDTH-1:0] Out
);

	assign Out = (~Shift[1]) ? Number << Shift[7:2] : Number >> Shift[7:2];

endmodule
