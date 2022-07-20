module BarrelShifter #(
	parameter WIDTH = 32
) (
	input wire [4:0] 				ShiftSize,
	input wire [WIDTH-1:0]		Number,
	output wire [WIDTH-1:0] 	Out
);

	wire [2*WIDTH-1:0] NumberDouble;
	assign NumberDouble = {Number, Number};
	assign Out = NumberDouble[ShiftSize+WIDTH-1-:WIDTH];


endmodule 