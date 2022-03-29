module k1_5_k2_7_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h01b;
				1: cos_term = -32'h04f;
				2: cos_term = 32'h076;
				3: cos_term = -32'h08b;
				4: cos_term = 32'h08b;
				5: cos_term = -32'h076;
				6: cos_term = 32'h04f;
				7: cos_term = -32'h01b;
			endcase
			1: case(n2)
				0: cos_term = -32'h030;
				1: cos_term = 32'h08b;
				2: cos_term = -32'h0d0;
				3: cos_term = 32'h0f6;
				4: cos_term = -32'h0f6;
				5: cos_term = 32'h0d0;
				6: cos_term = -32'h08b;
				7: cos_term = 32'h030;
			endcase
			2: case(n2)
				0: cos_term = 32'h009;
				1: cos_term = -32'h01b;
				2: cos_term = 32'h029;
				3: cos_term = -32'h030;
				4: cos_term = 32'h030;
				5: cos_term = -32'h029;
				6: cos_term = 32'h01b;
				7: cos_term = -32'h009;
			endcase
			3: case(n2)
				0: cos_term = 32'h029;
				1: cos_term = -32'h076;
				2: cos_term = 32'h0b0;
				3: cos_term = -32'h0d0;
				4: cos_term = 32'h0d0;
				5: cos_term = -32'h0b0;
				6: cos_term = 32'h076;
				7: cos_term = -32'h029;
			endcase
			4: case(n2)
				0: cos_term = -32'h029;
				1: cos_term = 32'h076;
				2: cos_term = -32'h0b0;
				3: cos_term = 32'h0d0;
				4: cos_term = -32'h0d0;
				5: cos_term = 32'h0b0;
				6: cos_term = -32'h076;
				7: cos_term = 32'h029;
			endcase
			5: case(n2)
				0: cos_term = -32'h009;
				1: cos_term = 32'h01b;
				2: cos_term = -32'h029;
				3: cos_term = 32'h030;
				4: cos_term = -32'h030;
				5: cos_term = 32'h029;
				6: cos_term = -32'h01b;
				7: cos_term = 32'h009;
			endcase
			6: case(n2)
				0: cos_term = 32'h030;
				1: cos_term = -32'h08b;
				2: cos_term = 32'h0d0;
				3: cos_term = -32'h0f6;
				4: cos_term = 32'h0f6;
				5: cos_term = -32'h0d0;
				6: cos_term = 32'h08b;
				7: cos_term = -32'h030;
			endcase
			7: case(n2)
				0: cos_term = -32'h01b;
				1: cos_term = 32'h04f;
				2: cos_term = -32'h076;
				3: cos_term = 32'h08b;
				4: cos_term = -32'h08b;
				5: cos_term = 32'h076;
				6: cos_term = -32'h04f;
				7: cos_term = 32'h01b;
			endcase
		endcase
	end
endmodule