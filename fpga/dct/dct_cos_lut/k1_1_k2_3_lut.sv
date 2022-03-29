module k1_1_k2_3_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0d0;
				1: cos_term = -32'h030;
				2: cos_term = -32'h0f6;
				3: cos_term = -32'h08b;
				4: cos_term = 32'h08b;
				5: cos_term = 32'h0f6;
				6: cos_term = 32'h030;
				7: cos_term = -32'h0d0;
			endcase
			1: case(n2)
				0: cos_term = 32'h0b0;
				1: cos_term = -32'h029;
				2: cos_term = -32'h0d0;
				3: cos_term = -32'h076;
				4: cos_term = 32'h076;
				5: cos_term = 32'h0d0;
				6: cos_term = 32'h029;
				7: cos_term = -32'h0b0;
			endcase
			2: case(n2)
				0: cos_term = 32'h076;
				1: cos_term = -32'h01b;
				2: cos_term = -32'h08b;
				3: cos_term = -32'h04f;
				4: cos_term = 32'h04f;
				5: cos_term = 32'h08b;
				6: cos_term = 32'h01b;
				7: cos_term = -32'h076;
			endcase
			3: case(n2)
				0: cos_term = 32'h029;
				1: cos_term = -32'h009;
				2: cos_term = -32'h030;
				3: cos_term = -32'h01b;
				4: cos_term = 32'h01b;
				5: cos_term = 32'h030;
				6: cos_term = 32'h009;
				7: cos_term = -32'h029;
			endcase
			4: case(n2)
				0: cos_term = -32'h029;
				1: cos_term = 32'h009;
				2: cos_term = 32'h030;
				3: cos_term = 32'h01b;
				4: cos_term = -32'h01b;
				5: cos_term = -32'h030;
				6: cos_term = -32'h009;
				7: cos_term = 32'h029;
			endcase
			5: case(n2)
				0: cos_term = -32'h076;
				1: cos_term = 32'h01b;
				2: cos_term = 32'h08b;
				3: cos_term = 32'h04f;
				4: cos_term = -32'h04f;
				5: cos_term = -32'h08b;
				6: cos_term = -32'h01b;
				7: cos_term = 32'h076;
			endcase
			6: case(n2)
				0: cos_term = -32'h0b0;
				1: cos_term = 32'h029;
				2: cos_term = 32'h0d0;
				3: cos_term = 32'h076;
				4: cos_term = -32'h076;
				5: cos_term = -32'h0d0;
				6: cos_term = -32'h029;
				7: cos_term = 32'h0b0;
			endcase
			7: case(n2)
				0: cos_term = -32'h0d0;
				1: cos_term = 32'h030;
				2: cos_term = 32'h0f6;
				3: cos_term = 32'h08b;
				4: cos_term = -32'h08b;
				5: cos_term = -32'h0f6;
				6: cos_term = -32'h030;
				7: cos_term = 32'h0d0;
			endcase
		endcase
	end
endmodule