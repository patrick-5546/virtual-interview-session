module k1_2_k2_2_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0da;
				1: cos_term = 32'h05a;
				2: cos_term = -32'h05a;
				3: cos_term = -32'h0da;
				4: cos_term = -32'h0da;
				5: cos_term = -32'h05a;
				6: cos_term = 32'h05a;
				7: cos_term = 32'h0da;
			endcase
			1: case(n2)
				0: cos_term = 32'h05a;
				1: cos_term = 32'h025;
				2: cos_term = -32'h025;
				3: cos_term = -32'h05a;
				4: cos_term = -32'h05a;
				5: cos_term = -32'h025;
				6: cos_term = 32'h025;
				7: cos_term = 32'h05a;
			endcase
			2: case(n2)
				0: cos_term = -32'h05a;
				1: cos_term = -32'h025;
				2: cos_term = 32'h025;
				3: cos_term = 32'h05a;
				4: cos_term = 32'h05a;
				5: cos_term = 32'h025;
				6: cos_term = -32'h025;
				7: cos_term = -32'h05a;
			endcase
			3: case(n2)
				0: cos_term = -32'h0da;
				1: cos_term = -32'h05a;
				2: cos_term = 32'h05a;
				3: cos_term = 32'h0da;
				4: cos_term = 32'h0da;
				5: cos_term = 32'h05a;
				6: cos_term = -32'h05a;
				7: cos_term = -32'h0da;
			endcase
			4: case(n2)
				0: cos_term = -32'h0da;
				1: cos_term = -32'h05a;
				2: cos_term = 32'h05a;
				3: cos_term = 32'h0da;
				4: cos_term = 32'h0da;
				5: cos_term = 32'h05a;
				6: cos_term = -32'h05a;
				7: cos_term = -32'h0da;
			endcase
			5: case(n2)
				0: cos_term = -32'h05a;
				1: cos_term = -32'h025;
				2: cos_term = 32'h025;
				3: cos_term = 32'h05a;
				4: cos_term = 32'h05a;
				5: cos_term = 32'h025;
				6: cos_term = -32'h025;
				7: cos_term = -32'h05a;
			endcase
			6: case(n2)
				0: cos_term = 32'h05a;
				1: cos_term = 32'h025;
				2: cos_term = -32'h025;
				3: cos_term = -32'h05a;
				4: cos_term = -32'h05a;
				5: cos_term = -32'h025;
				6: cos_term = 32'h025;
				7: cos_term = 32'h05a;
			endcase
			7: case(n2)
				0: cos_term = 32'h0da;
				1: cos_term = 32'h05a;
				2: cos_term = -32'h05a;
				3: cos_term = -32'h0da;
				4: cos_term = -32'h0da;
				5: cos_term = -32'h05a;
				6: cos_term = 32'h05a;
				7: cos_term = 32'h0da;
			endcase
		endcase
	end
endmodule