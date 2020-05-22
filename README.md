# Automatic-Food-Counter-using-Verilog-HDL-
A Verilog HDL Code for an automatic food cooker

This cooker has a suppy of food that it can load into its heater when requested. The cooker then unloads the food when the requested. The cooker then unloads the food when the cooking is done. 

State Machine can be braodly classified into 3 parts 
1. State Register 
2. Next Register Logic | -- Combo logic 
3. Output Logic | -- Combo logic 


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
