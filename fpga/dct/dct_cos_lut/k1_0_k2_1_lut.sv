module k1_0_k2_1_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			1: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			2: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			3: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			4: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			5: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			6: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
			7: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0fb;
			endcase
		endcase
	end
endmodule