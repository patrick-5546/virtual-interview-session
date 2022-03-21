module SevenSegmentDisplayDecoder(ssOut, nIn);
  output [6:0] ssOut;
  reg [6:0] ssOut_tmp;
  input [3:0] nIn;

  // ssOut format {g, f, e, d, c, b, a}

  always @*
    case (nIn)
      4'h0: ssOut_tmp = 7'b0111111;
      4'h1: ssOut_tmp = 7'b0000110;
      4'h2: ssOut_tmp = 7'b1011011;
      4'h3: ssOut_tmp = 7'b1001111;
      4'h4: ssOut_tmp = 7'b1100110;
      4'h5: ssOut_tmp = 7'b1101101;
      4'h6: ssOut_tmp = 7'b1111101;
      4'h7: ssOut_tmp = 7'b0000111;
      4'h8: ssOut_tmp = 7'b1111111;
      4'h9: ssOut_tmp = 7'b1101111;
      4'hA: ssOut_tmp = 7'b1110111;
      4'hB: ssOut_tmp = 7'b1111100;
      4'hC: ssOut_tmp = 7'b0111001;
      4'hD: ssOut_tmp = 7'b1011110;
      4'hE: ssOut_tmp = 7'b1111001;
      4'hF: ssOut_tmp = 7'b1110001;
    endcase
	assign ssOut = ~ssOut_tmp;
endmodule
