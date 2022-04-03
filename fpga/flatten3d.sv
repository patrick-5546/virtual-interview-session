module flatten3d (
    input logic [7:0][7:0][31:0] in_array,
    output logic [2047:0] flatten_out
);

    always_comb begin
        flatten_out[31:0] = in_array[0][0]; 
        flatten_out[63:32] = in_array[0][1];
        flatten_out[95:64] = in_array[0][2];
        flatten_out[127:96] = in_array[0][3];
        flatten_out[159:128] = in_array[0][4];
        flatten_out[191:160] = in_array[0][5];
        flatten_out[223:192] = in_array[0][6];
        flatten_out[255:224] = in_array[0][7];
        flatten_out[287:256] = in_array[1][0];
        flatten_out[319:288] = in_array[1][1];
        flatten_out[351:320] = in_array[1][2];
        flatten_out[383:352] = in_array[1][3];
        flatten_out[415:384] = in_array[1][4];
        flatten_out[447:416] = in_array[1][5];
        flatten_out[479:448] = in_array[1][6];
        flatten_out[511:480] = in_array[1][7];
        flatten_out[543:512] = in_array[2][0];
        flatten_out[575:544] = in_array[2][1];
        flatten_out[607:576] = in_array[2][2];
        flatten_out[639:608] = in_array[2][3];
        flatten_out[671:640] = in_array[2][4];
        flatten_out[703:672] = in_array[2][5];
        flatten_out[735:704] = in_array[2][6];
        flatten_out[767:736] = in_array[2][7];
        flatten_out[799:768] = in_array[3][0];
        flatten_out[831:800] = in_array[3][1];
        flatten_out[863:832] = in_array[3][2];
        flatten_out[895:864] = in_array[3][3];
        flatten_out[927:896] = in_array[3][4];
        flatten_out[959:928] = in_array[3][5];
        flatten_out[991:960] = in_array[3][6];
        flatten_out[1023:992] = in_array[3][7];
        flatten_out[1055:1024] = in_array[4][0];
        flatten_out[1087:1056] = in_array[4][1];
        flatten_out[1119:1088] = in_array[4][2];
        flatten_out[1151:1120] = in_array[4][3];
        flatten_out[1183:1152] = in_array[4][4];
        flatten_out[1215:1184] = in_array[4][5];
        flatten_out[1247:1216] = in_array[4][6];
        flatten_out[1279:1248] = in_array[4][7];
        flatten_out[1311:1280] = in_array[5][0];
        flatten_out[1343:1312] = in_array[5][1];
        flatten_out[1375:1344] = in_array[5][2];
        flatten_out[1407:1376] = in_array[5][3];
        flatten_out[1439:1408] = in_array[5][4];
        flatten_out[1471:1440] = in_array[5][5];
        flatten_out[1503:1472] = in_array[5][6];
        flatten_out[1535:1504] = in_array[5][7];
        flatten_out[1567:1536] = in_array[6][0];
        flatten_out[1599:1568] = in_array[6][1];
        flatten_out[1631:1600] = in_array[6][2];
        flatten_out[1663:1632] = in_array[6][3];
        flatten_out[1695:1664] = in_array[6][4];
        flatten_out[1727:1696] = in_array[6][5];
        flatten_out[1759:1728] = in_array[6][6];
        flatten_out[1791:1760] = in_array[6][7];
        flatten_out[1823:1792] = in_array[7][0];
        flatten_out[1855:1824] = in_array[7][1];
        flatten_out[1887:1856] = in_array[7][2];
        flatten_out[1919:1888] = in_array[7][3];
        flatten_out[1951:1920] = in_array[7][4];
        flatten_out[1983:1952] = in_array[7][5];
        flatten_out[2015:1984] = in_array[7][6];
        flatten_out[2047:2016] = in_array[7][7];
    end
    
endmodule