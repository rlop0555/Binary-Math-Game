module HundredMSLFSR(EnableSignal, Clock, Reset, HundredMS);

	input EnableSignal;
	input Clock, Reset;
	output HundredMS;

	reg HundredMS;
	reg [6:0] LFSR;
	wire feedback = LFSR[6];

	always @ (posedge Clock)
		begin
			if(Reset == 1'b0)
				begin
					LFSR <= 7'b111_1111;
					HundredMS <= 1'b0;
				end
			else if(EnableSignal == 1'b1)
				begin
					if(LFSR == 7'b110_1000) 
						begin
							LFSR <= 7'b111_1111;
							HundredMS <= 1'b1;
						end
					else
						begin
							LFSR[0] <= feedback;
							LFSR[1] <= LFSR[0] ^ feedback;
							LFSR[2] <= LFSR[1];
							LFSR[3] <= LFSR[2];
							LFSR[4] <= LFSR[3];
							LFSR[5] <= LFSR[4];
							LFSR[6] <= LFSR[5];

							HundredMS <= 1'b0;
						end
				end
			else
				begin
					HundredMS <= 1'b0;
				end
		end

endmodule