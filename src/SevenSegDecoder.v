// ECE 5440
// Author: Rogelio Lopez - 2758
// 7-Segment Decoder
// Description: This module receives a 4-bit input to send out a 7-bit signal 
// to a 7-segment display that displays the 4-bit input as an integer

module SevenSegDecoder (Decoder_in, Decoder_out);

   input [3:0]Decoder_in;
   output [6:0]Decoder_out;
   reg [6:0]Decoder_out;
   
   always @ (Decoder_in)
	begin
	   case(Decoder_in)
		4'b0000: begin Decoder_out = 7'b1000000; end
		4'b0001: begin Decoder_out = 7'b1111001; end
		4'b0010: begin Decoder_out = 7'b0100100; end
		4'b0011: begin Decoder_out = 7'b0110000; end

		4'b0100: begin Decoder_out = 7'b0011001; end
		4'b0101: begin Decoder_out = 7'b0010010; end
		4'b0110: begin Decoder_out = 7'b0000010; end
		4'b0111: begin Decoder_out = 7'b1111000; end

		4'b1000: begin Decoder_out = 7'b000_0000; end
		4'b1001: begin Decoder_out = 7'b001_1000; end
		4'b1010: begin Decoder_out = 7'b000_1000; end
		4'b1011: begin Decoder_out = 7'b000_0011; end

		4'b1100: begin Decoder_out = 7'b100_0110; end
		4'b1101: begin Decoder_out = 7'b010_0001; end
		4'b1110: begin Decoder_out = 7'b000_0110; end
		4'b1111: begin Decoder_out = 7'b000_1110; end

		default: begin Decoder_out = 7'b100_0000; end
	   endcase
	end
endmodule
