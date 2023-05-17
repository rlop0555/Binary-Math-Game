module CountTo10LFSR(EnableSignal, Clock, Reset, Ten);
	input EnableSignal;
	input Clock, Reset;
	output Ten;

	reg Ten;
	reg [3:0] LFSR;
	wire feedback = LFSR[3];

	always @ (posedge Clock)
		begin
			if(Reset == 1'b0)
				begin
					LFSR <= 4'b1111;
					Ten <= 1'b0;
				end
			else if(EnableSignal == 1'b1)
				begin
					if(LFSR == 4'b1100) 
						begin
							LFSR <= 4'b1111;
							Ten <= 1'b1;
						end
					else
						begin
						    LFSR[0] <= feedback;
							LFSR[1] <= LFSR[0] ^ feedback;
							LFSR[2] <= LFSR[1];
							LFSR[3] <= LFSR[2];

							Ten <= 1'b0;
						end
				end
			else
				begin
					Ten <= 1'b0;
				end
		end

endmodule