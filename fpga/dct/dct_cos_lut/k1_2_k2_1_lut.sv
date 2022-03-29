module k1_2_k2_1_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0e7;
				1: cos_term = 32'h0c4;
				2: cos_term = 32'h083;
				3: cos_term = 32'h02e;
				4: cos_term = -32'h02e;
				5: cos_term = -32'h083;
				6: cos_term = -32'h0c4;
				7: cos_term = -32'h0e7;
			endcase
			1: case(n2)
				0: cos_term = 32'h06;
				1: cos_term = 32'h051;
				2: cos_term = 32'h036;
				3: cos_term = 32'h013;
				4: cos_term = -32'h013;
				5: cos_term = -32'h036;
				6: cos_term = -32'h051;
				7: cos_term = -32'h06;
			endcase
			2: case(n2)
				0: cos_term = -32'h06;
				1: cos_term = -32'h051;
				2: cos_term = -32'h036;
				3: cos_term = -32'h013;
				4: cos_term = 32'h013;
				5: cos_term = 32'h036;
				6: cos_term = 32'h051;
				7: cos_term = 32'h06;
			endcase
			3: case(n2)
				0: cos_term = -32'h0e7;
				1: cos_term = -32'h0c4;
				2: cos_term = -32'h083;
				3: cos_term = -32'h02e;
				4: cos_term = 32'h02e;
				5: cos_term = 32'h083;
				6: cos_term = 32'h0c4;
				7: cos_term = 32'h0e7;
			endcase
			4: case(n2)
				0: cos_term = -32'h0e7;
				1: cos_term = -32'h0c4;
				2: cos_term = -32'h083;
				3: cos_term = -32'h02e;
				4: cos_term = 32'h02e;
				5: cos_term = 32'h083;
				6: cos_term = 32'h0c4;
				7: cos_term = 32'h0e7;
			endcase
			5: case(n2)
				0: cos_term = -32'h06;
				1: cos_term = -32'h051;
				2: cos_term = -32'h036;
				3: cos_term = -32'h013;
				4: cos_term = 32'h013;
				5: cos_term = 32'h036;
				6: cos_term = 32'h051;
				7: cos_term = 32'h06;
			endcase
			6: case(n2)
				0: cos_term = 32'h06;
				1: cos_term = 32'h051;
				2: cos_term = 32'h036;
				3: cos_term = 32'h013;
				4: cos_term = -32'h013;
				5: cos_term = -32'h036;
				6: cos_term = -32'h051;
				7: cos_term = -32'h06;
			endcase
			7: case(n2)
				0: cos_term = 32'h0e7;
				1: cos_term = 32'h0c4;
				2: cos_term = 32'h083;
				3: cos_term = 32'h02e;
				4: cos_term = -32'h02e;
				5: cos_term = -32'h083;
				6: cos_term = -32'h0c4;
				7: cos_term = -32'h0e7;
			endcase
		endcase
	end
endmodule