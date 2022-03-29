module k1_1_k2_0_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0fb;
				1: cos_term = 32'h0fb;
				2: cos_term = 32'h0fb;
				3: cos_term = 32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = 32'h0fb;
				6: cos_term = 32'h0fb;
				7: cos_term = 32'h0fb;
			endcase
			1: case(n2)
				0: cos_term = 32'h0d4;
				1: cos_term = 32'h0d4;
				2: cos_term = 32'h0d4;
				3: cos_term = 32'h0d4;
				4: cos_term = 32'h0d4;
				5: cos_term = 32'h0d4;
				6: cos_term = 32'h0d4;
				7: cos_term = 32'h0d4;
			endcase
			2: case(n2)
				0: cos_term = 32'h08e;
				1: cos_term = 32'h08e;
				2: cos_term = 32'h08e;
				3: cos_term = 32'h08e;
				4: cos_term = 32'h08e;
				5: cos_term = 32'h08e;
				6: cos_term = 32'h08e;
				7: cos_term = 32'h08e;
			endcase
			3: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = 32'h031;
				2: cos_term = 32'h031;
				3: cos_term = 32'h031;
				4: cos_term = 32'h031;
				5: cos_term = 32'h031;
				6: cos_term = 32'h031;
				7: cos_term = 32'h031;
			endcase
			4: case(n2)
				0: cos_term = -32'h031;
				1: cos_term = -32'h031;
				2: cos_term = -32'h031;
				3: cos_term = -32'h031;
				4: cos_term = -32'h031;
				5: cos_term = -32'h031;
				6: cos_term = -32'h031;
				7: cos_term = -32'h031;
			endcase
			5: case(n2)
				0: cos_term = -32'h08e;
				1: cos_term = -32'h08e;
				2: cos_term = -32'h08e;
				3: cos_term = -32'h08e;
				4: cos_term = -32'h08e;
				5: cos_term = -32'h08e;
				6: cos_term = -32'h08e;
				7: cos_term = -32'h08e;
			endcase
			6: case(n2)
				0: cos_term = -32'h0d4;
				1: cos_term = -32'h0d4;
				2: cos_term = -32'h0d4;
				3: cos_term = -32'h0d4;
				4: cos_term = -32'h0d4;
				5: cos_term = -32'h0d4;
				6: cos_term = -32'h0d4;
				7: cos_term = -32'h0d4;
			endcase
			7: case(n2)
				0: cos_term = -32'h0fb;
				1: cos_term = -32'h0fb;
				2: cos_term = -32'h0fb;
				3: cos_term = -32'h0fb;
				4: cos_term = -32'h0fb;
				5: cos_term = -32'h0fb;
				6: cos_term = -32'h0fb;
				7: cos_term = -32'h0fb;
			endcase
		endcase
	end
endmodule