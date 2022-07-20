`timescale 10 ps/1 ps

module MultiCycle_tb (
	output wire [3:0] state,
	output wire [7:0] out
);

    localparam period = 1;
	 reg CLK, RESET_N;

    MultiCycle 	DUT(	
		.CLK(CLK) ,	
		.RESET_N(RESET_N) ,
		.STATE(state) ,
		.OUT(out) 
	); 

	always 
		begin
			#period;
			CLK = 1'b0; 

			#period;
			CLK = 1'b1;
			$stop;
		end
    
    initial 
        begin
				CLK = 0;
				RESET_N = 1;
        end
		  
	 
endmodule

