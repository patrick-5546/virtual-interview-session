module lut_mux_tb;

    logic [2:0] k1;
    logic [2:0] k2;
    logic [2:0] n1;
    logic [2:0] n2;
    logic [31:0] cos_term;

    lut_mux LUT_MUX(.k1(k1), .k2(k2), .n1(n1), .n2(n2), .cos_term(cos_term));

    initial begin
        for (int i = 0; i < 8; i++) begin
            for (int j = 0; j < 8; j++) begin
                for(int n = 0; n < 8; n++) begin
                    for(int m = 0; m < 8; m++) begin
                        k1 = i;
                        k2 = j;
                        n1 = n;
                        n2 = m;
                        #5;
                    end
                end
            end
        end
        $stop;
    end

endmodule