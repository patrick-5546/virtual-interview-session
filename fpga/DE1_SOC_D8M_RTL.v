//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE1_SOC_D8M_RTL(
    //////////// ADC //////////
    output		          		ADC_CONVST,
    output		          		ADC_DIN,
    input 		          		ADC_DOUT,
    output		          		ADC_SCLK,

    //////////// Audio //////////
    input 		          		AUD_ADCDAT,
    inout 		          		AUD_ADCLRCK,
    inout 		          		AUD_BCLK,
    output		          		AUD_DACDAT,
    inout 		          		AUD_DACLRCK,
    output		          		AUD_XCK,

    //////////// CLOCK //////////
    input 		          		CLOCK2_50,
    input 		          		CLOCK3_50,
    input 		          		CLOCK4_50,
    input 		          		CLOCK_50,

    //////////// SDRAM //////////
    output		    [12:0]		DRAM_ADDR,
    output		    [1:0]		DRAM_BA,
    output		          		DRAM_CAS_N,
    output		          		DRAM_CKE,
    output		          		DRAM_CLK,
    output		          		DRAM_CS_N,
    inout 		    [15:0]		DRAM_DQ,
    output		          		DRAM_LDQM,
    output		          		DRAM_RAS_N,
    output		          		DRAM_UDQM,
    output		          		DRAM_WE_N,

    //////////// I2C for Audio and Video-In //////////
    output		          		FPGA_I2C_SCLK,
    inout 		          		FPGA_I2C_SDAT,

    //////////// SEG7 //////////
    output		     [6:0]		HEX0,
    output		     [6:0]		HEX1,
    output		     [6:0]		HEX2,
    output		     [6:0]		HEX3,
    output		     [6:0]		HEX4,
    output		     [6:0]		HEX5,

    //////////// IR //////////
    input 		          		IRDA_RXD,
    output		          		IRDA_TXD,

    //////////// KEY //////////
    input 		     [3:0]		KEY,

    //////////// LED //////////
    output		     [9:0]		LEDR,

    //////////// PS2 //////////
    inout 		          		PS2_CLK,
    inout 		          		PS2_CLK2,
    inout 		          		PS2_DAT,
    inout 		          		PS2_DAT2,

    //////////// SW //////////
    input 		     [9:0]		SW,

    //////////// Video-In //////////
    input 		          		TD_CLK27,
    input 		     [7:0]		TD_DATA,
    input 		          		TD_HS,
    output		          		TD_RESET_N,
    input 		          		TD_VS,

    //////////// VGA //////////
    output		          		VGA_BLANK_N,
    output		     [7:0]		VGA_B,
    output		          		VGA_CLK,
    output		     [7:0]		VGA_G,
    output		          		VGA_HS,
    output		     [7:0]		VGA_R,
    output		          		VGA_SYNC_N,
    output		          		VGA_VS,

    //////////// GPIO_1, GPIO_1 connect to D8M-GPIO //////////
    output 		          		CAMERA_I2C_SCL,
    inout 		          		CAMERA_I2C_SDA,
    output		          		CAMERA_PWDN_n,
    output		          		MIPI_CS_n,
    inout 		          		MIPI_I2C_SCL,
    inout 		          		MIPI_I2C_SDA,
    output		          		MIPI_MCLK,
    input 		          		MIPI_PIXEL_CLK,
    input 		     [9:0]		MIPI_PIXEL_D,
    input 		          		MIPI_PIXEL_HS,
    input 		          		MIPI_PIXEL_VS,
    output		          		MIPI_REFCLK,
    output		          		MIPI_RESET_n,
    //////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
    inout 		    [35:0]		GPIO,

    ////////////////////////////////////
    // HPS Pins
    ////////////////////////////////////

    // DDR3 SDRAM
    output		[14: 0]	HPS_DDR3_ADDR,
    output		[ 2: 0]  HPS_DDR3_BA,
    output					HPS_DDR3_CAS_N,
    output					HPS_DDR3_CKE,
    output					HPS_DDR3_CK_N,
    output					HPS_DDR3_CK_P,
    output					HPS_DDR3_CS_N,
    output		[ 3: 0]	HPS_DDR3_DM,
    inout			[31: 0]	HPS_DDR3_DQ,
    inout			[ 3: 0]	HPS_DDR3_DQS_N,
    inout			[ 3: 0]	HPS_DDR3_DQS_P,
    output					HPS_DDR3_ODT,
    output					HPS_DDR3_RAS_N,
    output					HPS_DDR3_RESET_N,
    input						HPS_DDR3_RZQ,
    output					HPS_DDR3_WE_N,

    // Ethernet
    output					HPS_ENET_GTX_CLK,
    inout						HPS_ENET_INT_N,
    output					HPS_ENET_MDC,
    inout						HPS_ENET_MDIO,
    input						HPS_ENET_RX_CLK,
    input			[ 3: 0]	HPS_ENET_RX_DATA,
    input						HPS_ENET_RX_DV,
    output		[ 3: 0]	HPS_ENET_TX_DATA,
    output					HPS_ENET_TX_EN,

    // Flash
    inout			[ 3: 0]	HPS_FLASH_DATA,
    output					HPS_FLASH_DCLK,
    output					HPS_FLASH_NCSO,

    // Accelerometer
    inout						HPS_GSENSOR_INT,

    // General Purpose I/O
    inout			[ 1: 0]	HPS_GPIO,

    // I2C
    inout						HPS_I2C_CONTROL,
    inout						HPS_I2C1_SCLK,
    inout						HPS_I2C1_SDAT,
    inout						HPS_I2C2_SCLK,
    inout						HPS_I2C2_SDAT,

    // Pushbutton
    inout						HPS_KEY,

    // LED
    inout						HPS_LED,

    // SD Card
    output					HPS_SD_CLK,
    inout						HPS_SD_CMD,
    inout			[ 3: 0]	HPS_SD_DATA,

    // SPI
    output					HPS_SPIM_CLK,
    input						HPS_SPIM_MISO,
    output					HPS_SPIM_MOSI,
    inout						HPS_SPIM_SS,

    // UART
    input						HPS_UART_RX,
    output					HPS_UART_TX,

    // USB
    inout						HPS_CONV_USB_N,
    input						HPS_USB_CLKOUT,
    inout			[ 7: 0]	HPS_USB_DATA,
    input						HPS_USB_DIR,
    input						HPS_USB_NXT,
    output					HPS_USB_STP
);


    //=============================================================================
    // REG/WIRE declarations
    //=============================================================================

    wire [15:0] SDRAM_RD_DATA;
    wire		DLY_RST_0;
    wire		DLY_RST_1;
    wire		DLY_RST_2;

    wire		SDRAM_CTRL_CLK;
    wire        D8M_CK_HZ;
    wire        D8M_CK_HZ2;
    wire        D8M_CK_HZ3;

    wire [7:0]  RED;
    wire [7:0]  GREEN;
    wire [7:0]  BLUE;
    wire [12:0] VGA_H_CNT;
    wire [12:0] VGA_V_CNT;

    wire        READ_Request;
    wire [7:0]  B_AUTO;
    wire [7:0]  G_AUTO;
    wire [7:0]  R_AUTO;
    wire        RESET_N;

    wire        I2C_RELEASE;
    wire        AUTO_FOC;
    wire        CAMERA_I2C_SCL_MIPI;
    wire        CAMERA_I2C_SCL_AF;
    wire        CAMERA_MIPI_RELAESE;
    wire        MIPI_BRIDGE_RELEASE;

    wire        LUT_MIPI_PIXEL_HS;
    wire        LUT_MIPI_PIXEL_VS;
    wire [9:0]  LUT_MIPI_PIXEL_D;
    wire        MIPI_PIXEL_CLK_;
    wire [9:0]  PCK;

    reg [7:0]  BOUND_RED, BOUND_GREEN, BOUND_BLUE;
    wire [10:0] X, Y;
    wire [7:0] Y_CHANNEL_INT;


    //=======================================================
    // Structural coding
    //=======================================================

    //--INPU MIPI-PIXEL-CLOCK DELAY
    CLOCK_DELAY  del1(  .iCLK (MIPI_PIXEL_CLK),  .oCLK (MIPI_PIXEL_CLK_ ) );

    assign LUT_MIPI_PIXEL_HS=MIPI_PIXEL_HS;
    assign LUT_MIPI_PIXEL_VS=MIPI_PIXEL_VS;
    assign LUT_MIPI_PIXEL_D =MIPI_PIXEL_D ;

    //------UART OFF --
    assign UART_RTS =0;
    assign UART_TXD =0;
    //------HEX OFF --
    // assign HEX0           = 7'h7F;
    // assign HEX1           = 7'h7F;
    // assign HEX2           = 7'h7F;
    // assign HEX3           = 7'h7F;
    // assign HEX4           = 7'h7F;
    // assign HEX5           = 7'h7F;

    //------ MIPI BRIGE & CAMERA RESET  --
    assign CAMERA_PWDN_n  = 1;
    assign MIPI_CS_n      = 0;
    assign MIPI_RESET_n   = RESET_N;

    //------ CAMERA MODULE I2C SWITCH  --
    assign I2C_RELEASE    = CAMERA_MIPI_RELAESE & MIPI_BRIDGE_RELEASE;
    assign CAMERA_I2C_SCL = ( I2C_RELEASE ) ? CAMERA_I2C_SCL_AF : CAMERA_I2C_SCL_MIPI;

    //----- RESET RELAY  --
    RESET_DELAY		u2	(
        .iRST  ( KEY[0] ),
        .iCLK  ( CLOCK2_50 ),
        .oRST_0( DLY_RST_0 ),
        .oRST_1( DLY_RST_1 ),
        .oRST_2( DLY_RST_2 ),
        .oREADY( RESET_N)
    );

    //------ MIPI BRIGE & CAMERA SETTING  --
    MIPI_BRIDGE_CAMERA_Config    cfin(
        .RESET_N           ( RESET_N ),
        .CLK_50            ( CLOCK2_50 ),
        .MIPI_I2C_SCL      ( MIPI_I2C_SCL ),
        .MIPI_I2C_SDA      ( MIPI_I2C_SDA ),
        .MIPI_I2C_RELEASE  ( MIPI_BRIDGE_RELEASE ),
        .CAMERA_I2C_SCL    ( CAMERA_I2C_SCL_MIPI ),
        .CAMERA_I2C_SDA    ( CAMERA_I2C_SDA ),
        .CAMERA_I2C_RELAESE( CAMERA_MIPI_RELAESE )
    );

    //------MIPI / VGA REF CLOCK  --
    pll_test pll_ref(
        .inclk0 ( CLOCK3_50 ),
        .areset ( ~KEY[0]   ),
        .c0( MIPI_REFCLK    ) //20Mhz
    );

    //------MIPI / VGA REF CLOCK  -
    VIDEO_PLL pll_ref1(
        .inclk0 ( CLOCK2_50 ),
        .areset ( ~KEY[0] ),
        .c0( VGA_CLK )        //25 Mhz
    );

    //------SDRAM CLOCK GENNERATER  --
    sdram_pll u6(
        .areset( 0 ),
        .inclk0( CLOCK_50 ),
        .c1    ( DRAM_CLK ),       //100MHZ   -90 degree
        .c0    ( SDRAM_CTRL_CLK )  //100MHZ     0 degree
    );

    //------SDRAM CONTROLLER --
    Sdram_Control	u7	(
        //	HOST Side
        .RESET_N     ( KEY[0] ),
        .CLK         ( SDRAM_CTRL_CLK ),

        //	FIFO Write Side 1
        .WR1_DATA    ( LUT_MIPI_PIXEL_D[9:0] ),
        .WR1         ( LUT_MIPI_PIXEL_HS & LUT_MIPI_PIXEL_VS ),
        .WR1_ADDR    ( 0 ),
        .WR1_MAX_ADDR( 640*480 ),
        .WR1_LENGTH  ( 256 ),
        .WR1_LOAD    ( !DLY_RST_0 ),
        .WR1_CLK     ( MIPI_PIXEL_CLK_ ),

        //	FIFO Read Side 1
        .RD1_DATA    ( SDRAM_RD_DATA[9:0] ),
        .RD1         ( READ_Request ),
        .RD1_ADDR    ( 0 ),
        .RD1_MAX_ADDR( 640*480 ),
        .RD1_LENGTH  ( 256  ),
        .RD1_LOAD    ( !DLY_RST_1 ),
        .RD1_CLK     ( VGA_CLK ),

        //	SDRAM Side
        .SA          ( DRAM_ADDR ),
        .BA          ( DRAM_BA ),
        .CS_N        ( DRAM_CS_N ),
        .CKE         ( DRAM_CKE ),
        .RAS_N       ( DRAM_RAS_N ),
        .CAS_N       ( DRAM_CAS_N ),
        .WE_N        ( DRAM_WE_N ),
        .DQ          ( DRAM_DQ ),
        .DQM         ( DRAM_DQM  )
    );

    //------ CMOS CCD_DATA TO RGB_DATA --

    RAW2RGB_J	u4	(
        .RST          ( VGA_VS ),
        .iDATA        ( SDRAM_RD_DATA[9:0] ),

        //-----------------------------------
        .VGA_CLK      ( VGA_CLK ),
        .READ_Request ( READ_Request ),
        .VGA_VS       ( VGA_VS ),
        .VGA_HS       ( VGA_HS ),

        .oRed         ( RED  ),
        .oGreen       ( GREEN),
        .oBlue        ( BLUE ),

        .mX_Cont      ( X ),
        .mY_Cont      ( Y )
    );

    /* Bounding box around the 224x224 capture field centered on the 640x480 screen
        - Top left coordinates of capture field:     (208, 128)
        - Bottom right coordinates of capture field: (431, 351)
    */
    wire bounding_box = ((Y == 127 || Y == 352) && (207 <= X && X <= 432)) || ((X == 207 || X == 432) && (127 <= Y && Y <= 352));
    wire border =       ((Y == 129 || Y == 350) && (209 <= X && X <= 430)) || ((X == 209 || X == 430) && (129 <= Y && Y <= 350));
    wire block = (208 <= X && X <= 215) && (128 <= Y && Y <= 135);
    //------Draw bounding box to VGA when SW[0] is down, test pixels when SW[0] is up --
    always @( SW[0] or bounding_box or border or block or RED or GREEN or BLUE ) begin
        if ( ~SW[0] ) begin
            if ( bounding_box ) begin
                BOUND_RED = 8'h00;
                BOUND_GREEN = 8'hFF;
                BOUND_BLUE = 8'hFF;
            end
            else begin
                BOUND_RED = RED;
                BOUND_GREEN = GREEN;
                BOUND_BLUE = BLUE;
            end
        end
        else begin
            if ( border || block ) begin
                BOUND_RED = 8'hFF;
                BOUND_GREEN = 8'h00;
                BOUND_BLUE = 8'hFF;
            end
            else begin
                BOUND_RED = RED;
                BOUND_GREEN = GREEN;
                BOUND_BLUE = BLUE;
            end
        end
    end

    //------RGB to YCbCr conversion (we only need Y) --
    assign Y_CHANNEL_INT = (16+(((BOUND_RED<<6) + (BOUND_RED<<1) + (BOUND_GREEN<<7) + BOUND_GREEN + (BOUND_BLUE<<4) + (BOUND_BLUE<<3) + BOUND_BLUE)>>8));

    //------Write RGB or Y channel values of bounding box top left corner to HEX every second --
    // Write RGB when SW[1] is up, else write integer part of Y channel
    COLOR2HEX	c2h (
        .CLK			( VGA_CLK ),
        .selRGB         ( SW[1] ),
        .X  			( X ),
        .Y	    		( Y ),
        .iR				( BOUND_RED ),
        .iG				( BOUND_GREEN ),
        .iB				( BOUND_BLUE ),
        .HEX			( {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} )
    );

    //------AOTO FOCUS ENABLE  --
    AUTO_FOCUS_ON  vd(
        .CLK_50      ( CLOCK2_50 ),
        .I2C_RELEASE ( I2C_RELEASE ),
        .AUTO_FOC    ( AUTO_FOC )
    );

    //------AOTO FOCUS ADJ  --
    FOCUS_ADJ adl(
        .CLK_50        ( CLOCK2_50 ),
        .RESET_N       ( I2C_RELEASE ),
        .RESET_SUB_N   ( I2C_RELEASE ),
        .AUTO_FOC      ( KEY[3] & AUTO_FOC ),
        .SW_Y          ( 0 ),
        .SW_H_FREQ     ( 0 ),
        .SW_FUC_LINE   ( SW[3] ),
        .SW_FUC_ALL_CEN( SW[3] ),
        .VIDEO_HS      ( VGA_HS ),
        .VIDEO_VS      ( VGA_VS ),
        .VIDEO_CLK     ( VGA_CLK ),
        .VIDEO_DE      (READ_Request),
        .iR            ( R_AUTO ),
        .iG            ( G_AUTO ),
        .iB            ( B_AUTO ),
        .oR            ( VGA_R ),
        .oG            ( VGA_G ),
        .oB            ( VGA_B ),

        .READY         ( READY ),
        .SCL           ( CAMERA_I2C_SCL_AF ),
        .SDA           ( CAMERA_I2C_SDA )
    );

    //------VGA Controller  --
    VGA_Controller		u1	(
        //	Host Side
        .oRequest( READ_Request ),
        .iRed    ( BOUND_RED    ),
        .iGreen  ( BOUND_GREEN  ),
        .iBlue   ( BOUND_BLUE   ),

        //	VGA Side
        .oVGA_R  ( R_AUTO[7:0] ),
        .oVGA_G  ( G_AUTO[7:0] ),
        .oVGA_B  ( B_AUTO[7:0] ),
        .oVGA_H_SYNC( VGA_HS ),
        .oVGA_V_SYNC( VGA_VS ),
        .oVGA_SYNC  ( VGA_SYNC_N ),
        .oVGA_BLANK ( VGA_BLANK_N ),

        //	Control Signal
        .iCLK       ( VGA_CLK ),
        .iRST_N     ( DLY_RST_2 ),
        .H_Cont     ( VGA_H_CNT ),
        .V_Cont     ( VGA_V_CNT )
    );

    //------VS FREQUENCY TEST = 60HZ --
    // FpsMonitor uFps(
    //     .clk50    ( CLOCK2_50 ),
    //     .vs       ( LUT_MIPI_PIXEL_VS ),
    //     .fps      (),
    //     .hex_fps_h( HEX1 ),
    //     .hex_fps_l( HEX0 )
    // );

    //--LED DISPLAY--
    CLOCKMEM  ck1 ( .CLK(VGA_CLK),          .CLK_FREQ(25000000), .CK_1HZ(D8M_CK_HZ)   );//25MHZ
    CLOCKMEM  ck2 ( .CLK(MIPI_REFCLK),      .CLK_FREQ(20000000), .CK_1HZ(D8M_CK_HZ2)  );//20MHZ
    CLOCKMEM  ck3 ( .CLK(MIPI_PIXEL_CLK_),  .CLK_FREQ(25000000), .CK_1HZ(D8M_CK_HZ3)  );//25MHZ

    assign LEDR = { D8M_CK_HZ, D8M_CK_HZ2,D8M_CK_HZ3, 5'h0,CAMERA_MIPI_RELAESE, MIPI_BRIDGE_RELEASE };

    Computer_System The_System (
        ////////////////////////////////////
        // FPGA Side
        ////////////////////////////////////

        // Global signals
        .system_pll_ref_clk_clk					(CLOCK_50),
        .system_pll_ref_reset_reset			(1'b0),

        // Image Reader Qsys Component
        .image_reader_indata_indata_export      ( {VGA_CLK, Y_CHANNEL_INT, X, Y} ),

        ////////////////////////////////////
        // HPS Side
        ////////////////////////////////////
        // DDR3 SDRAM
        .memory_mem_a			(HPS_DDR3_ADDR),
        .memory_mem_ba			(HPS_DDR3_BA),
        .memory_mem_ck			(HPS_DDR3_CK_P),
        .memory_mem_ck_n		(HPS_DDR3_CK_N),
        .memory_mem_cke		(HPS_DDR3_CKE),
        .memory_mem_cs_n		(HPS_DDR3_CS_N),
        .memory_mem_ras_n		(HPS_DDR3_RAS_N),
        .memory_mem_cas_n		(HPS_DDR3_CAS_N),
        .memory_mem_we_n		(HPS_DDR3_WE_N),
        .memory_mem_reset_n	(HPS_DDR3_RESET_N),
        .memory_mem_dq			(HPS_DDR3_DQ),
        .memory_mem_dqs		(HPS_DDR3_DQS_P),
        .memory_mem_dqs_n		(HPS_DDR3_DQS_N),
        .memory_mem_odt		(HPS_DDR3_ODT),
        .memory_mem_dm			(HPS_DDR3_DM),
        .memory_oct_rzqin		(HPS_DDR3_RZQ),

        // Ethernet
        .hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),
        .hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),
        .hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),
        .hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),
        .hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),
        .hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),
        .hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),
        .hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),
        .hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),
        .hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),
        .hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),
        .hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),
        .hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),
        .hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),
        .hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),

        // Flash
        .hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),
        .hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),
        .hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),
        .hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),
        .hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),
        .hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),

        // Accelerometer
        .hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),

        // General Purpose I/O
        .hps_io_hps_io_gpio_inst_GPIO40	(HPS_GPIO[0]),
        .hps_io_hps_io_gpio_inst_GPIO41	(HPS_GPIO[1]),

        // I2C
        .hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),
        .hps_io_hps_io_i2c0_inst_SDA		(HPS_I2C1_SDAT),
        .hps_io_hps_io_i2c0_inst_SCL		(HPS_I2C1_SCLK),
        .hps_io_hps_io_i2c1_inst_SDA		(HPS_I2C2_SDAT),
        .hps_io_hps_io_i2c1_inst_SCL		(HPS_I2C2_SCLK),

        // Pushbutton
        .hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),

        // LED
        .hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),

        // SD Card
        .hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),
        .hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),
        .hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),
        .hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),
        .hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),
        .hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),

        // SPI
        .hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),
        .hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),
        .hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),
        .hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),

        // UART
        .hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),
        .hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),

        // USB
        .hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),
        .hps_io_hps_io_usb1_inst_D0		(HPS_USB_DATA[0]),
        .hps_io_hps_io_usb1_inst_D1		(HPS_USB_DATA[1]),
        .hps_io_hps_io_usb1_inst_D2		(HPS_USB_DATA[2]),
        .hps_io_hps_io_usb1_inst_D3		(HPS_USB_DATA[3]),
        .hps_io_hps_io_usb1_inst_D4		(HPS_USB_DATA[4]),
        .hps_io_hps_io_usb1_inst_D5		(HPS_USB_DATA[5]),
        .hps_io_hps_io_usb1_inst_D6		(HPS_USB_DATA[6]),
        .hps_io_hps_io_usb1_inst_D7		(HPS_USB_DATA[7]),
        .hps_io_hps_io_usb1_inst_CLK		(HPS_USB_CLKOUT),
        .hps_io_hps_io_usb1_inst_STP		(HPS_USB_STP),
        .hps_io_hps_io_usb1_inst_DIR		(HPS_USB_DIR),
        .hps_io_hps_io_usb1_inst_NXT		(HPS_USB_NXT)
    );

endmodule
