module k1_4_k2_6_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h045;
				1: cos_term = -32'h0a7;
				2: cos_term = 32'h0a7;
				3: cos_term = -32'h045;
				4: cos_term = -32'h045;
				5: cos_term = 32'h0a7;
				6: cos_term = -32'h0a7;
				7: cos_term = 32'h045;
			endcase
			1: case(n2)
				0: cos_term = -32'h045;
				1: cos_term = 32'h0a7;
				2: cos_term = -32'h0a7;
				3: cos_term = 32'h045;
				4: cos_term = 32'h045;
				5: cos_term = -32'h0a7;
				6: cos_term = 32'h0a7;
				7: cos_term = -32'h045;
			endcase
			2: case(n2)
				0: cos_term = -32'h045;
				1: cos_term = 32'h0a7;
				2: cos_term = -32'h0a7;
				3: cos_term = 32'h045;
				4: cos_term = 32'h045;
				5: cos_term = -32'h0a7;
				6: cos_term = 32'h0a7;
				7: cos_term = -32'h045;
			endcase
			3: case(n2)
				0: cos_term = 32'h045;
				1: cos_term = -32'h0a7;
				2: cos_term = 32'h0a7;
				3: cos_term = -32'h045;
				4: cos_term = -32'h045;
				5: cos_term = 32'h0a7;
				6: cos_term = -32'h0a7;
				7: cos_term = 32'h045;
			endcase
			4: case(n2)
				0: cos_term = 32'h045;
				1: cos_term = -32'h0a7;
				2: cos_term = 32'h0a7;
				3: cos_term = -32'h045;
				4: cos_term = -32'h045;
				5: cos_term = 32'h0a7;
				6: cos_term = -32'h0a7;
				7: cos_term = 32'h045;
			endcase
			5: case(n2)
				0: cos_term = -32'h045;
				1: cos_term = 32'h0a7;
				2: cos_term = -32'h0a7;
				3: cos_term = 32'h045;
				4: cos_term = 32'h045;
				5: cos_term = -32'h0a7;
				6: cos_term = 32'h0a7;
				7: cos_term = -32'h045;
			endcase
			6: case(n2)
				0: cos_term = -32'h045;
				1: cos_term = 32'h0a7;
				2: cos_term = -32'h0a7;
				3: cos_term = 32'h045;
				4: cos_term = 32'h045;
				5: cos_term = -32'h0a7;
				6: cos_term = 32'h0a7;
				7: cos_term = -32'h045;
			endcase
			7: case(n2)
				0: cos_term = 32'h045;
				1: cos_term = -32'h0a7;
				2: cos_term = 32'h0a7;
				3: cos_term = -32'h045;
				4: cos_term = -32'h045;
				5: cos_term = 32'h0a7;
				6: cos_term = -32'h0a7;
				7: cos_term = 32'h045;
			endcase
		endcase
	end
endmodule