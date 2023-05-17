module RNG_LFSR(RNG_signal, Clock, Reset, RandomNumber);
	input RNG_signal;
	input Clock, Reset;

	output [3:0] RandomNumber;

	CounterLFSR CounterRNG(~RNG_signal, Clock, Reset, RandomNumber);

endmodule
		
