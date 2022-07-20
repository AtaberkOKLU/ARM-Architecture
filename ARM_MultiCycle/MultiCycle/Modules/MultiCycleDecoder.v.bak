module SingleCycleDecoder (
	input 	wire [3:0] 	Rd,
	input 	wire [1:0] 	Op,
	input 	wire [5:0] 	Func,
	output 	wire 			NoWrite,
	output 	reg  			PCS,
	output 	reg  			RegW,
	output 	reg  			MemW,
	output 	reg  			Mem2Reg,
	output 	reg 			MemSrc,
	output 	reg  			ALUSrc,
	output 	reg  [1:0]	ImmSrc,
	output 	reg  [1:0]	RegSrc,
	output 	reg  [1:0]	ALUControl,
	output 	reg  [1:0]	FlagW
	
);

	assign NoWrite = (Op == 2'b00) & (Func[4:1] == 4'b1010);

	always @*
	case(Op)
		2'b00:	// DP
			begin
				PCS			= (Rd == 4'b1111);
				RegW			= 1;
				MemW			= 0;
				Mem2Reg		= 0;
				ALUSrc		= Func[5];
				ImmSrc		= 0;
				RegSrc		= 0;
				
				case(Func[4:1])
					4'b0100: // ADD
						begin
							ALUControl = 2'b00;
							MemSrc 	  = 0;
							FlagW		  = (Func[0]) ? 2'b11 : 2'b00;
						end
					4'b0010: // SUB
						begin
							ALUControl = 2'b01;
							MemSrc 	  = 0;
							FlagW		  = (Func[0]) ? 2'b11 : 2'b00;
						end
					4'b0000: // AND
						begin
							ALUControl = 2'b10;
							MemSrc 	  = 0;
							FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
						end
					4'b1100: // ORR
						begin
							ALUControl = 2'b11;
							MemSrc 	  = 0;
							FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
						end
					4'b1010: // CMP
						begin
							ALUControl = 2'b01;
							MemSrc 	  = 0;
							FlagW		  = 2'b00;
						end
					4'b1101: // MOV -> LSR LSL
						begin
							ALUControl = 2'b11;
							MemSrc 	  = 1;
							FlagW		  = (Func[0]) ? 2'b10 : 2'b00;
						end
						
					default: 
						begin
							ALUControl = 2'b01;
							MemSrc 	  = 0;
							FlagW		  = 2'b00;
						end
				endcase
			end
		2'b01:	// STR / LDR
			begin
				RegW			= (Func[0]) ? 1'b1 : 1'b0;
				PCS			= (!Func[0]) & (Rd == 4'b1111);
				MemW			= (Func[0]) ? 1'b0 : 1'b1;
				Mem2Reg		= 1;
				ALUSrc		= 1;
				MemSrc 	   = 0;
				ImmSrc		= 2'b01;
				RegSrc		= 2'b10;
				ALUControl 	= 2'b01;
				FlagW		  	= 2'b00;	
			end
		2'b10: 	// Branch
			begin
				PCS			= 1;
				RegW			= 0;
				MemW			= 0;
				Mem2Reg		= 0;
				MemSrc 	   = 0;
				ALUSrc		= 1;
				ImmSrc		= 2'b10;
				RegSrc		= 2'b11;
				ALUControl 	= 2'b01;
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