`timescale 1ns / 1ps
module SevenSegEncoder_tb;

  // Inputs
  reg [6:0] stopwatch_unit_mins;
  reg [5:0] stopwatch_unit_secs;
  reg [6:0] stopwatch_unit_decs;

  // Outputs
  wire [6:0] hex_10_mins;
  wire [6:0] hex_1_min;
  wire [6:0] hex_10_secs;
  wire [6:0] hex_1_sec;
  wire [6:0] hex_hundredths;
  wire [6:0] hex_tenths;

  // Instantiate the module to be tested
  SevenSegEncoder DUT(
    stopwatch_unit_mins,
    stopwatch_unit_secs,
    stopwatch_unit_decs,
    hex_10_mins,
    hex_1_min,
    hex_10_secs,
    hex_1_sec,
    hex_hundredths,
    hex_tenths
  );
  
  integer ex_hex_10_mins;
  integer ex_hex_1_min;
  integer ex_hex_10_secs;
  integer ex_hex_1_sec;
  integer ex_hex_hundredths;
  integer ex_hex_tenths;
  
  initial begin
  // Case 1 - 00:00:00
  stopwatch_unit_mins = 7'b0000000;
  stopwatch_unit_secs = 6'b000000;
  stopwatch_unit_decs = 7'b0000000;
  
  // Expected values - 0 for every output, on SevenSegment displayed 0 = 0111111
  #1000;
  
  // Case 2 - 54:13:72
  stopwatch_unit_mins = 7'b0110110;
  stopwatch_unit_secs = 6'b001101;
  stopwatch_unit_decs = 7'b1001000;
  // Expected values
  ex_hex_10_mins = 7'b1101101;	//Number 5 on SevenSegment
  ex_hex_1_min = 7'b1100110;	//Number 4 on SevenSegment
  ex_hex_10_secs = 7'b0000110;	//Number 1 on SevenSegment
  ex_hex_1_sec = 7'b1001111;	//Number 3 on SevenSegment
  ex_hex_hundredths = 7'b0000111;	//Number 7 on SevenSegment
  ex_hex_tenths = 7'b1011011;	//Number 2 on SevenSegment
  
  #10
	if ((ex_hex_10_mins == hex_10_mins) && (ex_hex_1_min == hex_1_min) && (ex_hex_10_secs == hex_10_secs) && (ex_hex_1_sec == hex_1_sec) && (ex_hex_hundredths == hex_hundredths) && (ex_hex_tenths == hex_tenths))
		begin
		$display("Case 2 passed: Time: %03d:%02d:%02d", stopwatch_unit_mins, stopwatch_unit_secs, stopwatch_unit_decs);
		end
	else
		begin
		$display("Case 2 Test failed");
	end
	#1000;
	end
endmodule
		