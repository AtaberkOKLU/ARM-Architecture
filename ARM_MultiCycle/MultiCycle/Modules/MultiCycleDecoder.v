module MultiCycleDecoder (
	input 	wire [1:0] 	Op,
	input 	wire [5:0] 	Func,
	input 	wire [3:0] 	Rd,
	input 	wire 			CLK,
	
	output 	wire 			NoWrite,
	output 	reg  [1:0]	FlagW,
	output 	reg  			PCS,
	output 	reg 			NextPC,
	output 	reg  			RegW,
	output 	reg  			MemW,
	
	output 	reg  			IRWrite,
	output 	reg  			AdrSrc,
	output 	reg  [1:0]	ResultSrc,
	output 	reg  			ALUSrcA,
	output 	reg  [1:0]	ALUSrcB,
	output 	reg  [1:0]	ImmSrc,
	output 	reg  [1:0]	RegSrc,
	output 	reg  [1:0]	ALUControl
	
);

	wire Branch;
	assign Branch = Op[1:0] == 2'b10;
	assign NoWrite = (Op == 2'b00) & (Func[4:1] == 4'b1010);
	assign PCS = ((Rd == 15) & RegW) | Branch
	assign RegSrc[1] = Op[1:0] == 2'b10;
	assign RegSrc[0] = Op[1:0] == 2'b01;
	assign ImmSrc = Op;
	assign RegW =  (Op[1:0] == 2'b00) || ((Op[1:0] == 2'b01) && (Func[0]));
	assign MemW =  ((Op[1:0] == 2'b01) && (!Func[0]));

	
	always @*
	case(Op)
		2'b00:	// DP
			begin
				ALUSrcA		= 1'b0;
				ALUSrcB[0]	= Func[5];
				ALUSrcB[1]	= 1'b0;
				
				case(Func[4:1])
					4'b0100: // ADD
						begin
							ALUControl = 2'b00;
							FlagW		  = (Func[0]) ? 2'b11 : 2'b00;
						end
					4'b0010: // SUB
						begin
							ALUControl = 2'b01;
							FlagW		  = (Func[0]) ? 2'b11 : 2'b00;
						end
					4'b0000: // AND
						begin
							ALUControl = 2'b10;
							FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
						end
					4'b1100: // ORR
						begin
							ALUControl = 2'b11;
							FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
						end
					4'b1010: // CMP
						begin
							ALUControl = 2'b01;
							FlagW		  = 2'b00;
						end
					4'b1101: // MOV -> LSR LSL
						begin
							ALUControl = 2'b11;
							FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
						end
						
					default: 
						begin
							ALUControl = 2'b01;
							FlagW		  = 2'b00;
						end
				endcase
			end
		2'b01:	// STR / LDR
			begin
				ALUSrcA		= 1'b0;
				ALUSrcB[0]	= !Func[5];
				ALUSrcB[1]	= 1'b0;
				

				ALUControl 	= 2'b00;
				FlagW		  	= 2'b00;	
			end
		2'b10: 	// Branch
			begin
				ALUSrcA		= 1'b0;
				ALUSrcB		= 2'b10;
				

				ALUControl 	= 2'b00;
				FlagW		  	= 2'b00;	
			end
		2'b11:
			begin
				PCS			= 0;
				RegW			= 0;
				MemW			= 0;
				MemSrc 	   = 0;
				Mem2Reg		= 0;
				ALUSrc		= 1;
				ImmSrc		= 2'b00;
				RegSrc		= 2'b00;
				ALUControl 	= 2'b00;
				FlagW		  	= 2'b00;	
			end
		
	endcase

endmodule 