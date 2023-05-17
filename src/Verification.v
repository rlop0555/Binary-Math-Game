// ECE 5440
// Author: Rogelio Lopez - 2758
// Verification
// Description: This module receives a 4-bit input to send out a 2-bit signal
// that verifies whether the sum is equal to 15 or not. The 2-bit signal is 
// sent to 2 LEDs which illustrate whether the sum is 15 or not.

module Verification(Sum, LEDs);
	input[3:0] Sum;
	output[1:0] LEDs;
	reg[1:0] LEDs;
	
	always @(Sum)
	begin
		if(Sum < 15)
			LEDs = 2'b01;
		else 
			LEDs = 2'b10;
	end
endmodule