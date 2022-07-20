module Mux16x1  #(
	parameter W = 4
) (
	input 	wire [W-1:0] 	In1,
	input 	wire [W-1:0] 	In2,
	input 	wire [W-1:0] 	In3,
	input 	wire [W-1:0] 	In4,
	input 	wire [W-1:0] 	In5,
	input 	wire [W-1:0] 	In6,
	input 	wire [W-1:0] 	In7,
	input 	wire [W-1:0] 	In8,
	input 	wire [W-1:0] 	In9,
	input 	wire [W-1:0] 	In10,
	input 	wire [W-1:0] 	In11,
	input 	wire [W-1:0] 	In12,
	input 	wire [W-1:0] 	In13,
	input 	wire [W-1:0] 	In14,
	input 	wire [W-1:0] 	In15,
	input 	wire [W-1:0] 	In16,
	input 	wire [3:0]		Sel,
	output 	wire [W-1:0]	Out
);

	wire [W-1:0] Out1;
	wire [W-1:0] Out2;
	wire [W-1:0] Out3;
	wire [W-1:0] Out4;
	
	Mux4x1 #(
		.W(W)	
	) Mux4x1_inst1 (
		.In1(In1),
		.In2(In2),
		.In3(In3),
		.In4(In4),
		.Sel(Sel[1:0]),
		.Out(Out1)
	);

	Mux4x1 #(
		.W(W)	
	) Mux4x1_inst2 (
		.In1(In5),
		.In2(In6),
		.In3(In7),
		.In4(In8),
		.Sel(Sel[1:0]),
		.Out(Out2)
	);

	Mux4x1 #(
		.W(W)	
	) Mux4x1_inst3 (
		.In1(In9),
		.In2(In10),
		.In3(In11),
		.In4(In12),
		.Sel(Sel[1:0]),
		.Out(Out3)
	);

	Mux4x1 #(
		.W(W)	
	) Mux4x1_inst4 (
		.In1(In13),
		.In2(In14),
		.In3(In15),
		.In4(In16),
		.Sel(Sel[1:0]),
		.Out(Out4)
	);

	Mux4x1 #(
		.W(W)	
	) Mux4x1_inst5 (
		.In1(Out1),
		.In2(Out2),
		.In3(Out3),
		.In4(Out4),
		.Sel(Sel[3:2]),
		.Out(Out)
	);

endmodule
