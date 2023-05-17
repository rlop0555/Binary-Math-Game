// ECE 5440
// Author: Rogelio Lopez - 2758
// Button Shaper
// The button shaper is used to adjust the signal of pressing a button 
// to a single cycle pulse


module ButtonShaper(Bin, Clock, Reset, Bout);
	input Bin;
	input Clock, Reset;
	output Bout;
	reg Bout;

	parameter INIT = 0, PULSE = 1, WAIT = 2;
	reg [1:0] State, StateNext;

	always @(State, Bin) 
	   begin
		case(State)
		INIT: 
		begin
			Bout = 1'b0;
			if(Bin == 1'b0)	
				StateNext = PULSE;
			else 
				StateNext = INIT;
		end	
		PULSE:
		begin
			Bout = 1'b1;
			StateNext = WAIT;
		end
		WAIT:
		begin
			Bout = 1'b0;
			if(Bin == 1'b1)
				StateNext = INIT;
			else 	
				StateNext = WAIT;
		end
		endcase
	   end

	always @(posedge Clock)
	   begin
		if(Reset == 1'b0)
			State <= INIT;
		else 
			State <= StateNext;
	   end

endmodule
			      
