module SingleCycleController (
	input 	wire [3:0] 	Rd,
	input 	wire [1:0] 	Op,
	input 	wire [5:0] 	Func,
	input 	wire [3:0]	Cond,
	input 	wire [3:0]	ALUFlags,
	input 	wire 			CLK,
	output 	wire 			PCSrc,
	output 	wire 			RegWrite,
	output 	wire 			MemWrite,
	output 	wire 			Mem2Reg,
	output 	wire 			ALUSrc,
	output 	wire [1:0]	ImmSrc,
	output 	wire [1:0]	RegSrc,
	output 	wire [1:0]	ALUControl,
	output 	wire 			MemSrc
	
);

// Status Registers
reg [3:0] Status; // (N, Z, C, V)
wire [1:0] FlagWrite;
reg CondEx;
wire [1:0] FlagW;
wire RegW, MemW, PCS;
wire N, Z, C, V, NoWrite;

assign {N, Z, C, V} = Status;

assign FlagWrite[1] = FlagW[1] & CondEx;
assign FlagWrite[0] = FlagW[0] & CondEx;
assign RegWrite = RegW & CondEx & (!NoWrite);
assign MemWrite = MemW & CondEx;
assign PCSrc = PCS & CondEx;

 
SingleCycleDecoder SingleCycleDecoder_inst0(
	.Rd(Rd),
	.Op(Op),
	.Func(Func),
	.RegSrc(RegSrc),
	.PCS(PCS),
	.RegW(RegW),
	.MemW(MemW),
	.FlagW(FlagW),
	.ALUSrc(ALUSrc),
	.ImmSrc(ImmSrc),
	.Mem2Reg(Mem2Reg),
	.ALUControl(ALUControl),
	.MemSrc(MemSrc),
	.NoWrite(NoWrite)
);

always @(posedge(CLK))
	begin
		if (FlagWrite[1])
			Status[3:2] <= ALUFlags[3:2];
		
		if (FlagWrite[0])
			Status[1:0] <= ALUFlags[1:0];
	end
		
always @(Cond, N, Z, C, V)
	case(Cond)
		4'b0000:
			CondEx = Z;
		4'b0001:
			CondEx = !Z;
		4'b0010:
			CondEx = C;
		4'b0011:
			CondEx = !C;
		4'b0100:
			CondEx = N;
		4'b0101:
			CondEx = !N;
		4'b0110:
			CondEx = V;
		4'b0111:
			CondEx = !V;
		4'b1000:
			CondEx = !Z & C;
		4'b1001:
			CondEx = Z | !C;
		4'b1010:
			CondEx = !(N^V);
		4'b1011:
			CondEx = N^V;
		4'b1100:
			CondEx = !Z & !(N^V);
		4'b1101:
			CondEx = Z | (N^V);
		4'b1110:
			CondEx = 1;
		4'b1111:
			CondEx = 0;
	endcase
	
endmodule 