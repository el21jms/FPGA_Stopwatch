`timescale 1ns / 1ps
module StopwatchLogic_tb;

    reg CLK_100Hz;
    reg reset_n;
    reg start_stop;
	 reg hold;
    wire [6:0] stopwatch_unit_mins;
    wire [5:0] stopwatch_unit_secs;
    wire [6:0] stopwatch_unit_decs;
    wire stopwatch_overflow;

    StopwatchLogic dut (
        CLK_100Hz,
        reset_n,
        start_stop,
		  hold,
        stopwatch_unit_mins,
        stopwatch_unit_secs,
        stopwatch_unit_decs,
        stopwatch_overflow
    );

  // Clock generation
    always #5 CLK_100Hz = ~CLK_100Hz;

    // Initialize inputs
    initial begin
        CLK_100Hz = 0;
        reset_n = 0;
        start_stop = 0;
        hold = 1;
        
        #10 reset_n = 1;  // Release reset
        #30 start_stop = 1; // Start the stopwatch
        #6000020 hold = 1; // Hold the stopwatch
        #20 hold = 0; // Resume the stopwatch
        #10; // Wait for some time
        #10 reset_n = 0; // Assert reset
        #10 reset_n = 1; // Release reset
        #50; // Wait for some time

        #1000; // End simulation
        $finish;
    end

    // Display outputs
    always @(posedge CLK_100Hz) begin
        $display("Time: %03d:%02d.%02d", stopwatch_unit_mins, stopwatch_unit_secs, stopwatch_unit_decs);
        if (stopwatch_overflow)
            $display("Timer Overflow!");
    end
endmodule
