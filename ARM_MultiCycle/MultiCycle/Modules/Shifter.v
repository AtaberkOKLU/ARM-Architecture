module Shifter #(
	parameter WIDTH = 32
) (
	input wire [11:0] 		Shift,
	input wire signed  [WIDTH-1:0]	Number,
	input wire 					I,
	input wire 					En,
	output reg signed [WIDTH-1:0] 	Out
);	
	wire [WIDTH-1:0] LeftShifted;
	wire [WIDTH-1:0] RighthShifted;
	assign LeftShifted = Number << Shift[11:7];
	assign RighthShifted = Number >> Shift[11:7];

	always @ (*)
	if(En)
		if(I)
			Out = ({ {16{1'b0}} ,{Shift[7:0], Shift[7:0]} >> (8-Shift[11:8])}) & 32'h000000FF;
		
		else
			case(Shift[6:5])
				2'b00:
						begin
							Out = LeftShifted;
						end
				2'b01:
						begin
							Out = RighthShifted;
						end
				2'b10:
						begin
							Out = Number >>> Shift[11:7];
						end
				2'b11:
						begin
							Out = (Number << (WIDTH-Shift[11:7])) | RighthShifted;	// Rotate Right
//							Out = (LeftShifted) | (Number >> (WIDTH-Shift[11:7]));	// Rotate left
						end
			endcase		
	else
		Out = Number;
		
endmodule
