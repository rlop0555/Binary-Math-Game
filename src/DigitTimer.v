module DigitTimer(Decrement, YorN, Reconfig, Clock, Reset, BorrowAsk, BorrowAnswer, Value);
	input Decrement;
	input YorN;
	input Clock, Reset;
	input Reconfig;
	output BorrowAsk;
	output BorrowAnswer;
	output [3:0] Value;

	reg [3:0] Value;
	reg BorrowAsk;
	reg BorrowAnswer;

	always@(posedge Clock)
		begin
			if(Reset == 1'b0)
				begin
					Value = 4'b0000;
					BorrowAsk = 0;
					BorrowAnswer = 0;
				end
			else if(Reconfig == 1'b1)
				begin
					Value <= 4'b1001;
					BorrowAnswer <= 1'b1;
					BorrowAsk <= 1'b0;
				end
			else 
				begin
					//If we get a signal to decrement the value
					if(Decrement == 1'b1)
						begin
							//If our value is 0, check to see if we can borrow from next digit
							if(Value == 4'b0000)
								begin
									//If we can't borrow
									if(YorN == 1'b0)
										begin
											BorrowAsk <= 1'b0;
											BorrowAnswer <= 1'b0;
										end
									//If we can borrow
									else 
										begin
											//Ask to Borrow
											BorrowAsk <= 1'b1;
											Value <= 4'b1001;
											BorrowAnswer <= 1'b1;
										end
								end
							//If our value is greater than 0, subtract 1
							else
								begin
									Value <= Value - 1;
									//If our value is 1 before subtraction and we cannot 
									//borrow from the next digit, this digit cannot let
									//another digit borrow
									if(Value == 4'b0001 & YorN == 1'b0)
										begin		
											BorrowAnswer <= 1'b0;	
										end
									else 
										begin
											BorrowAnswer <= 1'b1;
										end
								end
						end
					else 
						begin
							BorrowAsk <= 0;
						end
				end
		end
		
endmodule
