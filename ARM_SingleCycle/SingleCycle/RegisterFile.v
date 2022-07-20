module RegisterFile  #(
	parameter W = 4
) (
	input 	wire [3:0] 		AD1,
	input 	wire [3:0] 		AD2,
	input 	wire [3:0] 		WAD,	// Write Address
	input 	wire [W-1:0] 	WDI,	// Write Data Input
	input 	wire 				WE,	// Write Enable
	input 	wire 				RESET_N,
	input 	wire 				CLK,
	input 	wire [W-1:0]	R15,
	output 	wire [W-1:0]	DO1,
	output 	wire [W-1:0]	DO2
);
	wire [15:0] 	Decoder_WE_Out;

	wire [W-1:0] 	Reg_RWE_1_Out; 
	wire 				Reg_RWE_1_WE;
	wire [W-1:0] 	Reg_RWE_2_Out; 
	wire 				Reg_RWE_2_WE;
	wire [W-1:0] 	Reg_RWE_3_Out; 
	wire 				Reg_RWE_3_WE;
	wire [W-1:0] 	Reg_RWE_4_Out; 
	wire 				Reg_RWE_4_WE;

	wire [W-1:0] 	Reg_RWE_5_Out; 
	wire 				Reg_RWE_5_WE;
	wire [W-1:0] 	Reg_RWE_6_Out; 
	wire 				Reg_RWE_6_WE;
	wire [W-1:0] 	Reg_RWE_7_Out; 
	wire 				Reg_RWE_7_WE;
	wire [W-1:0] 	Reg_RWE_8_Out; 
	wire 				Reg_RWE_8_WE;

	wire [W-1:0] 	Reg_RWE_9_Out; 
	wire 				Reg_RWE_9_WE;
	wire [W-1:0] 	Reg_RWE_10_Out; 
	wire 				Reg_RWE_10_WE;
	wire [W-1:0] 	Reg_RWE_11_Out; 
	wire 				Reg_RWE_11_WE;
	wire [W-1:0] 	Reg_RWE_12_Out; 
	wire 				Reg_RWE_12_WE;

	wire [W-1:0] 	Reg_RWE_13_Out; 
	wire 				Reg_RWE_13_WE;
	wire [W-1:0] 	Reg_RWE_14_Out; 
	wire 				Reg_RWE_14_WE;
	wire [W-1:0] 	Reg_RWE_15_Out; 
	wire 				Reg_RWE_15_WE;

// Write Enable Decoder
	Decoder4x16_Cond Decoder4x16_Cond_WE(
		.In(WAD),
		.Cond(WE),
		.Out(Decoder_WE_Out)
	);
	assign {Reg_RWE_15_WE, Reg_RWE_14_WE, Reg_RWE_13_WE, Reg_RWE_12_WE, Reg_RWE_11_WE, Reg_RWE_10_WE, Reg_RWE_9_WE, Reg_RWE_8_WE, Reg_RWE_7_WE, Reg_RWE_6_WE, Reg_RWE_5_WE, Reg_RWE_4_WE, Reg_RWE_3_WE, Reg_RWE_2_WE, Reg_RWE_1_WE} = Decoder_WE_Out[14:0];

// Registers
	Reg_RWE #(
		.W(W)
	) Reg_RWE_1 (
		.In(WDI),
		.WE(Reg_RWE_1_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_1_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_2 (
		.In(WDI),
		.WE(Reg_RWE_2_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_2_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_3 (
		.In(WDI),
		.WE(Reg_RWE_3_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_3_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_4 (
		.In(WDI),
		.WE(Reg_RWE_4_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_4_Out)
	);
	
	Reg_RWE #(
		.W(W)
	) Reg_RWE_5 (
		.In(WDI),
		.WE(Reg_RWE_5_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_5_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_6 (
		.In(WDI),
		.WE(Reg_RWE_6_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_6_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_7 (
		.In(WDI),
		.WE(Reg_RWE_7_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_7_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_8 (
		.In(WDI),
		.WE(Reg_RWE_8_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_8_Out)
	);
	
	Reg_RWE #(
		.W(W)
	) Reg_RWE_9 (
		.In(WDI),
		.WE(Reg_RWE_9_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_9_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_10 (
		.In(WDI),
		.WE(Reg_RWE_10_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_10_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_11 (
		.In(WDI),
		.WE(Reg_RWE_11_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_11_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_12 (
		.In(WDI),
		.WE(Reg_RWE_12_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_12_Out)
	);
	
	Reg_RWE #(
		.W(W)
	) Reg_RWE_13 (
		.In(WDI),
		.WE(Reg_RWE_13_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_13_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_14 (
		.In(WDI),
		.WE(Reg_RWE_14_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_14_Out)
	);

	Reg_RWE #(
		.W(W)
	) Reg_RWE_15 (
		.In(WDI),
		.WE(Reg_RWE_15_WE),
		.RESET_N(RESET_N),
		.CLK(CLK),
		.Out(Reg_RWE_15_Out)
	);

// Output Muxers
	Mux16x1 #(
		.W(W)	
	) Mux16x1_DO1 (
		.In1(Reg_RWE_1_Out),
		.In2(Reg_RWE_2_Out),
		.In3(Reg_RWE_3_Out),
		.In4(Reg_RWE_4_Out),
		.In5(Reg_RWE_5_Out),
		.In6(Reg_RWE_6_Out),
		.In7(Reg_RWE_7_Out),
		.In8(Reg_RWE_8_Out),
		.In9(Reg_RWE_9_Out),
		.In10(Reg_RWE_10_Out),
		.In11(Reg_RWE_11_Out),
		.In12(Reg_RWE_12_Out),
		.In13(Reg_RWE_13_Out),
		.In14(Reg_RWE_14_Out),
		.In15(Reg_RWE_15_Out),
		.In16(R15),
		.Sel(AD1),
		.Out(DO1)
	);

	Mux16x1 #(
		.W(W)	
	) Mux16x1_DO2 (
		.In1(Reg_RWE_1_Out),
		.In2(Reg_RWE_2_Out),
		.In3(Reg_RWE_3_Out),
		.In4(Reg_RWE_4_Out),
		.In5(Reg_RWE_5_Out),
		.In6(Reg_RWE_6_Out),
		.In7(Reg_RWE_7_Out),
		.In8(Reg_RWE_8_Out),
		.In9(Reg_RWE_9_Out),
		.In10(Reg_RWE_10_Out),
		.In11(Reg_RWE_11_Out),
		.In12(Reg_RWE_12_Out),
		.In13(Reg_RWE_13_Out),
		.In14(Reg_RWE_14_Out),
		.In15(Reg_RWE_15_Out),
		.In16(R15),
		.Sel(AD2),
		.Out(DO2)
	);

endmodule 