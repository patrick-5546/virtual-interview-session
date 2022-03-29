module k1_6_k2_3_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h051;
				1: cos_term = -32'h013;
				2: cos_term = -32'h06;
				3: cos_term = -32'h036;
				4: cos_term = 32'h036;
				5: cos_term = 32'h06;
				6: cos_term = 32'h013;
				7: cos_term = -32'h051;
			endcase
			1: case(n2)
				0: cos_term = -32'h0c4;
				1: cos_term = 32'h02e;
				2: cos_term = 32'h0e7;
				3: cos_term = 32'h083;
				4: cos_term = -32'h083;
				5: cos_term = -32'h0e7;
				6: cos_term = -32'h02e;
				7: cos_term = 32'h0c4;
			endcase
			2: case(n2)
				0: cos_term = 32'h0c4;
				1: cos_term = -32'h02e;
				2: cos_term = -32'h0e7;
				3: cos_term = -32'h083;
				4: cos_term = 32'h083;
				5: cos_term = 32'h0e7;
				6: cos_term = 32'h02e;
				7: cos_term = -32'h0c4;
			endcase
			3: case(n2)
				0: cos_term = -32'h051;
				1: cos_term = 32'h013;
				2: cos_term = 32'h06;
				3: cos_term = 32'h036;
				4: cos_term = -32'h036;
				5: cos_term = -32'h06;
				6: cos_term = -32'h013;
				7: cos_term = 32'h051;
			endcase
			4: case(n2)
				0: cos_term = -32'h051;
				1: cos_term = 32'h013;
				2: cos_term = 32'h06;
				3: cos_term = 32'h036;
				4: cos_term = -32'h036;
				5: cos_term = -32'h06;
				6: cos_term = -32'h013;
				7: cos_term = 32'h051;
			endcase
			5: case(n2)
				0: cos_term = 32'h0c4;
				1: cos_term = -32'h02e;
				2: cos_term = -32'h0e7;
				3: cos_term = -32'h083;
				4: cos_term = 32'h083;
				5: cos_term = 32'h0e7;
				6: cos_term = 32'h02e;
				7: cos_term = -32'h0c4;
			endcase
			6: case(n2)
				0: cos_term = -32'h0c4;
				1: cos_term = 32'h02e;
				2: cos_term = 32'h0e7;
				3: cos_term = 32'h083;
				4: cos_term = -32'h083;
				5: cos_term = -32'h0e7;
				6: cos_term = -32'h02e;
				7: cos_term = 32'h0c4;
			endcase
			7: case(n2)
				0: cos_term = 32'h051;
				1: cos_term = -32'h013;
				2: cos_term = -32'h06;
				3: cos_term = -32'h036;
				4: cos_term = 32'h036;
				5: cos_term = 32'h06;
				6: cos_term = 32'h013;
				7: cos_term = -32'h051;
			endcase
		endcase
	end
endmodule