module AsyncMemory #(
	parameter DATA_WIDTH=32, 
	parameter ADDR_WIDTH=5
) (
	input wire [(ADDR_WIDTH-1):0] ADDR,
	output reg [(DATA_WIDTH-1):0] Out
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
	begin
		$readmemh("Instruction.txt", rom);
	end

	always @ (ADDR)
	begin
		Out = rom[ADDR];
	end

endmodule
