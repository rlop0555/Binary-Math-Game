// ECE 5440
// Author: Rogelio Lopez - 2758
// Access Controller
// This module is our access controller which adds a security feature to our game.
// No one will be allowed to play unless unlocking access through authentication.

module AccessController(Button, Value, Clock, Reset, TimeUp, Enable, Reconfig, LoadIn, LoadOut, RNGIn, RNGOut, LoggedIn, LoggedOut);
	input Button;
	input Clock, Reset;
	input [4:0] Value;
	input TimeUp;
	input LoadIn;
	input RNGIn;

	output Enable;
	output LoadOut;
	output Reconfig;
	output RNGOut;
	output LoggedIn, LoggedOut;


	//Wire for Authentication to ROM
	wire [4:0] ROM_In;
	//Wire for ROM to Authentication
	wire [3:0] ROM_Out;

	//Wire for Authentication to GamerControl
	wire Access;

	//Wire for GamerControl to Authentication
	wire LogOut;

	Authentication AuthenticationControl(Clock, Reset, LogOut, ROM_Out, Button, Value, ROM_In, Access, LoggedIn, LoggedOut);
	ROM ROMPassword(ROM_In, Clock, ROM_Out);
	GameController GameControl(Clock, Reset, Access, Button, TimeUp, Enable, Reconfig, LoadIn, LoadOut, RNGIn, RNGOut, LogOut);
	
endmodule