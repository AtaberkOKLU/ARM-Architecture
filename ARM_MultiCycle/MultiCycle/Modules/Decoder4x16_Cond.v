module Decoder4x16_Cond  (
	input 	wire [3:0] 	In,
	input 	wire 			Cond,
	output 	wire  [15:0]	Out
);

assign Out = {16{Cond}} & (1'b1 << In);

//always @ (*)
//	if (!Cond)
//		Out = {16{1'b0}};
//	else
//		case (In)
//			'd0:  Out = 16'b1;
//			'd1:  Out = 16'b10;
//			'd2:  Out = 16'b100;
//			'd3:  Out = 16'b1000;
//			'd4:  Out = 16'b10000;
//			'd5:  Out = 16'b100000;
//			'd6:  Out = 16'b1000000;
//			'd7:  Out = 16'b10000000;
//			'd8:  Out = 16'b100000000;
//			'd9:  Out = 16'b1000000000;
//			'd10: Out = 16'b10000000000;
//			'd11: Out = 16'b100000000000;
//			'd12: Out = 16'b1000000000000;
//			'd13: Out = 16'b10000000000000;
//			'd14: Out = 16'b100000000000000;
//			'd15: Out = 16'b1000000000000000;
//		endcase
	
endmodule 