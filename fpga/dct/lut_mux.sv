module lut_mux(input logic[2:0] k1, [2:0] k2,[2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	wire [31:0] cos_term_0_0;
	k1_0_k2_0_lut lut_k1_0_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_0_0));
	wire [31:0] cos_term_0_1;
	k1_0_k2_1_lut lut_k1_0_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_0_1));
	wire [31:0] cos_term_0_2;
	k1_0_k2_2_lut lut_k1_0_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_0_2));
	wire [31:0] cos_term_0_3;
	k1_0_k2_3_lut lut_k1_0_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_0_3));
	wire [31:0] cos_term_0_4;
	k1_0_k2_4_lut lut_k1_0_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_0_4));
	wire [31:0] cos_term_0_5;
	k1_0_k2_5_lut lut_k1_0_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_0_5));
	wire [31:0] cos_term_0_6;
	k1_0_k2_6_lut lut_k1_0_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_0_6));
	wire [31:0] cos_term_0_7;
	k1_0_k2_7_lut lut_k1_0_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_0_7));
	wire [31:0] cos_term_1_0;
	k1_1_k2_0_lut lut_k1_1_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_1_0));
	wire [31:0] cos_term_1_1;
	k1_1_k2_1_lut lut_k1_1_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_1_1));
	wire [31:0] cos_term_1_2;
	k1_1_k2_2_lut lut_k1_1_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_1_2));
	wire [31:0] cos_term_1_3;
	k1_1_k2_3_lut lut_k1_1_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_1_3));
	wire [31:0] cos_term_1_4;
	k1_1_k2_4_lut lut_k1_1_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_1_4));
	wire [31:0] cos_term_1_5;
	k1_1_k2_5_lut lut_k1_1_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_1_5));
	wire [31:0] cos_term_1_6;
	k1_1_k2_6_lut lut_k1_1_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_1_6));
	wire [31:0] cos_term_1_7;
	k1_1_k2_7_lut lut_k1_1_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_1_7));
	wire [31:0] cos_term_2_0;
	k1_2_k2_0_lut lut_k1_2_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_2_0));
	wire [31:0] cos_term_2_1;
	k1_2_k2_1_lut lut_k1_2_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_2_1));
	wire [31:0] cos_term_2_2;
	k1_2_k2_2_lut lut_k1_2_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_2_2));
	wire [31:0] cos_term_2_3;
	k1_2_k2_3_lut lut_k1_2_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_2_3));
	wire [31:0] cos_term_2_4;
	k1_2_k2_4_lut lut_k1_2_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_2_4));
	wire [31:0] cos_term_2_5;
	k1_2_k2_5_lut lut_k1_2_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_2_5));
	wire [31:0] cos_term_2_6;
	k1_2_k2_6_lut lut_k1_2_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_2_6));
	wire [31:0] cos_term_2_7;
	k1_2_k2_7_lut lut_k1_2_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_2_7));
	wire [31:0] cos_term_3_0;
	k1_3_k2_0_lut lut_k1_3_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_3_0));
	wire [31:0] cos_term_3_1;
	k1_3_k2_1_lut lut_k1_3_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_3_1));
	wire [31:0] cos_term_3_2;
	k1_3_k2_2_lut lut_k1_3_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_3_2));
	wire [31:0] cos_term_3_3;
	k1_3_k2_3_lut lut_k1_3_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_3_3));
	wire [31:0] cos_term_3_4;
	k1_3_k2_4_lut lut_k1_3_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_3_4));
	wire [31:0] cos_term_3_5;
	k1_3_k2_5_lut lut_k1_3_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_3_5));
	wire [31:0] cos_term_3_6;
	k1_3_k2_6_lut lut_k1_3_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_3_6));
	wire [31:0] cos_term_3_7;
	k1_3_k2_7_lut lut_k1_3_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_3_7));
	wire [31:0] cos_term_4_0;
	k1_4_k2_0_lut lut_k1_4_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_4_0));
	wire [31:0] cos_term_4_1;
	k1_4_k2_1_lut lut_k1_4_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_4_1));
	wire [31:0] cos_term_4_2;
	k1_4_k2_2_lut lut_k1_4_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_4_2));
	wire [31:0] cos_term_4_3;
	k1_4_k2_3_lut lut_k1_4_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_4_3));
	wire [31:0] cos_term_4_4;
	k1_4_k2_4_lut lut_k1_4_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_4_4));
	wire [31:0] cos_term_4_5;
	k1_4_k2_5_lut lut_k1_4_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_4_5));
	wire [31:0] cos_term_4_6;
	k1_4_k2_6_lut lut_k1_4_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_4_6));
	wire [31:0] cos_term_4_7;
	k1_4_k2_7_lut lut_k1_4_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_4_7));
	wire [31:0] cos_term_5_0;
	k1_5_k2_0_lut lut_k1_5_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_5_0));
	wire [31:0] cos_term_5_1;
	k1_5_k2_1_lut lut_k1_5_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_5_1));
	wire [31:0] cos_term_5_2;
	k1_5_k2_2_lut lut_k1_5_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_5_2));
	wire [31:0] cos_term_5_3;
	k1_5_k2_3_lut lut_k1_5_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_5_3));
	wire [31:0] cos_term_5_4;
	k1_5_k2_4_lut lut_k1_5_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_5_4));
	wire [31:0] cos_term_5_5;
	k1_5_k2_5_lut lut_k1_5_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_5_5));
	wire [31:0] cos_term_5_6;
	k1_5_k2_6_lut lut_k1_5_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_5_6));
	wire [31:0] cos_term_5_7;
	k1_5_k2_7_lut lut_k1_5_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_5_7));
	wire [31:0] cos_term_6_0;
	k1_6_k2_0_lut lut_k1_6_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_6_0));
	wire [31:0] cos_term_6_1;
	k1_6_k2_1_lut lut_k1_6_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_6_1));
	wire [31:0] cos_term_6_2;
	k1_6_k2_2_lut lut_k1_6_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_6_2));
	wire [31:0] cos_term_6_3;
	k1_6_k2_3_lut lut_k1_6_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_6_3));
	wire [31:0] cos_term_6_4;
	k1_6_k2_4_lut lut_k1_6_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_6_4));
	wire [31:0] cos_term_6_5;
	k1_6_k2_5_lut lut_k1_6_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_6_5));
	wire [31:0] cos_term_6_6;
	k1_6_k2_6_lut lut_k1_6_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_6_6));
	wire [31:0] cos_term_6_7;
	k1_6_k2_7_lut lut_k1_6_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_6_7));
	wire [31:0] cos_term_7_0;
	k1_7_k2_0_lut lut_k1_7_k2_0(.n1(n1), .n2(n2), .cos_term(cos_term_7_0));
	wire [31:0] cos_term_7_1;
	k1_7_k2_1_lut lut_k1_7_k2_1(.n1(n1), .n2(n2), .cos_term(cos_term_7_1));
	wire [31:0] cos_term_7_2;
	k1_7_k2_2_lut lut_k1_7_k2_2(.n1(n1), .n2(n2), .cos_term(cos_term_7_2));
	wire [31:0] cos_term_7_3;
	k1_7_k2_3_lut lut_k1_7_k2_3(.n1(n1), .n2(n2), .cos_term(cos_term_7_3));
	wire [31:0] cos_term_7_4;
	k1_7_k2_4_lut lut_k1_7_k2_4(.n1(n1), .n2(n2), .cos_term(cos_term_7_4));
	wire [31:0] cos_term_7_5;
	k1_7_k2_5_lut lut_k1_7_k2_5(.n1(n1), .n2(n2), .cos_term(cos_term_7_5));
	wire [31:0] cos_term_7_6;
	k1_7_k2_6_lut lut_k1_7_k2_6(.n1(n1), .n2(n2), .cos_term(cos_term_7_6));
	wire [31:0] cos_term_7_7;
	k1_7_k2_7_lut lut_k1_7_k2_7(.n1(n1), .n2(n2), .cos_term(cos_term_7_7));
	always_comb begin
		case(k1)
			0:
				case(k2)
					0: cos_term = cos_term_0_0;
					1: cos_term = cos_term_0_1;
					2: cos_term = cos_term_0_2;
					3: cos_term = cos_term_0_3;
					4: cos_term = cos_term_0_4;
					5: cos_term = cos_term_0_5;
					6: cos_term = cos_term_0_6;
					7: cos_term = cos_term_0_7;
				endcase
			1:
				case(k2)
					0: cos_term = cos_term_1_0;
					1: cos_term = cos_term_1_1;
					2: cos_term = cos_term_1_2;
					3: cos_term = cos_term_1_3;
					4: cos_term = cos_term_1_4;
					5: cos_term = cos_term_1_5;
					6: cos_term = cos_term_1_6;
					7: cos_term = cos_term_1_7;
				endcase
			2:
				case(k2)
					0: cos_term = cos_term_2_0;
					1: cos_term = cos_term_2_1;
					2: cos_term = cos_term_2_2;
					3: cos_term = cos_term_2_3;
					4: cos_term = cos_term_2_4;
					5: cos_term = cos_term_2_5;
					6: cos_term = cos_term_2_6;
					7: cos_term = cos_term_2_7;
				endcase
			3:
				case(k2)
					0: cos_term = cos_term_3_0;
					1: cos_term = cos_term_3_1;
					2: cos_term = cos_term_3_2;
					3: cos_term = cos_term_3_3;
					4: cos_term = cos_term_3_4;
					5: cos_term = cos_term_3_5;
					6: cos_term = cos_term_3_6;
					7: cos_term = cos_term_3_7;
				endcase
			4:
				case(k2)
					0: cos_term = cos_term_4_0;
					1: cos_term = cos_term_4_1;
					2: cos_term = cos_term_4_2;
					3: cos_term = cos_term_4_3;
					4: cos_term = cos_term_4_4;
					5: cos_term = cos_term_4_5;
					6: cos_term = cos_term_4_6;
					7: cos_term = cos_term_4_7;
				endcase
			5:
				case(k2)
					0: cos_term = cos_term_5_0;
					1: cos_term = cos_term_5_1;
					2: cos_term = cos_term_5_2;
					3: cos_term = cos_term_5_3;
					4: cos_term = cos_term_5_4;
					5: cos_term = cos_term_5_5;
					6: cos_term = cos_term_5_6;
					7: cos_term = cos_term_5_7;
				endcase
			6:
				case(k2)
					0: cos_term = cos_term_6_0;
					1: cos_term = cos_term_6_1;
					2: cos_term = cos_term_6_2;
					3: cos_term = cos_term_6_3;
					4: cos_term = cos_term_6_4;
					5: cos_term = cos_term_6_5;
					6: cos_term = cos_term_6_6;
					7: cos_term = cos_term_6_7;
				endcase
			7:
				case(k2)
					0: cos_term = cos_term_7_0;
					1: cos_term = cos_term_7_1;
					2: cos_term = cos_term_7_2;
					3: cos_term = cos_term_7_3;
					4: cos_term = cos_term_7_4;
					5: cos_term = cos_term_7_5;
					6: cos_term = cos_term_7_6;
					7: cos_term = cos_term_7_7;
				endcase
		endcase
	end
endmodule
