module k1_7_k2_2_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h02e;
				1: cos_term = 32'h013;
				2: cos_term = -32'h013;
				3: cos_term = -32'h02e;
				4: cos_term = -32'h02e;
				5: cos_term = -32'h013;
				6: cos_term = 32'h013;
				7: cos_term = 32'h02e;
			endcase
			1: case(n2)
				0: cos_term = -32'h083;
				1: cos_term = -32'h036;
				2: cos_term = 32'h036;
				3: cos_term = 32'h083;
				4: cos_term = 32'h083;
				5: cos_term = 32'h036;
				6: cos_term = -32'h036;
				7: cos_term = -32'h083;
			endcase
			2: case(n2)
				0: cos_term = 32'h0c4;
				1: cos_term = 32'h051;
				2: cos_term = -32'h051;
				3: cos_term = -32'h0c4;
				4: cos_term = -32'h0c4;
				5: cos_term = -32'h051;
				6: cos_term = 32'h051;
				7: cos_term = 32'h0c4;
			endcase
			3: case(n2)
				0: cos_term = -32'h0e7;
				1: cos_term = -32'h06;
				2: cos_term = 32'h06;
				3: cos_term = 32'h0e7;
				4: cos_term = 32'h0e7;
				5: cos_term = 32'h06;
				6: cos_term = -32'h06;
				7: cos_term = -32'h0e7;
			endcase
			4: case(n2)
				0: cos_term = 32'h0e7;
				1: cos_term = 32'h06;
				2: cos_term = -32'h06;
				3: cos_term = -32'h0e7;
				4: cos_term = -32'h0e7;
				5: cos_term = -32'h06;
				6: cos_term = 32'h06;
				7: cos_term = 32'h0e7;
			endcase
			5: case(n2)
				0: cos_term = -32'h0c4;
				1: cos_term = -32'h051;
				2: cos_term = 32'h051;
				3: cos_term = 32'h0c4;
				4: cos_term = 32'h0c4;
				5: cos_term = 32'h051;
				6: cos_term = -32'h051;
				7: cos_term = -32'h0c4;
			endcase
			6: case(n2)
				0: cos_term = 32'h083;
				1: cos_term = 32'h036;
				2: cos_term = -32'h036;
				3: cos_term = -32'h083;
				4: cos_term = -32'h083;
				5: cos_term = -32'h036;
				6: cos_term = 32'h036;
				7: cos_term = 32'h083;
			endcase
			7: case(n2)
				0: cos_term = -32'h02e;
				1: cos_term = -32'h013;
				2: cos_term = 32'h013;
				3: cos_term = 32'h02e;
				4: cos_term = 32'h02e;
				5: cos_term = 32'h013;
				6: cos_term = -32'h013;
				7: cos_term = -32'h02e;
			endcase
		endcase
	end
endmodule