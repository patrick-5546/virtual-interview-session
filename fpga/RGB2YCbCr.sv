`default_nettype none

module RGB2YCbCr (
    input logic CLK,
    input logic [15:0] V_CNT, H_CNT,
    input logic [7:0] iR, iG, iB,
    output logic [13:0] oHEXR, oHEXG, oHEXB
);

    reg [31:0] COUNT;
    logic [6:0] HEXR1, HEXR0, HEXG1, HEXG0, HEXB1, HEXB0;
    logic [3:0] rR1, rR0, rG1, rG0, rB1, rB0;

    assign oHEXR = {HEXR1, HEXR0};
    assign oHEXG = {HEXG1, HEXG0};
    assign oHEXB = {HEXB1, HEXB0};

    SevenSegmentDisplayDecoder sevenseg5 ( .ssOut( HEXR1 ), .nIn( rR1 ) );
    SevenSegmentDisplayDecoder sevenseg4 ( .ssOut( HEXR0 ), .nIn( rR0 ) );
    SevenSegmentDisplayDecoder sevenseg3 ( .ssOut( HEXG1 ), .nIn( rG1 ) );
    SevenSegmentDisplayDecoder sevenseg2 ( .ssOut( HEXG0 ), .nIn( rG0 ) );
    SevenSegmentDisplayDecoder sevenseg1 ( .ssOut( HEXB1 ), .nIn( rB1 ) );
    SevenSegmentDisplayDecoder sevenseg0 ( .ssOut( HEXB0 ), .nIn( rB0 ) );

    always_ff @( posedge CLK ) begin
        if ( V_CNT == 262 && H_CNT == 400) begin
            if ( COUNT > 60 ) begin  // VGA is 60 fps, so update once per second
                {rR1, rR0} <= iR;
                {rG1, rG0} <= iG;
                {rB1, rB0} <= iB;

                COUNT <= 0;
            end
            else begin
                COUNT <= COUNT + 1;
            end
        end
    end

endmodule

`default_nettype wire
