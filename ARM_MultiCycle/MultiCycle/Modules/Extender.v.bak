module Extender #(
	parameter WIDTH = 32
) (
	input wire [1:0] 			Mode,
	input wire [23:0]			Number,
	output reg [WIDTH-1:0] 	Extended
);

	always @*
		case (Mode)
		 2'b00:
			Extended[WIDTH-1:0] = { {(WIDTH-8){Number[7]}}, Number[7:0] };
		 2'b01:
			Extended[WIDTH-1:0] = { {(WIDTH-12){Number[11]}}, Number[11:0] };
		 2'b10:
			Extended[WIDTH-1:0] = { {(WIDTH-26){Number[23]}}, Number[23:0], 2'b00 };
		 2'b11:
			Extended[WIDTH-1:0] = {(WIDTH){1'b0}};
		endcase

endmodule
