module k1_7_k2_5_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h01b;
				1: cos_term = -32'h030;
				2: cos_term = 32'h009;
				3: cos_term = 32'h029;
				4: cos_term = -32'h029;
				5: cos_term = -32'h009;
				6: cos_term = 32'h030;
				7: cos_term = -32'h01b;
			endcase
			1: case(n2)
				0: cos_term = -32'h04f;
				1: cos_term = 32'h08b;
				2: cos_term = -32'h01b;
				3: cos_term = -32'h076;
				4: cos_term = 32'h076;
				5: cos_term = 32'h01b;
				6: cos_term = -32'h08b;
				7: cos_term = 32'h04f;
			endcase
			2: case(n2)
				0: cos_term = 32'h076;
				1: cos_term = -32'h0d0;
				2: cos_term = 32'h029;
				3: cos_term = 32'h0b0;
				4: cos_term = -32'h0b0;
				5: cos_term = -32'h029;
				6: cos_term = 32'h0d0;
				7: cos_term = -32'h076;
			endcase
			3: case(n2)
				0: cos_term = -32'h08b;
				1: cos_term = 32'h0f6;
				2: cos_term = -32'h030;
				3: cos_term = -32'h0d0;
				4: cos_term = 32'h0d0;
				5: cos_term = 32'h030;
				6: cos_term = -32'h0f6;
				7: cos_term = 32'h08b;
			endcase
			4: case(n2)
				0: cos_term = 32'h08b;
				1: cos_term = -32'h0f6;
				2: cos_term = 32'h030;
				3: cos_term = 32'h0d0;
				4: cos_term = -32'h0d0;
				5: cos_term = -32'h030;
				6: cos_term = 32'h0f6;
				7: cos_term = -32'h08b;
			endcase
			5: case(n2)
				0: cos_term = -32'h076;
				1: cos_term = 32'h0d0;
				2: cos_term = -32'h029;
				3: cos_term = -32'h0b0;
				4: cos_term = 32'h0b0;
				5: cos_term = 32'h029;
				6: cos_term = -32'h0d0;
				7: cos_term = 32'h076;
			endcase
			6: case(n2)
				0: cos_term = 32'h04f;
				1: cos_term = -32'h08b;
				2: cos_term = 32'h01b;
				3: cos_term = 32'h076;
				4: cos_term = -32'h076;
				5: cos_term = -32'h01b;
				6: cos_term = 32'h08b;
				7: cos_term = -32'h04f;
			endcase
			7: case(n2)
				0: cos_term = -32'h01b;
				1: cos_term = 32'h030;
				2: cos_term = -32'h009;
				3: cos_term = -32'h029;
				4: cos_term = 32'h029;
				5: cos_term = 32'h009;
				6: cos_term = -32'h030;
				7: cos_term = 32'h01b;
			endcase
		endcase
	end
endmodule