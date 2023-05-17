module OneSecondLFSR(EnableSignal, Clock, Reset, OneSecond);

	input EnableSignal;
	input Clock, Reset;
	output OneSecond;
	
	//Wire for OneMillisecond to CountTo100
	wire OneMSWire;
	//Wire for CountTo10
	wire OneHundredMSWire;
	
	OneMillisecondLFSR OneMS(EnableSignal, Clock, Reset, OneMSWire);
	
	HundredMSLFSR Count100(OneMSWire, Clock, Reset, OneHundredMSWire);

	CountTo10LFSR Count10(OneHundredMSWire, Clock, Reset, OneSecond);

endmodule
	