// ECE 5440
// Author: Rogelio Lopez - 2758
// Load Register
// This module prevents the 7-segment displays from displaying a value each time a switch is flipped.
//  Instead, a used must now send a load signal for their value to display

module LoadRegister(Value_in, Value_out, Clock, Reset, Load);
   input [3:0] Value_in;
   input Clock, Reset;
   input Load;
   output [3:0] Value_out;


   reg [3:0] Value_out;

   always@(posedge Clock)
	begin
	   if(Reset == 1'b0)
		begin
			Value_out <= 4'b0000;
		end
	   else 
		begin
			if(Load == 1'b1)
		   		begin
		   			Value_out <= Value_in;		
		   		end
		end
	end
endmodule
