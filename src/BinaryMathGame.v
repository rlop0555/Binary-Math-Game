// ECE 5440
// Author: Rogelio Lopez - 2758
// BinaryMathGame
// Description: This module is the top-level module. This connects all the different components together to make
// the game possible. Player One enters their input, that input goes into a decoder which then sends a signal
// to a 7-segment display that displays their input. Player Two enters their input attempting to add both their
// inputs to 15. Their inputs are sent to an adder which then adds their inputs and sends them to another 7-segment
// display  to display the sum. If their sum is 15, an LED on the left-hand side lights up. If their sum is not 15, 
// an LED on the right-hand side lights up

module BinaryMathGame(Player, Password, Reset, Clock, PlayerLoad, RNGButton, GameButton, PlayerDisplay,
				RNGDisplay, Result, Match, SignedIn, SignedOut, OnesDisplay, TensDisplay);

	/////////////Switches/////////////
	input[3:0] Player;
	input[3:0] Password;

	/////////////Buttons//////////////
	input Reset, PlayerLoad, RNGButton, GameButton;

	/////////////Clock//////////////
	input Clock;

	////////////7-Segment Displays///////////////
	output[6:0] PlayerDisplay;
	output[6:0] RNGDisplay;
	output[6:0] Result;

	output[6:0] OnesDisplay;
	output[6:0] TensDisplay;

	///////////////LEDs/////////////////
	output[1:0] Match;
	output SignedIn, SignedOut;
	
	///////////////Wires/////////////////
	//Adder to Verification and Deocder
	wire[3:0] AdderSum;
	//Access Controller to Load Register
	wire LoadAccess;
	//Access Controller to RNG
	wire RNGAccess;

	//Load Register to Adder and Decoder
	wire [3:0] PlayerVal;
	//RNG to Adder and Decoder
	wire [3:0] RNGVal;

	//Player 1 Load to Access Controller
	wire PLoadIn;
	//GameButton to Access Controller
	wire GameWire;

	//Timer to Access Controller
	wire TimeUp;
	//Access Controller to Timer
	wire EnableSignal;
	//AccessController to Timer
	wire Reconfig;

	//Timer Digits
	wire [3:0] Ones;
	wire [3:0] Tens;


	/////////////////////Buttons///////////////////////
	//GameButton Button
	ButtonShaper EnterButton(GameButton, Clock, Reset, GameWire);
	//Player Load Button
	ButtonShaper LoadButton1(PlayerLoad, Clock, Reset, PLoadIn);

	//Access Controller
	AccessController AccessControl(GameWire, Password, Clock, Reset, TimeUp, EnableSignal, Reconfig, PLoadIn, 
		LoadAccess, RNGButton, RNGAccess, SignedIn, SignedOut);

	//Random Number Generator Decoder
	RNG_LFSR RandomNumGenerator(RNGAccess, Clock, Reset, RNGVal);
	SevenSegDecoder RNGDecoder(RNGVal, RNGDisplay);

	//Adder
	Adder AdderModule(PlayerVal, RNGVal, AdderSum);
	Verification Verification1(AdderSum, Match);

	//Player Decoder
	LoadRegister PlayerOneLoad(Player, PlayerVal, Clock, Reset, LoadAccess);
	SevenSegDecoder PlayerDecoder(PlayerVal, PlayerDisplay);

	//Adder Decoder
	SevenSegDecoder AdderResult(AdderSum, Result);

	////////////////////////////////TIMER////////////////////////////////////////////
	Timer CountdownTimer(EnableSignal, Reconfig, Clock, Reset, Tens, Ones, TimeUp);

	//Seven Segment Decoder for Timer
	SevenSegDecoder OnesDigitDisplay(Ones, OnesDisplay);
	SevenSegDecoder TensDigitDisplay(Tens, TensDisplay);
	
endmodule