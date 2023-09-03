`timescale 1ns / 1ps
module ClockDivider50MHzTo100Hz_tb;

  // Inputs
  reg CLK_50MHz;
  reg reset_n;
  
  // Outputs
  wire CLK_100Hz;

  // Instantiate the device under test (DUT)
  ClockDivider50MHzTo100Hz dut (
    CLK_50MHz,
    reset_n,
    CLK_100Hz
  );
  
 // Clock generation
    initial begin
	 CLK_50MHz = 0;
	 reset_n = 0;
	 #20000000 reset_n = 1;
	 repeat (10) @(posedge CLK_100Hz);
	 $finish;
	end
	
	always #20 CLK_50MHz = ~CLK_50MHz;
	 

endmodule
