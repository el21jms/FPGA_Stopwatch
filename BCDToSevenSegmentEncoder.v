module BCDToSevenSegmentEncoder (
	input D,	//BCD0
	input C,	//BCD1
	input B,	//BCD2
	input A,	//BCD3
	
	output HEX0,
	output HEX1,
	output HEX2,
	output HEX3,
	output HEX4,
	output HEX5,
	output HEX6
);

    assign HEX0 = ~(C | A |(~B & ~D)|(B & D));
    assign HEX1 = ~(~B|(~C & ~D)|(C & D));
    assign HEX2 = ~(~C|D|B);
    assign HEX3 = ~(A|(~B & ~D)|(~B & C)|(C & ~D)|(B & ~C & D));
    assign HEX4 = ~((~B & ~D)|(C & ~D));
    assign HEX5 = ~(A|(~C & ~D)|(B & ~C)|(B & ~D));
    assign HEX6 = ~(A|(~B & C)|(C & ~D)|(~C & B));

endmodule