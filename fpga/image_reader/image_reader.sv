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
    input logic [30:0] INDATA_export
);
    reg unsigned [31:0] saved_value; // temp reg for result

    logic [29:0] SLOW2FAST_OUTDATA;
    logic [7:0] Y_CHANNEL_INT;
    logic [10:0] X, Y;
    assign Y_CHANNEL_INT    = SLOW2FAST_OUTDATA[29:22];
    assign X                = SLOW2FAST_OUTDATA[21:11];
    assign Y                = SLOW2FAST_OUTDATA[10:0];

    //------Y_CHANNEL and coordinates from VGA_CLK to clk (100 MHz) --
    slow2fast_sync #(.DATA_WIDTH(30)) s2fs (
        .fast_clk       ( clk ),
        .slow_clk       ( INDATA_export[30] ),
        .indata         ( INDATA_export[29:0] ),
        .outdata        ( SLOW2FAST_OUTDATA )
    );

    reg unsigned [7:0] img [50176:0]; // 8-bit vector net with a depth of 224 x 224
    logic [31:0] desiredX, desiredY;
    assign desiredX = saved_value % 16'd224;
    assign desiredY = saved_value / 16'd224;

    /* Bounding box around the 224x224 capture field centered on the 640x480 screen
        - Top left coordinates of capture field:     (208, 128)
        - Bottom right coordinates of capture field: (431, 351)
    */
    logic pixel_in_bounding_box, desired_pixel_in_bounding_box;
    assign desired_pixel_in_bounding_box = (0 <= desiredX) && (desiredX <= 223) && (0 <= desiredY) && (desiredY <= 223);
    assign pixel_in_bounding_box = (208 <= X) && (X <= 431) && (128 <= Y) && (Y <= 351);

    always_ff @(posedge clk)
        if(!desired_pixel_in_bounding_box && pixel_in_bounding_box)
            img[224 * (Y-128) + (X-208)] <= Y_CHANNEL_INT;

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
                readdata <= {24'd0, img[saved_value]};
            else if ( addr == 2'b01 )
                readdata <= desiredY;
            else if ( addr == 2'b10 )
                readdata <= desiredX;
            else
                readdata <= saved_value; // what was written
    end

endmodule
