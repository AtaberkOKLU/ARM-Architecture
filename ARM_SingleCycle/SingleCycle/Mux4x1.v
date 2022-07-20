module Mux4x1  #(
	parameter W = 4
) (
	input 	wire [W-1:0] 	In1,
	input 	wire [W-1:0] 	In2,
	input 	wire [W-1:0] 	In3,
	input 	wire [W-1:0] 	In4,
	input 	wire [1:0]		Sel,
	output 	wire [W-1:0]	Out
);
	
	wire 	[W-1:0] temp1;
	wire 	[W-1:0] temp2;
	
	assign temp1	= Sel[0] ? In4 : In3;
	assign temp2	= Sel[0] ? In2 : In1;
	
	assign Out 		= Sel[1] ?  temp1 : temp2;

//always @ (*)
//	begin
//		case (Sel)
//			2'b00 : Out <= In1;
//			2'b01 : Out <= In2;
//			2'b10 : Out <= In3;
//			2'b11 : Out <= In4;
//		endcase
//	end

endmodule
