module k1_4_k2_4_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h08;
				1: cos_term = -32'h08;
				2: cos_term = -32'h08;
				3: cos_term = 32'h08;
				4: cos_term = 32'h08;
				5: cos_term = -32'h08;
				6: cos_term = -32'h08;
				7: cos_term = 32'h08;
			endcase
			1: case(n2)
				0: cos_term = -32'h08;
				1: cos_term = 32'h08;
				2: cos_term = 32'h08;
				3: cos_term = -32'h08;
				4: cos_term = -32'h08;
				5: cos_term = 32'h08;
				6: cos_term = 32'h08;
				7: cos_term = -32'h08;
			endcase
			2: case(n2)
				0: cos_term = -32'h08;
				1: cos_term = 32'h08;
				2: cos_term = 32'h08;
				3: cos_term = -32'h08;
				4: cos_term = -32'h08;
				5: cos_term = 32'h08;
				6: cos_term = 32'h08;
				7: cos_term = -32'h08;
			endcase
			3: case(n2)
				0: cos_term = 32'h08;
				1: cos_term = -32'h08;
				2: cos_term = -32'h08;
				3: cos_term = 32'h08;
				4: cos_term = 32'h08;
				5: cos_term = -32'h08;
				6: cos_term = -32'h08;
				7: cos_term = 32'h08;
			endcase
			4: case(n2)
				0: cos_term = 32'h08;
				1: cos_term = -32'h08;
				2: cos_term = -32'h08;
				3: cos_term = 32'h08;
				4: cos_term = 32'h08;
				5: cos_term = -32'h08;
				6: cos_term = -32'h08;
				7: cos_term = 32'h08;
			endcase
			5: case(n2)
				0: cos_term = -32'h08;
				1: cos_term = 32'h08;
				2: cos_term = 32'h08;
				3: cos_term = -32'h08;
				4: cos_term = -32'h08;
				5: cos_term = 32'h08;
				6: cos_term = 32'h08;
				7: cos_term = -32'h08;
			endcase
			6: case(n2)
				0: cos_term = -32'h08;
				1: cos_term = 32'h08;
				2: cos_term = 32'h08;
				3: cos_term = -32'h08;
				4: cos_term = -32'h08;
				5: cos_term = 32'h08;
				6: cos_term = 32'h08;
				7: cos_term = -32'h08;
			endcase
			7: case(n2)
				0: cos_term = 32'h08;
				1: cos_term = -32'h08;
				2: cos_term = -32'h08;
				3: cos_term = 32'h08;
				4: cos_term = 32'h08;
				5: cos_term = -32'h08;
				6: cos_term = -32'h08;
				7: cos_term = 32'h08;
			endcase
		endcase
	end
endmodule