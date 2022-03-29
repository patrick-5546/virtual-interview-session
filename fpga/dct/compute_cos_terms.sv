module compute_cos_terms(start, clk, reset, k1, k2, finish, mcu, c);
    input start, clk, reset;
    input [7:0][7:0][31:0] mcu;
    output logic finish;
    output logic [31:0] c;
    logic [31:0] c_k1_k2 = 32'b0;

    // ----- K INDEXES ----
    
    // k1 - row index to DCT output, k2 - col index to DCT output
    input [2:0] k1, k2; 

    // ----- Row and Column values -----
    logic [2:0] row = 3'b000, col = 3'b000;

    // ----- STATE ENCODINGS -----
    parameter [3:0] IDLE        = 4'b0000;
    parameter [3:0] UPDATE_C = 4'b0010;
    parameter [3:0] NEXT_PIXEL  = 4'b0001;
    parameter [3:0] OUTPUT_C = 4'b0110;
    parameter [3:0] COMPUTE_NEXT_TERM = 4'b1000;

    logic [3:0] state = IDLE;

    logic[31:0] cos_multiplied;

    lut_mux LUT_MUX(.k1(k1), .k2(k2), .cos_term(cos_multiplied), .n1(row), .n2(col));

    // ----- PIXEL SELECT FSM -----
    // Controls pixel selection, which essentially runs a double for loop and computes DCT each time ----- 

    wire inc_pixel = state[0];
    wire last_pixel = ((row == 3'b111) & (col == 3'b111));
    logic [63:0] term = 0;

    wire update_c_k1_k2 = state[1];
    wire register_c_out = state[2];
    wire compute_next_term_en = state[3];

    always_ff @(posedge clk) begin
        //synchronous reset
        if(reset) begin
            state <= IDLE;
        end
        else if(start) begin
            case(state)
                IDLE: state <= COMPUTE_NEXT_TERM;
                COMPUTE_NEXT_TERM: state <= UPDATE_C;
                UPDATE_C: if(last_pixel) state <= OUTPUT_C;
                          else state <= NEXT_PIXEL;
                NEXT_PIXEL: state <= COMPUTE_NEXT_TERM;
                OUTPUT_C: state <= IDLE;
            endcase
        end
        if(compute_next_term_en) begin
            term <= (mcu[row][col] * cos_multiplied) >>> 8;
        end
        if(update_c_k1_k2) begin
            c_k1_k2 <= (c_k1_k2 + term[31:0]);
        end
        if(inc_pixel) begin
            if(col == 3'b111) begin 
                col <= 0;
                row <= row + 1;
            end
            else begin
                col <= col + 1;
            end
        end
        if(register_c_out) begin
            c <= c_k1_k2;
            c_k1_k2 <= 0;
            row <= 0;
            col <= 0;
        end
    end

    assign finish = register_c_out;
    
endmodule