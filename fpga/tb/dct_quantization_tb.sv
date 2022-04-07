module dct_quantization_tb;
    logic [1023:0] dct_out;
    logic [511:0] mcu;
    
    initial begin
        mcu[7:0] = 8'hff;
        mcu[15:8] = 8'h00;
        mcu[23:16] = 8'hff;
        mcu[31:24] = 8'h00;
        mcu[39:32] = 8'hff;
        mcu[47:40] = 8'h00;
        mcu[55:48] = 8'hff;
        mcu[63:56] = 8'h00;
        mcu[71:64] = 8'hff;
        mcu[79:72] = 8'h00;
        mcu[87:80] = 8'hff;
        mcu[95:88] = 8'h00;
        mcu[103:96] = 8'hff;
        mcu[111:104] = 8'h00;
        mcu[119:112] = 8'hff;
        mcu[127:120] = 8'h00;
        mcu[135:128] = 8'hff;
        mcu[143:136] = 8'h00;
        mcu[151:144] = 8'hff;
        mcu[159:152] = 8'h00;
        mcu[167:160] = 8'hff;
        mcu[175:168] = 8'h00;
        mcu[183:176] = 8'hff;
        mcu[191:184] = 8'h00;
        mcu[199:192] = 8'hff;
        mcu[207:200] = 8'h00;
        mcu[215:208] = 8'hff;
        mcu[223:216] = 8'h00;
        mcu[231:224] = 8'hff;
        mcu[239:232] = 8'h00;
        mcu[247:240] = 8'hff;
        mcu[255:248] = 8'h00;
        mcu[263:256] = 8'hff;
        mcu[271:264] = 8'h00;
        mcu[279:272] = 8'hff;
        mcu[287:280] = 8'h00;
        mcu[295:288] = 8'hff;
        mcu[303:296] = 8'h00;
        mcu[311:304] = 8'hff;
        mcu[319:312] = 8'h00;
        mcu[327:320] = 8'hff;
        mcu[335:328] = 8'h00;
        mcu[343:336] = 8'hff;
        mcu[351:344] = 8'h00;
        mcu[359:352] = 8'hff;
        mcu[367:360] = 8'h00;
        mcu[375:368] = 8'hff;
        mcu[383:376] = 8'h00;
        mcu[391:384] = 8'hff;
        mcu[399:392] = 8'h00;
        mcu[407:400] = 8'hff;
        mcu[415:408] = 8'h00;
        mcu[423:416] = 8'hff;
        mcu[431:424] = 8'h00;
        mcu[439:432] = 8'hff;
        mcu[447:440] = 8'h00;
        mcu[455:448] = 8'hff;
        mcu[463:456] = 8'h00;
        mcu[471:464] = 8'hff;
        mcu[479:472] = 8'h00;
        mcu[487:480] = 8'hff;
        mcu[495:488] = 8'h00;
        mcu[503:496] = 8'hff;
        mcu[511:504] = 8'h00;

    end

    dct_quantization dut(.mcu(mcu), .dct(dct_out));
    initial begin
        #5;
        $stop;
    end
endmodule
