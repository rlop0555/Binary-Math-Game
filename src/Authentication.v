// ECE 5440
// Author: Rogelio Lopez - 2758
// Access Controller
// This module is our access controller which adds a security feature to our game.
// No one will be allowed to play unless unlocking access through authentication.

module Authentication(Clock, Reset, LogOff, PasswordDigit, Button, Digit, Address, Passed, LoggedIn, LoggedOut);
	input Button;
	input Clock, Reset;
	input [3:0] Digit;
	input [3:0] PasswordDigit;
	input LogOff;

	output Passed;
	output [4:0] Address;
	output LoggedIn;
	output LoggedOut;
	
	reg Passed;
	reg [4:0] Address;
	reg LoggedIn;
	reg LoggedOut;
	reg Invalid;

	parameter DIGIT = 0, ADDRESS = 1, RECIEVE = 2, COMPARE = 3, VERIFY = 4, PASSED = 5;
	reg [2:0] State;
	reg [4:0] Counter;
	reg Wait;

	always @ (posedge Clock)
		begin
			if(Reset == 1'b0 | LogOff == 1'b1)
				begin
					Passed <= 1'b0;
					Invalid <= 1'b0;
					Counter <= 5'b00000;
					State <= DIGIT;
					Wait <= 1'b0;
					LoggedIn <= 1'b0;
					LoggedOut <= 1'b1;
				end
			else 
				begin
					case (State)
					DIGIT: 
						begin
							LoggedIn <= 1'b0;
							LoggedOut <= 1'b1;
							Passed <= 1'b0;
							if(Button == 1'b1)
								begin
									State <= ADDRESS;
								end
							else
								begin
									State <= DIGIT;
								end
						end
					ADDRESS:
						begin
							Address <= Counter;
							State <= RECIEVE;
						end
					RECIEVE:
						begin
							if(Wait == 1'b1)
								begin
									Wait <= 1'b0;
									State <= COMPARE;
								end
							else 
								begin
									Wait <= Wait + 1;
								end
						end
					COMPARE:
						begin
							if(Digit == PasswordDigit)
								begin
									
								end
							else
								begin
									Invalid <= 1'b1;
								end

							if(Counter == 5'b00011)
								begin
									State <= VERIFY;
								end
							else 
								begin
									Counter <= Counter + 1;
									State <= DIGIT;
								end
						end
					VERIFY:
						begin
							if(Invalid == 1'b1)
								begin
									State <= DIGIT;
								end
							else 
								begin
									State <= PASSED;
								end

							Counter <= 5'b00000;
							Invalid <= 1'b0;
						end
					PASSED:
						begin
							LoggedIn <= 1'b1;
							LoggedOut <= 1'b0;
							Passed <= 1'b1;
							if(LogOff == 1'b1)
								begin
									State <= DIGIT;
								end
						end
					default: 
						begin
							Passed <= 1'b0;
							Invalid <= 1'b0;
							Counter <= 5'b00000;
							LoggedIn <= 1'b0;
							LoggedOut <= 1'b1;
						end
					endcase
				end
		end
endmodule