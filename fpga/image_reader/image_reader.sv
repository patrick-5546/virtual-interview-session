module image_reader (
    // signals for connecting to the Avalon fabric
    input clk,
    input reset_n,
    input unsigned [1:0] addr,
    input rd_en,
    input wr_en,
    output reg unsigned [31:0] readdata,
    input unsigned [31:0] writedata,

    // signal for exporting register contents outside of the embedded system
    input logic VGA_CLK_export,
    input logic [7:0] iY_CHANNEL_INT_export,
    input logic [10:0] iX_export, iY_export
);
    reg unsigned [31:0] saved_value; // temp reg for result
    integer i;

    logic [7:0] Y_CHANNEL_INT;
    logic [10:0] X, Y;
    logic [29:0] SLOW2FAST_OUTDATA;
    logic [31:0] Y_CHANNEL;

    //------Y_CHANNEL and coordinates from VGA_CLK to clk (100 MHz) --
    slow2fast_sync #(.DATA_WIDTH(30)) s2fs (
        .fast_clk       ( clk ),
        .slow_clk       ( VGA_CLK_export ),
        .indata         ( {iY_CHANNEL_INT_export, iX_export, iY_export} ),
        .outdata        ( SLOW2FAST_OUTDATA )
    );
    assign Y                = SLOW2FAST_OUTDATA[10:0];
    assign X                = SLOW2FAST_OUTDATA[21:11];
    assign Y_CHANNEL_INT    = SLOW2FAST_OUTDATA[29:22];

    //------Make Y_CHANNEL, a 32-bit fixed point number --
    // Top 24 bits is the integer part, bottom 8 bits is the fractional part
    assign Y_CHANNEL = Y_CHANNEL_INT << 8;

    // writing
    always_ff @(posedge clk) begin
        if (reset_n == 0) // synchronous reset
            saved_value <= 32'b0; // clear result on reset
        else if (wr_en == 1)
            saved_value <= writedata; // store result
    end

    // reading
    always @(*) begin
        readdata <= 32'b0; // default value is 0
        if (rd_en == 1)
            if ( addr == 2'b00 )
                readdata <= Y_CHANNEL;
            else
                readdata <= saved_value; // what was written

    end

endmodule
