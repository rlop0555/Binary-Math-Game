module CounterLFSR(Enable, Clock, Reset, Number);
	input Enable;
	input Clock, Reset;

	output [3:0] Number;

	reg [3:0] Number;
	reg [3:0] LFSR;
	wire feedback = LFSR[3];

	always@(posedge Clock)
		begin
			if(Reset == 1'b0)
				begin
					Number <= 4'b0000;
					LFSR <= 4'b0000;
				end
			else if(Enable == 1'b1)
				begin
					Number <= LFSR; 		
				end
			else 
				begin
					if(LFSR == 4'b0001) 
						begin
							LFSR <= 4'b0000;
						end
					else
						begin
							LFSR[0] <= feedback;
							LFSR[1] <= LFSR[0] ~^ feedback;
							LFSR[2] <= LFSR[1];
							LFSR[3] <= LFSR[2];
						end 
				end
		end

endmodule