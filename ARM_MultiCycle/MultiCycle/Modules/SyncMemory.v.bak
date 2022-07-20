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
	(* ramstyle = "MLAB" *) reg [31:0]  memory [0:2**ADDR_W-1];

	always @(posedge CLK)
	if(WE)
	  memory[ADDR] 	<= WDI;

	assign DO   = memory[ADDR];
endmodule
