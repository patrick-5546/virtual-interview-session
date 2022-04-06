`default_nettype none

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

    //=============================================================================
    // REG/WIRE declarations
    //=============================================================================

    reg unsigned [31:0] desired_pixel; // temp reg for result

    // synchronized signals
    logic [29:0] SLOW2FAST_OUTDATA;
    logic [7:0] Y_CHANNEL_INT;
    logic [10:0] X, Y;

    reg unsigned [7:0] img [50175:0]; // 8-bit vector net with a depth of 224 x 224

    logic pixel_in_bounding_box, desired_pixel_in_bounding_box;

    logic [31:0] desiredX, desiredY, blockUpperLeftX, blockUpperLeftY, blockUpperLeft;

    logic [31:0] block_ind;

    logic [511:0] dct_in;
    logic [1023:0] dct_out;


    //=============================================================================
    // Continuous assignments
    //=============================================================================

    assign Y_CHANNEL_INT    = SLOW2FAST_OUTDATA[29:22];
    assign X                = SLOW2FAST_OUTDATA[21:11];
    assign Y                = SLOW2FAST_OUTDATA[10:0];

    /* Bounding box around the 224x224 capture field centered on the 640x480 screen
        - Top left coordinates of capture field:     (208, 128)
        - Bottom right coordinates of capture field: (431, 351)
    */
    assign desired_pixel_in_bounding_box = 0 <= desired_pixel && desired_pixel <= 50175;
    assign pixel_in_bounding_box = (208 <= X && X <= 431) && (128 <= Y && Y <= 351);

    always_ff @(posedge clk)
        if(!desired_pixel_in_bounding_box && pixel_in_bounding_box)
            img[224 * (Y-128) + (X-208)] <= Y_CHANNEL_INT;

    assign desiredX = desired_pixel % 224;
    assign desiredY = desired_pixel / 224;
    assign blockUpperLeftX = (desiredX >> 3) << 3;
    assign blockUpperLeftY = (desiredY >> 3) << 3;
    assign blockUpperLeft = desired_pixel_in_bounding_box ? (224 * blockUpperLeftY + blockUpperLeftX) : 0;

    assign block_ind = (((desiredY - blockUpperLeftY) << 3) + desiredX - blockUpperLeftX) << 4;

    always_comb
        dct_in = {
            img[blockUpperLeft + 224*7 + 7], img[blockUpperLeft + 224*7 + 6], img[blockUpperLeft + 224*7 + 5], img[blockUpperLeft + 224*7 + 4], img[blockUpperLeft + 224*7 + 3], img[blockUpperLeft + 224*7 + 2], img[blockUpperLeft + 224*7 + 1], img[blockUpperLeft + 224*7 + 0],
            img[blockUpperLeft + 224*6 + 7], img[blockUpperLeft + 224*6 + 6], img[blockUpperLeft + 224*6 + 5], img[blockUpperLeft + 224*6 + 4], img[blockUpperLeft + 224*6 + 3], img[blockUpperLeft + 224*6 + 2], img[blockUpperLeft + 224*6 + 1], img[blockUpperLeft + 224*6 + 0],
            img[blockUpperLeft + 224*5 + 7], img[blockUpperLeft + 224*5 + 6], img[blockUpperLeft + 224*5 + 5], img[blockUpperLeft + 224*5 + 4], img[blockUpperLeft + 224*5 + 3], img[blockUpperLeft + 224*5 + 2], img[blockUpperLeft + 224*5 + 1], img[blockUpperLeft + 224*5 + 0],
            img[blockUpperLeft + 224*4 + 7], img[blockUpperLeft + 224*4 + 6], img[blockUpperLeft + 224*4 + 5], img[blockUpperLeft + 224*4 + 4], img[blockUpperLeft + 224*4 + 3], img[blockUpperLeft + 224*4 + 2], img[blockUpperLeft + 224*4 + 1], img[blockUpperLeft + 224*4 + 0],
            img[blockUpperLeft + 224*3 + 7], img[blockUpperLeft + 224*3 + 6], img[blockUpperLeft + 224*3 + 5], img[blockUpperLeft + 224*3 + 4], img[blockUpperLeft + 224*3 + 3], img[blockUpperLeft + 224*3 + 2], img[blockUpperLeft + 224*3 + 1], img[blockUpperLeft + 224*3 + 0],
            img[blockUpperLeft + 224*2 + 7], img[blockUpperLeft + 224*2 + 6], img[blockUpperLeft + 224*2 + 5], img[blockUpperLeft + 224*2 + 4], img[blockUpperLeft + 224*2 + 3], img[blockUpperLeft + 224*2 + 2], img[blockUpperLeft + 224*2 + 1], img[blockUpperLeft + 224*2 + 0],
            img[blockUpperLeft + 224*1 + 7], img[blockUpperLeft + 224*1 + 6], img[blockUpperLeft + 224*1 + 5], img[blockUpperLeft + 224*1 + 4], img[blockUpperLeft + 224*1 + 3], img[blockUpperLeft + 224*1 + 2], img[blockUpperLeft + 224*1 + 1], img[blockUpperLeft + 224*1 + 0],
            img[blockUpperLeft + 224*0 + 7], img[blockUpperLeft + 224*0 + 6], img[blockUpperLeft + 224*0 + 5], img[blockUpperLeft + 224*0 + 4], img[blockUpperLeft + 224*0 + 3], img[blockUpperLeft + 224*0 + 2], img[blockUpperLeft + 224*0 + 1], img[blockUpperLeft + 224*0 + 0]
        };


    //=============================================================================
    // Structural coding
    //=============================================================================

    //------Y_CHANNEL and coordinates from VGA_CLK to clk (100 MHz) --
    slow2fast_sync #(.DATA_WIDTH(30)) s2fs (
        .fast_clk       ( clk ),
        .slow_clk       ( INDATA_export[30] ),
        .indata         ( INDATA_export[29:0] ),
        .outdata        ( SLOW2FAST_OUTDATA )
    );

    dct_quantization dct(.mcu(dct_in), .dct(dct_out));


    //=============================================================================
    // Interfacing with HPS
    //=============================================================================

    // writing
    always_ff @(posedge clk) begin
        if (reset_n == 0) // synchronous reset
            desired_pixel <= 32'd50176; // write value outside bounds to start registering values into img
        else if (wr_en == 1)
            desired_pixel <= writedata; // store result
    end


    // reading
    always @(*) begin
        readdata <= 32'b0; // default value is 0
        if (rd_en == 1)
            if ( addr == 2'd0 )
                readdata <= {dct_out[block_ind +: 16], 8'd0, img[desired_pixel]};
            else if ( addr == 2'd1 )
                readdata <= {blockUpperLeft[15:0], blockUpperLeftX[7:0], blockUpperLeftY[7:0]};
            else if ( addr == 2'd2 )
                readdata <= {6'b0, desired_pixel_in_bounding_box, pixel_in_bounding_box, block_ind[7:0], desiredX[7:0], desiredY[7:0]};
            else  // addr = 2'd3
                readdata <= desired_pixel;
    end

endmodule

`default_nettype wire
