module compute_cos_terms_tb();

    logic inclk;
    logic reset;
    logic finish;
    logic start;
    logic [31:0] c_k1_k2;
    
    compute_cos_terms DUT(.clk(inclk), .reset(reset), .k1(3'b111), .k2(3'b000), .c_k1_k2(c_k1_k2), 
                         .start(start), .finish(finish));

    initial begin
	//start the clock and alternate every 5 ms. 
		inclk = 1'b1; #5;
		forever begin
			//alternate between on and off every 5 ms.
			inclk = 1'b0; #5;
			inclk = 1'b1; #5;
		end
	end

    initial begin
        reset = 1'b1;
        start = 1'b0;
        #5;
        reset = 1'b0;
        start = 1'b1;
        // #200;
        #2600;
        $stop;
    end
endmodule 
    