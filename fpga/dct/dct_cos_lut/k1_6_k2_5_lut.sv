module k1_6_k2_5_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h036;
				1: cos_term = -32'h06;
				2: cos_term = 32'h013;
				3: cos_term = 32'h051;
				4: cos_term = -32'h051;
				5: cos_term = -32'h013;
				6: cos_term = 32'h06;
				7: cos_term = -32'h036;
			endcase
			1: case(n2)
				0: cos_term = -32'h083;
				1: cos_term = 32'h0e7;
				2: cos_term = -32'h02e;
				3: cos_term = -32'h0c4;
				4: cos_term = 32'h0c4;
				5: cos_term = 32'h02e;
				6: cos_term = -32'h0e7;
				7: cos_term = 32'h083;
			endcase
			2: case(n2)
				0: cos_term = 32'h083;
				1: cos_term = -32'h0e7;
				2: cos_term = 32'h02e;
				3: cos_term = 32'h0c4;
				4: cos_term = -32'h0c4;
				5: cos_term = -32'h02e;
				6: cos_term = 32'h0e7;
				7: cos_term = -32'h083;
			endcase
			3: case(n2)
				0: cos_term = -32'h036;
				1: cos_term = 32'h06;
				2: cos_term = -32'h013;
				3: cos_term = -32'h051;
				4: cos_term = 32'h051;
				5: cos_term = 32'h013;
				6: cos_term = -32'h06;
				7: cos_term = 32'h036;
			endcase
			4: case(n2)
				0: cos_term = -32'h036;
				1: cos_term = 32'h06;
				2: cos_term = -32'h013;
				3: cos_term = -32'h051;
				4: cos_term = 32'h051;
				5: cos_term = 32'h013;
				6: cos_term = -32'h06;
				7: cos_term = 32'h036;
			endcase
			5: case(n2)
				0: cos_term = 32'h083;
				1: cos_term = -32'h0e7;
				2: cos_term = 32'h02e;
				3: cos_term = 32'h0c4;
				4: cos_term = -32'h0c4;
				5: cos_term = -32'h02e;
				6: cos_term = 32'h0e7;
				7: cos_term = -32'h083;
			endcase
			6: case(n2)
				0: cos_term = -32'h083;
				1: cos_term = 32'h0e7;
				2: cos_term = -32'h02e;
				3: cos_term = -32'h0c4;
				4: cos_term = 32'h0c4;
				5: cos_term = 32'h02e;
				6: cos_term = -32'h0e7;
				7: cos_term = 32'h083;
			endcase
			7: case(n2)
				0: cos_term = 32'h036;
				1: cos_term = -32'h06;
				2: cos_term = 32'h013;
				3: cos_term = 32'h051;
				4: cos_term = -32'h051;
				5: cos_term = -32'h013;
				6: cos_term = 32'h06;
				7: cos_term = -32'h036;
			endcase
		endcase
	end
endmodule