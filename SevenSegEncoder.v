module SevenSegEncoder(
	input [6:0] stopwatch_unit_mins,
	input [5:0] stopwatch_unit_secs,
	input [6:0] stopwatch_unit_decs,
	output [7:0] hex_10_mins,
	output [7:0] hex_1_min,
	output [7:0] hex_10_secs,
	output [7:0] hex_1_sec,
	output [7:0] hex_hundredths,
	output [7:0] hex_tenths
);

	wire [11:0] BCDOutmins;
	wire [11:0] BCDOutsecs;
	wire [11:0] BCDOutdecs;
	
	BCDEncoder Minutes (
	{1'b0,stopwatch_unit_mins},
	BCDOutmins
	);
	
	BCDEncoder Seconds (
	{2'b00,stopwatch_unit_secs},
	BCDOutsecs
	);
	
	BCDEncoder Miliseconds (
	{1'b0,stopwatch_unit_decs},
	BCDOutdecs
	);
	
	BCDToSevenSegmentEncoder BCDToSevenSegment10mins (
	BCDOutmins[4],
	BCDOutmins[5],
	BCDOutmins[6],
	BCDOutmins[7],
	hex_10_mins[0],
	hex_10_mins[1],
	hex_10_mins[2],
	hex_10_mins[3],
	hex_10_mins[4],
	hex_10_mins[5],
	hex_10_mins[6]
	);
	
	BCDToSevenSegmentEncoder BCDToSevenSegment1min (
	BCDOutmins[0],
	BCDOutmins[1],
	BCDOutmins[2],
	BCDOutmins[3],
	hex_1_min[0],
	hex_1_min[1],
	hex_1_min[2],
	hex_1_min[3],
	hex_1_min[4],
	hex_1_min[5],
	hex_1_min[6]
	);
	
	BCDToSevenSegmentEncoder BCDToSevenSegment10secs (
	BCDOutsecs[4],
	BCDOutsecs[5],
	BCDOutsecs[6],
	BCDOutsecs[7],
	hex_10_secs[0],
	hex_10_secs[1],
	hex_10_secs[2],
	hex_10_secs[3],
	hex_10_secs[4],
	hex_10_secs[5],
	hex_10_secs[6]
	);
	
	BCDToSevenSegmentEncoder BCDToSevenSegment1sec (
	BCDOutsecs[0],
	BCDOutsecs[1],
	BCDOutsecs[2],
	BCDOutsecs[3],
	hex_1_sec[0],
	hex_1_sec[1],
	hex_1_sec[2],
	hex_1_sec[3],
	hex_1_sec[4],
	hex_1_sec[5],
	hex_1_sec[6]
	);
	
	
	BCDToSevenSegmentEncoder BCDToSevenSegmenttenths(
	BCDOutdecs[4],
	BCDOutdecs[5],
	BCDOutdecs[6],
	BCDOutdecs[7],
	hex_tenths[0],
	hex_tenths[1],
	hex_tenths[2],
	hex_tenths[3],
	hex_tenths[4],
	hex_tenths[5],
	hex_tenths[6]
	);
	
	BCDToSevenSegmentEncoder BCDToSevenSegmenthundreths (
	BCDOutdecs[0],
	BCDOutdecs[1],
	BCDOutdecs[2],
	BCDOutdecs[3],
	hex_hundredths[0],
	hex_hundredths[1],
	hex_hundredths[2],
	hex_hundredths[3],
	hex_hundredths[4],
	hex_hundredths[5],
	hex_hundredths[6]
	);

	
	
	
	
	

endmodule
