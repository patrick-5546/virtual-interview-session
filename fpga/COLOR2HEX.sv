`default_nettype none

module COLOR2HEX (
    input logic CLK, selRGB,
    input logic [10:0] X, Y,
    input logic [7:0] iR, iG, iB,
    output logic [41:0] HEX
);

    // compute channel Y the same as in the top level module
    logic [31:0] Y_CHANNEL;
    assign Y_CHANNEL = (16 + (((iR<<6) + (iR<<1) + (iG<<7) + iG + (iB<<4) + (iB<<3) + iB)>>8))<<8;

    reg [31:0] COUNT = 0;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    logic [3:0] VAL5, VAL4, VAL3, VAL2, VAL1, VAL0;

    assign HEX = {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0};

    SevenSegmentDisplayDecoder sevenseg5 ( .ssOut( HEX5 ), .nIn( VAL5 ) );
    SevenSegmentDisplayDecoder sevenseg4 ( .ssOut( HEX4 ), .nIn( VAL4 ) );
    SevenSegmentDisplayDecoder sevenseg3 ( .ssOut( HEX3 ), .nIn( VAL3 ) );
    SevenSegmentDisplayDecoder sevenseg2 ( .ssOut( HEX2 ), .nIn( VAL2 ) );
    SevenSegmentDisplayDecoder sevenseg1 ( .ssOut( HEX1 ), .nIn( VAL1 ) );
    SevenSegmentDisplayDecoder sevenseg0 ( .ssOut( HEX0 ), .nIn( VAL0 ) );

    always_ff @( posedge CLK ) begin
        /* Bounding box around the 224x224 capture field centered on the 640x480 screen
            - Top left coordinates of capture field:     (208, 128)
            - Bottom right coordinates of capture field: (432, 352)
        */
        if ( X == 207 && Y == 127 ) begin
            if ( COUNT > 60 ) begin  // VGA is 60 Hz, so update once per second
                if ( selRGB ) begin
                    {VAL5, VAL4} <= iR;
                    {VAL3, VAL2} <= iG;
                    {VAL1, VAL0} <= iB;
                end
                else begin
                    {VAL5, VAL4, VAL3, VAL2, VAL1, VAL0} <= Y_CHANNEL[31:8];
                end

                COUNT <= 0;
            end
            else begin
                COUNT <= COUNT + 1;
            end
        end
    end

endmodule

`default_nettype wire
