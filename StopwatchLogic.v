module StopwatchLogic (
    input CLK_100Hz,
    input reset_n,
    input start_stop,
    input hold,
	 output [6:0] stopwatch_unit_mins,
	 output [5:0] stopwatch_unit_secs,
	 output [6:0] stopwatch_unit_decs,
    output reg timer_overflow
);
    reg [26:0] count;
    reg [1:0] state;
	 
    reg [6:0] mins_count;
    reg [5:0] secs_count;
    reg [6:0] decs_count;
	 
	 always @(posedge CLK_100Hz or negedge reset_n) begin
        if (~reset_n) begin
            count <= 0;
            state <= 0;
            mins_count <= 0;
            secs_count <= 0;
            decs_count <= 0;
            timer_overflow <= 0;
        end else begin
            case (state)
                0: begin  // Idle state
                    if (~start_stop)
                        state <= 1;
                end
                1: begin  // Running state
                    if (~hold)
                        state <= 2;
                    else if (~start_stop)
                        state <= 3;
                end
                2: begin  // Hold state
                    if (hold)
                        state <= 1;
                end
                3: begin  // Stop state
                    if (~start_stop)
                        state <= 1;
                end
                default: state <= 0;
            endcase

            case (state)
                0: begin  // Idle state
                    count <= 0;
                    mins_count <= 0;
                    secs_count <= 0;
                    decs_count <= 0;
                    timer_overflow <= 0;
                end
                1: begin  // Running state
							decs_count <= decs_count + 1;
                        if (decs_count == 99) begin
                            decs_count <= 0;
                            secs_count <= secs_count + 1;
                            if (secs_count == 59) begin
                                secs_count <= 0;
                                mins_count <= mins_count + 1;
                                if (mins_count == 99) begin
                                    mins_count <= 0;
                                    timer_overflow <= 1;
												count <= 0;
                                end
                            end
                        end 
							count <= count + 1;
                end
                2, 3: begin  // Hold/Stop state
                    count <= 0;
                end
                default: count <= 0;
            endcase
        end
    end
	 
	 assign stopwatch_unit_mins = mins_count[6:0];
    assign stopwatch_unit_secs = secs_count[5:0];
    assign stopwatch_unit_decs = decs_count[6:0];
	 
endmodule
