module slow2fast_sync #(
        parameter DATA_WIDTH = 8
    ) (
        input  logic fast_clk,
        input  logic slow_clk,
        input  logic [DATA_WIDTH-1:0] indata,
        output logic [DATA_WIDTH-1:0] outdata
);

    reg [DATA_WIDTH-1:0] q1 = 0;
    reg [DATA_WIDTH-1:0] q3 = 0;
    reg [DATA_WIDTH-1:0] q2 = 0;
    reg r3_en = 1'b0;

    // Synchronized output
    assign outdata = q2;

    // Input register (R1)
    always_ff @(posedge slow_clk) begin
        q1 <= indata;
    end

    // Intermediate register (R3)
    always_ff @(posedge fast_clk) begin
        if(r3_en)
            q3 <= q1;
    end

    // Output register (R2)
    always_ff @(posedge fast_clk) begin
        q2 <= q3;
    end

    // Logic for r3_en
    reg en_q1 = 1'b0;

    always_ff @(negedge fast_clk) begin
        en_q1 <= slow_clk;
    end

    always_ff @(negedge fast_clk) begin
        r3_en <= en_q1;
    end

endmodule