module Reg_RWE  #(
	parameter W = 4
) (
	input 	wire [W-1:0] 	In,
	input 	wire 				WE,		// Write Enable
	input 	wire 				RESET_N,
	input 	wire 				CLK,
	output 	reg  [W-1:0]	Out
);

	initial
		Out = 0;


	always @ (negedge RESET_N or posedge CLK)
	begin

		if (!RESET_N)
			Out <= {W{1'b0}};

		else if (WE)
			Out <= In;
		
	end

endmodule


