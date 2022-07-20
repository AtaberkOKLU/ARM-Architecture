module FullAdder_O  #(
	parameter W = 4
) (
	input 	wire [W-1:0] 	A, B,
	input 	wire 				Cin,
	output 	wire [W-1:0] 	Out,
	output 	wire 				Cout
);

	assign {Cout, Out} = A + B + Cin;
endmodule 
