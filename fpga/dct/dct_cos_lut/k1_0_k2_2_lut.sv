module k1_0_k2_2_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			1: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			2: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			3: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			4: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			5: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			6: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
			7: case(n2)
				0: cos_term = 32'h0ec;
				1: cos_term = 32'h062;
				2: cos_term = -32'h062;
				3: cos_term = -32'h0ec;
				4: cos_term = -32'h0ec;
				5: cos_term = -32'h062;
				6: cos_term = 32'h062;
				7: cos_term = 32'h0ec;
			endcase
		endcase
	end
endmodule