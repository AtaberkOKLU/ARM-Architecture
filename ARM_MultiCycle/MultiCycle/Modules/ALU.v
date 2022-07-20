module ALU  #(
	parameter W = 4
)(
	input 	wire [W-1:0] 	In1,
	input 	wire [W-1:0] 	In2,
	input		wire [2:0]		OpSel, 
	output 	wire [W-1:0] 	Out,
	output 	wire [3:0]		Status // (N, Z, CO, OVF)
);

	// Signals
	wire needComp;
	wire [W-1:0] OutSrcLog;
	wire [W-1:0] FA_Out;
	wire [W-1:0] FAMOV;
	wire Cout, CO, OVF, Z, N; 			// Status Bits


	// Assignments
	assign needComp =  ~OpSel[2] & ~OpSel[1] & OpSel[0];
	
	assign CO   = Cout & ( ~OpSel[2] );
	assign OVF 	= (N&~In1[W-1]&~In2[W-1]) || ((~N)&In1[W-1]&In2[W-1]) & (~OpSel[2]);
	assign Z  	= ~|Out;
	assign N 	= Out[W-1];
	assign Status 	= {N, Z, CO, OVF};
	

	FullAdder_O  #(
		.W(W)
	) FullAdder_O_0 (
		.A(In1),
		.B(In2 ^ {W{needComp}}),
		.Cin(needComp),
		.Cout(Cout),
		.Out(FA_Out)
	);
	
	Mux2x1 #( 
		.W(W)
	) Mux2x1_FAMOV (
		.In1(FA_Out), 
		.In2(In2), 
		.Sel(OpSel[1]),
		.Out(FAMOV)
	);

	
	Mux4x1 #( 
		.W(W)
	) Mux4x1_LogOp (
		.In1(In1&In2), 
		.In2(In1|In2), 
		.In3(In1^In2),
		.In4({W{1'b0}}),
		.Sel(OpSel[1:0]),
		.Out(OutSrcLog)
	);

	Mux2x1 #( 
		.W(W)
	) Mux2x1_SelOut (
		.In1(FAMOV), 
		.In2(OutSrcLog), 
		.Sel(OpSel[2]),
		.Out(Out)
	);

endmodule