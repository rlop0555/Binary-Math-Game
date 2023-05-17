module Timer(Enable, Reconfig, Clock, Reset, Tens, Ones, TimeUp);
	input Enable;
	input Reconfig;
	input Clock, Reset;
	output[3:0] Tens, Ones;
	output TimeUp;

	//Wire for OneSecondTimer to DigitTimer (OnesDigit)
	wire OneSecond;
	//Wire for Ones Digit to ask to borrow
	wire BorrowFromTens;
	//Wire for Tens to answer Ones for borrow
	wire YesOrNo;
	//Wire for PlaceHolder
	wire PlaceHolder;

	OneSecondLFSR OneSecondSignal(Enable, Clock, Reset, OneSecond);

	//Digit Timer for the Ones
	DigitTimer OnesDigit(OneSecond, YesOrNo, Reconfig, Clock, Reset, BorrowFromTens, TimeUp, Ones);
	//Digit Timer for the Tens
	DigitTimer TenthDigit(BorrowFromTens, 1'b0, Reconfig, Clock, Reset, PlaceHolder, YesOrNo, Tens);

endmodule