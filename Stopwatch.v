module Stopwatch(
	input CLK_50MHz,
	input reset_n,//An active-low set signal
	input start_stop,//An active-low start trigger
	input hold,//An active-low hold singal
	output [6:0] ten_mins_seven_seg,
	output [6:0] one_min_seven_seg,
	output [6:0] ten_secs_seven_seg,
	output [6:0] one_sec_seven_seg,
	output [6:0] tenths_seven_seg,
	output [6:0] hundredths_seven_seg,
	output reg CLK_ind,
	output overflow_flag
);

	
	wire CLK_100Hz;
	wire [6:0] stopwatch_unit_mins;
	wire [5:0] stopwatch_unit_secs;
	wire [6:0] stopwatch_unit_decs;
	

	// Instantiate ClockDivider50MHzTo100Hz module
	ClockDivider50MHzTo100Hz clk_divider(
		CLK_50MHz,
		reset_n,
		CLK_100Hz
	);
	
	// Instantiate StopwatchLogic module
	StopwatchLogic stopwatch_logic(
		CLK_100Hz,
		reset_n,
		start_stop,
		hold,
		stopwatch_unit_mins,
		stopwatch_unit_secs,
		stopwatch_unit_decs,
		overflow_flag
	);
	
	// Instantiate SevenSegEncoder module
	SevenSegEncoder seven_seg_encoder(
		stopwatch_unit_mins,
		stopwatch_unit_secs,
		stopwatch_unit_decs,
		ten_mins_seven_seg,
		one_min_seven_seg,
		ten_secs_seven_seg,
		one_sec_seven_seg,
		hundredths_seven_seg,
		tenths_seven_seg
	);
	
reg [24:0] counter = 0;

	always @(posedge CLK_50MHz) begin
			counter <= counter + 1;
			if (counter == 24999999) begin
            counter <= 0;
            CLK_ind <= ~CLK_ind;
        end
    end
endmodule