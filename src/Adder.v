// ECE 5440
// Author: Rogelio Lopez - 2758
// Adder
// Description: This module receives 2 4-bit inputs, adds them, then sends out a 
// 4-bit output as a sum of the two inputs

module Adder(First, Second, Sum);
   input[3:0] First;
   input[3:0] Second;
   output[3:0] Sum;
   reg[3:0] Sum;

   always @ (First, Second)
	begin
	   if((First + Second) >= 16)
	      Sum = 4'b0000;
	   else 
	      Sum = First + Second;
	end

endmodule