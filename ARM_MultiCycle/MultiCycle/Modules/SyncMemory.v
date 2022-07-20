module SyncMemory #(
	parameter WIDTH  = 32,
	parameter ADDR_W = 5
) (
	output 	wire 	[WIDTH-1:0] DO,
	input 	wire 	[ADDR_W-1:0] ADDR,
	input 	wire 	[WIDTH-1:0] WDI, 
	input 	wire 	WE,
	input 	wire 	CLK
);
//	 reg [7:0]  memory [(2**ADDR_W)-1:0] /* synthesis ramstyle = MLAB */;
	
	 reg [7:0] 	 mem0 [(2**ADDR_W)-1:0];
    reg [7:0] 	 mem1 [(2**ADDR_W)-1:0];
    reg [7:0] 	 mem2 [(2**ADDR_W)-1:0];
    reg [7:0] 	 mem3 [(2**ADDR_W)-1:0];
	
	initial
		begin
//			$readmemh("Instructions.txt", memory);
//			$display("%x%x%x%x", memory[ADDR+3], memory[ADDR+2], memory[ADDR+1], memory[ADDR]);
			$readmemh("D:/EE/EE446/Lab4/MultiCycle/mem0.txt", mem0);
			$readmemh("D:/EE/EE446/Lab4/MultiCycle/mem1.txt", mem1);
			$readmemh("D:/EE/EE446/Lab4/MultiCycle/mem2.txt", mem2);
			$readmemh("D:/EE/EE446/Lab4/MultiCycle/mem3.txt", mem3);
			$display("%x%x%x%x", mem3[0], mem2[0], mem1[0], mem0[0]);
		end
	
	
	always @(posedge CLK)
	if(WE) 
		begin
//			memory[ADDR+3] 	<= WDI[31:24];
//			memory[ADDR+2] 	<= WDI[23:16];
//			memory[ADDR+1] 	<= WDI[15:8];
//			memory[ADDR] 		<= WDI[7:0];
			mem3[ADDR] 	<= WDI[31:24];
			mem2[ADDR] 	<= WDI[23:16];
			mem1[ADDR] 	<= WDI[15:8];
			mem0[ADDR] 	<= WDI[7:0];
		end

	assign DO   = {mem3[ADDR], mem2[ADDR], mem1[ADDR], mem0[ADDR]};
//	assign DO   = {memory[ADDR+3], memory[ADDR+2], memory[ADDR+1], memory[ADDR]};
endmodule
