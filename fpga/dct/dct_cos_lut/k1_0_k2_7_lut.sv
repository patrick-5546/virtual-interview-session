module k1_0_k2_7_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			1: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			2: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			3: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			4: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			5: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			6: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
			7: case(n2)
				0: cos_term = 32'h031;
				1: cos_term = -32'h08e;
				2: cos_term = 32'h0d4;
				3: cos_term = -32'h0fb;
				4: cos_term = 32'h0fb;
				5: cos_term = -32'h0d4;
				6: cos_term = 32'h08e;
				7: cos_term = -32'h031;
			endcase
		endcase
	end
endmodule