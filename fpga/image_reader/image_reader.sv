module image_reader (
    // signals for connecting to the Avalon fabric
    input clk,
    input reset_n,
    input unsigned [5:0] addr,
    input rd_en,
    input wr_en,
    output reg unsigned [31:0] readdata,
    input unsigned [31:0] writedata,

    // signal for exporting register contents outside of the embedded system
    input logic [30:0] INDATA_export
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
        .slow_clk       ( INDATA_export[30] ),
        .indata         ( INDATA_export[29:0] ),
        .outdata        ( SLOW2FAST_OUTDATA )
    );
    assign Y_CHANNEL_INT    = SLOW2FAST_OUTDATA[29:22];
    assign X                = SLOW2FAST_OUTDATA[21:11];
    assign Y                = SLOW2FAST_OUTDATA[10:0];

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

    // must check that x and y are within the bounding box.
    // at a certain x, y you can start registering MCUs and sending them off to the DCT instances.
    // Then when we reach the last pixel of the strip, stop constructing MCUs and reset your counters.

     /* Bounding box around the 224x224 capture field centered on the 640x480 screen
            - Top left coordinates of capture field:     (208, 128) 
            - Bottom right coordinates of capture field: (432, 352) */

    // MCUs Construction FSM, note we need a "strip number", which is contained in the write data that will dictate when we start constructing MCUs

    logic [7:0][7:0][31:0] mcu0;
    logic [7:0][7:0][31:0] mcu1;
    logic [7:0][7:0][31:0] mcu2;
    logic [7:0][7:0][31:0] mcu3;
    logic [7:0][7:0][31:0] mcu4;
    logic [7:0][7:0][31:0] mcu5;
    logic [7:0][7:0][31:0] mcu6;
    logic [7:0][7:0][31:0] mcu7;
    logic [7:0][7:0][31:0] mcu8;
    logic [7:0][7:0][31:0] mcu9;
    logic [7:0][7:0][31:0] mcu10;
    logic [7:0][7:0][31:0] mcu11;
    logic [7:0][7:0][31:0] mcu12;
    logic [7:0][7:0][31:0] mcu13;
    logic [7:0][7:0][31:0] mcu14;
    logic [7:0][7:0][31:0] mcu15;
    logic [7:0][7:0][31:0] mcu16;
    logic [7:0][7:0][31:0] mcu17;
    logic [7:0][7:0][31:0] mcu18;
    logic [7:0][7:0][31:0] mcu19;
    logic [7:0][7:0][31:0] mcu20;
    logic [7:0][7:0][31:0] mcu21;
    logic [7:0][7:0][31:0] mcu22;
    logic [7:0][7:0][31:0] mcu23;
    logic [7:0][7:0][31:0] mcu24;
    logic [7:0][7:0][31:0] mcu25;
    logic [7:0][7:0][31:0] mcu26;
    logic [7:0][7:0][31:0] mcu27;

    logic [7:0][7:0][31:0] current_mcu;
    logic [10:0] mcu_construction_sel = ((X - 208) / 8);
    mcu_mux mcu_construction_mux(.sel(mcu_construction_sel),
                                 .mcu0(mcu0),
                                 .mcu1(mcu1),
                                 .mcu2(mcu2),
                                 .mcu3(mcu3),
                                 .mcu4(mcu4),
                                 .mcu5(mcu5),
                                 .mcu6(mcu6),
                                 .mcu7(mcu7),
                                 .mcu8(mcu8),
                                 .mcu9(mcu9),
                                 .mcu10(mcu10),
                                 .mcu11(mcu11),
                                 .mcu12(mcu12),
                                 .mcu13(mcu13),
                                 .mcu14(mcu14),
                                 .mcu15(mcu15),
                                 .mcu16(mcu16),
                                 .mcu17(mcu17),
                                 .mcu18(mcu18),
                                 .mcu19(mcu19),
                                 .mcu20(mcu20),
                                 .mcu21(mcu21),
                                 .mcu22(mcu22),
                                 .mcu23(mcu23),
                                 .mcu24(mcu24),
                                 .mcu25(mcu25),
                                 .mcu26(mcu26),
                                 .mcu27(mcu27),
                                 .mcu_out(current_mcu));

    wire [7:0] strip_number = saved_value[15:8];

    logic [10:0] strip_x = 0;
    logic [10:0] strip_y = 0;
    
    wire reading_from_bounding_box = ((208 <= X) && (X <= 432) && ((127 + 8 * strip_number) <= Y) && (Y <= (127 + 8 * (strip_number + 1))));
    wire last_pixel = (X == 432) && (Y == (127 + 8 * (strip_number + 1)));
    always_ff @(posedge clk) begin
        if(reading_from_bounding_box) begin
            current_mcu[(strip_x % 8)][(strip_y % 8)] <= Y_CHANNEL;
            if(strip_x < 208) begin
                strip_x <= strip_x + 1;
            end
            else if (strip_x == 208) begin
                strip_x <= 0;
                strip_y <= strip_y + 1;
            end
        end
        // If we reach the last pixel of the strip, reset both x and y.
        if(last_pixel) begin
            strip_x <= 0;
            strip_y <= 0;
        end
    end   

    logic [7:0][7:0][31:0] dct_input;
    logic [7:0] dct_mcu_select = saved_value[7:0];
    mcu_mux dct_input_selector(.sel(dct_mcu_select),
                               .mcu0(mcu0),
                               .mcu1(mcu1),
                               .mcu2(mcu2),
                               .mcu3(mcu3),
                               .mcu4(mcu4),
                               .mcu5(mcu5),
                               .mcu6(mcu6),
                               .mcu7(mcu7),
                               .mcu8(mcu8),
                               .mcu9(mcu9),
                               .mcu10(mcu10),
                               .mcu11(mcu11),
                               .mcu12(mcu12),
                               .mcu13(mcu13),
                               .mcu14(mcu14),
                               .mcu15(mcu15),
                               .mcu16(mcu16),
                               .mcu17(mcu17),
                               .mcu18(mcu18),
                               .mcu19(mcu19),
                               .mcu20(mcu20),
                               .mcu21(mcu21),
                               .mcu22(mcu22),
                               .mcu23(mcu23),
                               .mcu24(mcu24),
                               .mcu25(mcu25),
                               .mcu26(mcu26),
                               .mcu27(mcu27),
                               .mcu_out(dct_input)
                               );
    
    logic [7:0][7:0][31:0] dct_out;
    dct_quantization dct(.mcu_in(dct_input), .dct_out(dct_out));

    logic [2047:0] flattened_dct_out;

    flatten3d flat(.in_array(dct_out), .flatten_out(flattened_dct_out));

    logic [1023:0] first_half = flattened_dct_out[1023:0];
    logic [1023:0] second_half = flattened_dct_out[2047:1024];

    // reading
    always @(*) begin
        readdata <= 32'b0; // default value is 0
        if (rd_en == 1)
            if ( addr == 2'b00 )
                readdata <= first_half;
            else
                readdata <= second_half; // what was written

    end

endmodule
