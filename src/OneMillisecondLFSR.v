module OneMillisecondLFSR(EnableSignal, Clock, Reset, Millisecond);

	input EnableSignal;
	input Clock, Reset;
	output Millisecond;

	reg Millisecond;
	reg [15:0] LFSR;
	wire feedback = LFSR[15];

	always @ (posedge Clock)
		begin
			if(Reset == 1'b0)
				begin
					LFSR <= 16'b1111_1111_1111_1111;
					Millisecond <= 1'b0;
				end
			else if(EnableSignal == 1'b1)
				begin
					if(LFSR == 16'b0110_1101_1011_0110) 
						begin
							LFSR <= 16'b1111_1111_1111_1111;
							Millisecond <= 1'b1;
						end
					else
						begin
							LFSR[0] <= feedback;
							LFSR[1] <= LFSR[0];
							LFSR[2] <= LFSR[1] ^ feedback;
							LFSR[3] <= LFSR[2] ^ feedback;
							LFSR[4] <= LFSR[3];
							LFSR[5] <= LFSR[4] ^ feedback;
							LFSR[6] <= LFSR[5];
							LFSR[7] <= LFSR[6];
							LFSR[8] <= LFSR[7];
							LFSR[9] <= LFSR[8];
							LFSR[10] <= LFSR[9];
							LFSR[11] <= LFSR[10];
							LFSR[12] <= LFSR[11];
							LFSR[13] <= LFSR[12];
							LFSR[14] <= LFSR[13];
							LFSR[15] <= LFSR[14];

							Millisecond <= 1'b0;
						end
				end
		end

endmodule