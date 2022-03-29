module k1_5_k2_1_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h08b;
				1: cos_term = 32'h076;
				2: cos_term = 32'h04f;
				3: cos_term = 32'h01b;
				4: cos_term = -32'h01b;
				5: cos_term = -32'h04f;
				6: cos_term = -32'h076;
				7: cos_term = -32'h08b;
			endcase
			1: case(n2)
				0: cos_term = -32'h0f6;
				1: cos_term = -32'h0d0;
				2: cos_term = -32'h08b;
				3: cos_term = -32'h030;
				4: cos_term = 32'h030;
				5: cos_term = 32'h08b;
				6: cos_term = 32'h0d0;
				7: cos_term = 32'h0f6;
			endcase
			2: case(n2)
				0: cos_term = 32'h030;
				1: cos_term = 32'h029;
				2: cos_term = 32'h01b;
				3: cos_term = 32'h009;
				4: cos_term = -32'h009;
				5: cos_term = -32'h01b;
				6: cos_term = -32'h029;
				7: cos_term = -32'h030;
			endcase
			3: case(n2)
				0: cos_term = 32'h0d0;
				1: cos_term = 32'h0b0;
				2: cos_term = 32'h076;
				3: cos_term = 32'h029;
				4: cos_term = -32'h029;
				5: cos_term = -32'h076;
				6: cos_term = -32'h0b0;
				7: cos_term = -32'h0d0;
			endcase
			4: case(n2)
				0: cos_term = -32'h0d0;
				1: cos_term = -32'h0b0;
				2: cos_term = -32'h076;
				3: cos_term = -32'h029;
				4: cos_term = 32'h029;
				5: cos_term = 32'h076;
				6: cos_term = 32'h0b0;
				7: cos_term = 32'h0d0;
			endcase
			5: case(n2)
				0: cos_term = -32'h030;
				1: cos_term = -32'h029;
				2: cos_term = -32'h01b;
				3: cos_term = -32'h009;
				4: cos_term = 32'h009;
				5: cos_term = 32'h01b;
				6: cos_term = 32'h029;
				7: cos_term = 32'h030;
			endcase
			6: case(n2)
				0: cos_term = 32'h0f6;
				1: cos_term = 32'h0d0;
				2: cos_term = 32'h08b;
				3: cos_term = 32'h030;
				4: cos_term = -32'h030;
				5: cos_term = -32'h08b;
				6: cos_term = -32'h0d0;
				7: cos_term = -32'h0f6;
			endcase
			7: case(n2)
				0: cos_term = -32'h08b;
				1: cos_term = -32'h076;
				2: cos_term = -32'h04f;
				3: cos_term = -32'h01b;
				4: cos_term = 32'h01b;
				5: cos_term = 32'h04f;
				6: cos_term = 32'h076;
				7: cos_term = 32'h08b;
			endcase
		endcase
	end
endmodule