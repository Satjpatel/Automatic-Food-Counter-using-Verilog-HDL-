//A Verilog HDL Code for an automatic food cooker 
//This cooker has a suppy of food that it can load into its heater 
//when requested. The cooker then unloads the food when the requested. 
//The cooker then unloads the food when the cooking is done. 

module auto_oven_style ( 
	
	input clock , // System clock 
	input start, // Which starts a load/cook/unload cycle 
	input temp_ok, //A temperature sensor that detects when the heater is done preheating 
	input done, //A signal from a timer or sensor that detects when the cooking cycle is complete 
	input quiet, //A final input that selects if the cooker should beep when the food is ready 
	
	output reg load , //A signal that sends food into the cooker 
	output reg heat , //A signal that turns on the heating element, which has a built in temparature control 
	output reg unload , //A signal that removes the food from the cooker and presents it to the diner 
	output reg beep  //A signal that alerts the diner when the food is done. 
				
				) ; 
				
//State Machine can be braodly classified into 3 parts 
// 1. State Register 
// 2. Next Register Logic | -- Combo logic 
// 3. Output Logic | -- Combo logic 

reg [2:0] PS, NS ; // PS - Present State | NS - Next State 

`define IDLE 3'b000
`define PREHEAT 3'b001 
`define LOAD 3'b010 
`define COOK 3'b011 
`define EMPTY 3'b100 

//State Register block 
	always @(posedge clock) 
		begin 	
			PS <= NS ; 
		end 
		
		
//Next Register Logic -- Contains combinational circuitry 

	always @(PS or start or temp_ok or done ) 
		begin 
			
			NS = PS ; //Default condition. The state remains the same 
			
			case(PS) 
			`IDLE: if(start) 
						NS = `PREHEAT ; 
			`PREHEAT: if(temp_ok) 
						NS = `LOAD ;  
			`LOAD : NS = `COOK ; 
				
			`COOK : if (done) 
						NS = `EMPTY ; 
			
			`EMPTY : NS = `IDLE ; 
			
			default : NS = `IDLE ; 
			endcase 		
		end 
			
	
//Output Logic -- COntains combinational circuitry 

		always @(PS) 
			begin 
				
				if (PS == `LOAD ) 
					load = 1 ; 
				else 
					load = 0 ; 
					
				if ( PS == `EMPTY) 
					unload = 1 ; 
				else 
					unload = 0 ; 

				if ( PS == `EMPTY && quiet == 0) 
					beep = 1 ; 
				else 
					beep = 0 ; 
					
				if ( PS == `PREHEAT || PS == `LOAD || PS == `COOK ) 
					heat = 1 ; 
				else 
					heat = 0 ; 
					
			end 
			
endmodule 
		
