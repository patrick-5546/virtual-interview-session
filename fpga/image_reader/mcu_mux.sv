module mcu_construction_mux(input logic[10:0] sel, input logic [7:0][7:0][31:0] mcu0, mcu1, mcu2, mcu3, mcu4, mcu5, mcu6, mcu7, mcu8, mcu9, mcu10, mcu11, mcu12, mcu13, mcu14, mcu15, mcu16, mcu17, mcu18, mcu19, mcu20, mcu21, mcu22, mcu23, mcu24, mcu25, mcu26, mcu27, output logic [7:0][7:0][31:0] mcu_out); 
    always_comb begin
        case(sel)
            0: mcu_out = mcu0;
            1: mcu_out = mcu1;
            2: mcu_out = mcu2;
            3: mcu_out = mcu3;
            4: mcu_out = mcu4;
            5: mcu_out = mcu5;
            6: mcu_out = mcu6;
            7: mcu_out = mcu7;
            8: mcu_out = mcu8;
            9: mcu_out = mcu9;
            10: mcu_out = mcu10;
            11: mcu_out = mcu11;
            12: mcu_out = mcu12;
            13: mcu_out = mcu13;
            14: mcu_out = mcu14;
            15: mcu_out = mcu15;
            16: mcu_out = mcu16;
            17: mcu_out = mcu17;
            18: mcu_out = mcu18;
            19: mcu_out = mcu19;
            20: mcu_out = mcu20;
            21: mcu_out = mcu21;
            22: mcu_out = mcu22;
            23: mcu_out = mcu23;
            24: mcu_out = mcu24;
            25: mcu_out = mcu25;
            26: mcu_out = mcu26;
            27: mcu_out = mcu27;
            default: mcu_out = 1'bx;
        endcase
    end

endmodule