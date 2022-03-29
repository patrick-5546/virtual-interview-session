module dct_tb ();
    logic clk, reset, start;

    logic [7:0][7:0][31:0] dct_out;
    logic [7:0][7:0][31:0] mcu;

    dct DCT(.clk(clk), .reset(reset), .start(start), .mcu(mcu), .dct_out(dct_out));

    initial forever begin
        clk = 0; #5;
        clk = 1; #5;
    end

    initial begin
        mcu[0][0] = 32'hff00;
        mcu[0][1] = 32'h0000;
        mcu[0][2] = 32'hff00;
        mcu[0][3] = 32'h0000;
        mcu[0][4] = 32'hff00;
        mcu[0][5] = 32'h0000;
        mcu[0][6] = 32'hff00;
        mcu[0][7] = 32'h0000;
        mcu[1][0] = 32'hff00;
        mcu[1][1] = 32'h0000;
        mcu[1][2] = 32'hff00;
        mcu[1][3] = 32'h0000;
        mcu[1][4] = 32'hff00;
        mcu[1][5] = 32'h0000;
        mcu[1][6] = 32'hff00;
        mcu[1][7] = 32'h0000;
        mcu[2][0] = 32'hff00;
        mcu[2][1] = 32'h0000;
        mcu[2][2] = 32'hff00;
        mcu[2][3] = 32'h0000;
        mcu[2][4] = 32'hff00;
        mcu[2][5] = 32'h0000;
        mcu[2][6] = 32'hff00;
        mcu[2][7] = 32'h0000;
        mcu[3][0] = 32'hff00;
        mcu[3][1] = 32'h0000;
        mcu[3][2] = 32'hff00;
        mcu[3][3] = 32'h0000;
        mcu[3][4] = 32'hff00;
        mcu[3][5] = 32'h0000;
        mcu[3][6] = 32'hff00;
        mcu[3][7] = 32'h0000;
        mcu[4][0] = 32'hff00;
        mcu[4][1] = 32'h0000;
        mcu[4][2] = 32'hff00;
        mcu[4][3] = 32'h0000;
        mcu[4][4] = 32'hff00;
        mcu[4][5] = 32'h0000;
        mcu[4][6] = 32'hff00;
        mcu[4][7] = 32'h0000;
        mcu[5][0] = 32'hff00;
        mcu[5][1] = 32'h0000;
        mcu[5][2] = 32'hff00;
        mcu[5][3] = 32'h0000;
        mcu[5][4] = 32'hff00;
        mcu[5][5] = 32'h0000;
        mcu[5][6] = 32'hff00;
        mcu[5][7] = 32'h0000;
        mcu[6][0] = 32'hff00;
        mcu[6][1] = 32'h0000;
        mcu[6][2] = 32'hff00;
        mcu[6][3] = 32'h0000;
        mcu[6][4] = 32'hff00;
        mcu[6][5] = 32'h0000;
        mcu[6][6] = 32'hff00;
        mcu[6][7] = 32'h0000;
        mcu[7][0] = 32'hff00;
        mcu[7][1] = 32'h0000;
        mcu[7][2] = 32'hff00;
        mcu[7][3] = 32'h0000;
        mcu[7][4] = 32'hff00;
        mcu[7][5] = 32'h0000;
        mcu[7][6] = 32'hff00;
        mcu[7][7] = 32'h0000;
        #5;
        reset = 1'b1;
        start = 1'b1;
        #5;
        reset = 1'b0;
        #45000;
        #45000;
        #45000;

        $stop;
    end
    
endmodule