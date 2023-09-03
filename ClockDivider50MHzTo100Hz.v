module ClockDivider50MHzTo100Hz (
    input CLK_50MHz,
    input reset_n,
    output reg CLK_100Hz
);

reg [24:0] counter = 0;

always @(posedge CLK_50MHz or negedge reset_n) begin
    if (~reset_n) begin
        counter <= 0;
        CLK_100Hz <= 0;
    end else begin
        counter <= counter + 1;
        if (counter == 249999) begin
            counter <= 0;
            CLK_100Hz <= ~CLK_100Hz;
        end
    end
end

endmodule
