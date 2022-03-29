module dct(
    input logic clk, reset, start,
    input logic [7:0][7:0][31:0] mcu, // 8 rows of the MCU, each has 8 columns, with each column containing an 8 bit number  
    output logic [7:0][7:0][31:0] dct_out
);
    // FSM applies the DCT on an 8 pixel x 8 pixel MCU

    // using 32 bit signed fixed point representation using two's complement for negative numbers

    logic [3:0] mcu_select = 3'b000;

    // you need to take the sum across all the DCT images for each coordinate
    logic n_finish;
    reg [2:0] k1 = 3'b000, k2 = 3'b000;
    
    // STATE ENCODINGS  
    localparam IDLE = 3'b000;
    localparam START_N = 3'b010;
    localparam UPDATE_C = 3'b100;
    localparam INC_K = 3'b001;

    logic [2:0] state = IDLE;

    //STATE BITS
    assign start_n = state[1];
    assign inc_k = state[0];
    assign update_c = state[2];
    
    
    logic [31:0] c;

    //FSM: Nested iteration on k1 and k2.
    always_ff @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end
        else 
            case(state)
                IDLE: if(start) state <= START_N;
                START_N: if(n_finish) state <= UPDATE_C;
                UPDATE_C: state <= INC_K;
                INC_K: if(k1 == 3'b111) state <= IDLE; else state <= START_N;
            endcase
        if(update_c) begin
            dct_out[k1][k2] <= c;
        end
        if(inc_k) begin
            if(k2 == 3'b111) begin 
                k2 <= 0;
                k1 <= k1 + 1;
            end
            else begin
                k2 <= k2 + 1;
            end
        end
    end

    compute_cos_terms n_iteration(.start(start_n), 
                                  .clk(clk), 
                                  .reset(reset), 
                                  .k1(k1),
                                  .k2(k2),
                                  .mcu(mcu),
                                  .c(c),
                                  .finish(n_finish));


 
endmodule