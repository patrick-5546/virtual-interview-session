module k1_1_k2_4_lut(input logic [2:0] n1, [2:0] n2, output logic [31:0] cos_term);
	always_comb begin
		case(n1)
			0: case(n2)
				0: cos_term = 32'h0b1;
				1: cos_term = -32'h0b1;
				2: cos_term = -32'h0b1;
				3: cos_term = 32'h0b1;
				4: cos_term = 32'h0b1;
				5: cos_term = -32'h0b1;
				6: cos_term = -32'h0b1;
				7: cos_term = 32'h0b1;
			endcase
			1: case(n2)
				0: cos_term = 32'h096;
				1: cos_term = -32'h096;
				2: cos_term = -32'h096;
				3: cos_term = 32'h096;
				4: cos_term = 32'h096;
				5: cos_term = -32'h096;
				6: cos_term = -32'h096;
				7: cos_term = 32'h096;
			endcase
			2: case(n2)
				0: cos_term = 32'h064;
				1: cos_term = -32'h064;
				2: cos_term = -32'h064;
				3: cos_term = 32'h064;
				4: cos_term = 32'h064;
				5: cos_term = -32'h064;
				6: cos_term = -32'h064;
				7: cos_term = 32'h064;
			endcase
			3: case(n2)
				0: cos_term = 32'h023;
				1: cos_term = -32'h023;
				2: cos_term = -32'h023;
				3: cos_term = 32'h023;
				4: cos_term = 32'h023;
				5: cos_term = -32'h023;
				6: cos_term = -32'h023;
				7: cos_term = 32'h023;
			endcase
			4: case(n2)
				0: cos_term = -32'h023;
				1: cos_term = 32'h023;
				2: cos_term = 32'h023;
				3: cos_term = -32'h023;
				4: cos_term = -32'h023;
				5: cos_term = 32'h023;
				6: cos_term = 32'h023;
				7: cos_term = -32'h023;
			endcase
			5: case(n2)
				0: cos_term = -32'h064;
				1: cos_term = 32'h064;
				2: cos_term = 32'h064;
				3: cos_term = -32'h064;
				4: cos_term = -32'h064;
				5: cos_term = 32'h064;
				6: cos_term = 32'h064;
				7: cos_term = -32'h064;
			endcase
			6: case(n2)
				0: cos_term = -32'h096;
				1: cos_term = 32'h096;
				2: cos_term = 32'h096;
				3: cos_term = -32'h096;
				4: cos_term = -32'h096;
				5: cos_term = 32'h096;
				6: cos_term = 32'h096;
				7: cos_term = -32'h096;
			endcase
			7: case(n2)
				0: cos_term = -32'h0b1;
				1: cos_term = 32'h0b1;
				2: cos_term = 32'h0b1;
				3: cos_term = -32'h0b1;
				4: cos_term = -32'h0b1;
				5: cos_term = 32'h0b1;
				6: cos_term = 32'h0b1;
				7: cos_term = -32'h0b1;
			endcase
		endcase
	end
endmodule