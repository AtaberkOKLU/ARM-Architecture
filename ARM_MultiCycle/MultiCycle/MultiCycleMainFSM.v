module MultiCycleMainFSM (
	input 	wire [1:0] 	Op,
	input 	wire [5:0] 	Func,
	input 	wire [3:0] 	Rd,
	input 	wire 			CLK,
	input 	wire 			RESET_N,
	
	output 	reg 			NoWrite,
	output 	reg  [1:0]	FlagW,
	output 	wire 			PCS,
	output 	reg 			NextPC,
	output 	reg  			RegW,
	output 	reg  			MemW,
	
	output 	reg  			IRWrite,
	output 	reg  			AdrSrc,
	output 	reg  [1:0]	ResultSrc,
	output 	reg  			ALUSrcA,
	output 	reg  [1:0]	ALUSrcB,
	output 	wire [1:0]	ImmSrc,
	output 	wire [1:0]	RegSrc,
	output 	reg  [2:0]	ALUControl,
	output 	reg 			BL_Active,
	output 	wire 			Shifter_En,
	output 	wire [3:0]	State
);

	localparam S0_Fetch 		= 4'd0;	// Fetch
	localparam S1_Decode 	= 4'd1;	// Decode
	localparam S2_MemAdr 	= 4'd2;	// MemAdr
	localparam S3_MemRead 	= 4'd3;	// MemRead
	localparam S4_MemWB 		= 4'd4;	// Mem WB
	localparam S5_MemWrite 	= 4'd5;	// MemWrite
	localparam S6_ExecuteR 	= 4'd6;	// ExecuteR
	localparam S7_ExecuteI 	= 4'd7;	// ExecuteI
	localparam S8_ALUWB 		= 4'd8;	// ALU WB
	localparam S9_Branch 	= 4'd9;	// Branch
	localparam S10_BranchLink 	= 4'd10;	// BranchLink

	reg [3:0] state;
	assign State = state;

	initial state = S0_Fetch;
	reg ALUOp;
	reg Branch;

	// Next State Generator
	always @ (posedge CLK or negedge RESET_N)
		if (!RESET_N)
			state <= S0_Fetch;
		else
		case(state)
			S0_Fetch:
				state <= S1_Decode;
			S1_Decode:
				case(Op)
					2'b00:	// DP
						if(Func[5])	// I
							state <= S7_ExecuteI;
						else
							state <= S6_ExecuteR;
						
					2'b01:	// Mem
						state <= S2_MemAdr;
					2'b10:	// B
						if(Func[4])
							state <= S10_BranchLink;
						else
							state <= S9_Branch;
					2'b11:
						state <= S0_Fetch;
				endcase
			S2_MemAdr:
				if(Func[0]) // LDR
					state <= S3_MemRead;
				else
					state <= S5_MemWrite;
			
			S3_MemRead:
				state <= S4_MemWB;
			
			S4_MemWB:
				state <= S0_Fetch;
			
			S5_MemWrite:
				state <= S0_Fetch;
			
			S6_ExecuteR:
				state <= S8_ALUWB;
			
			S7_ExecuteI:
				state <= S8_ALUWB;
			
			S8_ALUWB:
				state <= S0_Fetch;
			
			S9_Branch:
				state <= S0_Fetch;
				
			S10_BranchLink:
				state <= S0_Fetch;
				
			default:
				state <= S0_Fetch;
			
		endcase

	// Output Generator 
	always @(state)
		case(state)
			S0_Fetch:
				begin
				AdrSrc 		= 1'b0;
				ALUSrcA		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b10;
				IRWrite		= 1'b1;
				NextPC		= 1'b1;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
				
			S1_Decode:
				begin
				AdrSrc 		= 1'b0;
				ALUSrcA		= 1'b1;
				ALUSrcB		= 2'b10;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b10;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
				
			S2_MemAdr:
				begin
				AdrSrc 		= 1'b0;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b10;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
			
			S3_MemRead:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b00;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
			
			S4_MemWB:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b01;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b1;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
			
			S5_MemWrite:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b00;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b1;
				BL_Active	= 1'b0;
				end
			
			S6_ExecuteR:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b00;
				ALUOp			= 1'b1;
				ResultSrc	= 2'b00;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
			
			S7_ExecuteI:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b1;
				ResultSrc	= 2'b00;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
			
			S8_ALUWB:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b00;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b1;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
				
			S9_Branch:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b10;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b1;
				RegW			= 1'b0;	// B
				MemW			= 1'b0;
				BL_Active	= 1'b0;	// B
				end
				
			S10_BranchLink:
				begin
				AdrSrc 		= 1'b1;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b01;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b10;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b1;
				RegW			= 1'b1;	// BL
				MemW			= 1'b0;
				BL_Active	= 1'b1;	// BL
				end
				
			default:
				begin
				AdrSrc 		= 1'b0;
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b00;
				ALUOp			= 1'b0;
				ResultSrc	= 2'b00;
				IRWrite		= 1'b0;
				NextPC		= 1'b0;
				Branch 		= 1'b0;
				RegW			= 1'b0;
				MemW			= 1'b0;
				BL_Active	= 1'b0;
				end
			
		endcase
		
	
	// Instruction Decoder | ( (Op[1:0] == 2'b00) & (Func[4:1] == 4'b1101) )
	assign RegSrc[1] = (Op[1:0] == 2'b01);
	assign RegSrc[0] = (Op[1:0] == 2'b10);
	assign Shifter_En = (Op[1:0] == 2'b00) & (state == S7_ExecuteI | state == S6_ExecuteR);	// OpCode: DP
	assign ImmSrc = Op;
	
	// PC Logic
	assign PCS = ((Rd == 15) & RegW) | Branch;

	// ALU Decoder
	always @(Func[4:1], ALUOp)
	if(ALUOp)
		case(Func[4:1])
			4'b0100: // ADD
				begin
					ALUControl = 3'b000;
					FlagW		  = (Func[0]) ? 2'b11 : 2'b00;
					NoWrite 	  = 1'b0;
				end
			4'b0010: // SUB
				begin
					ALUControl = 3'b001;
					FlagW		  = (Func[0]) ? 2'b11 : 2'b00;
					NoWrite 	  = 1'b0;
				end
			4'b0000: // AND
				begin
					ALUControl = 3'b100;
					FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
					NoWrite 	  = 1'b0;
				end
			4'b1100: // ORR
				begin
					ALUControl = 3'b101;
					FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
					NoWrite 	  = 1'b0;
				end
			4'b0001: // XOR
				begin
					ALUControl = 3'b110;
					FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
					NoWrite 	  = 1'b0;
				end
			4'b1110: // BIC
				begin
					ALUControl = 3'b111;
					FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
					NoWrite 	  = 1'b0;
				end
			4'b1010: // CMP
				begin
					ALUControl = 3'b001;
					FlagW		  = 2'b00;
					NoWrite 	  = 1'b1;
				end
			4'b1101: // MOV -> LSR LSL
				begin
					ALUControl = 3'b010;
					FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
					NoWrite 	  = 1'b0;
				end
				
			default: 
				begin
					ALUControl = 3'b000;
					FlagW		  = 2'b00;
					NoWrite 	  = 1'b0;
				end
		endcase
	else
		begin
			ALUControl = 2'b00;
			FlagW		  = 2'b00;
			NoWrite 	  = 1'b0;
		end
	
endmodule