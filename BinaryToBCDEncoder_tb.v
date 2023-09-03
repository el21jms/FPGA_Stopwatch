`timescale 1 ns / 100 ps

module BinaryToBCDEncoder_tb;

	reg A;
	reg B;
	reg C;
	reg D;

	wire BCD0;
	wire BCD1;
	wire BCD2;
	wire BCD3;
	wire BCD4;
	
	BinaryToBCDEncoder dut(
		A,
		B,
		C,
		D,
		BCD0,
		BCD1,
		BCD2,
		BCD3,
		BCD4
	);
		
		integer i;
		integer ex_BCD0;
		integer ex_BCD1;
		integer ex_BCD2;
		integer ex_BCD3;
		integer ex_BCD4;
		integer ac_BCD0;
		integer ac_BCD1;
		integer ac_BCD2;
		integer ac_BCD3;
		integer ac_BCD4;
		
		initial
		begin
			
			for (i = 0; i < 16; i = i + 1)
			begin
				
				{D,C,B,A} = i;
				
				#10;
				
				ex_BCD0 = D;
				ex_BCD1 = (A & B & ~C)|(~A & C);
				ex_BCD2 = (~A & B)|(C & B);
				ex_BCD3 = (A & ~B & ~C);
				ex_BCD4 = (A & B) | (A & C);
				ac_BCD0 = BCD0;
				ac_BCD1 = BCD1;
				ac_BCD2 = BCD2;
				ac_BCD3 = BCD3;
				ac_BCD4 = BCD4;
				
				if (!(ex_BCD0 == ac_BCD0));
				begin
					$display("Incorrect value of BCD0 at %d, %d, %d, %d ", A, B, C, D);
				end
				if (!(ex_BCD1 == ac_BCD1));
				begin
					$display("Incorrect value of BCD1 at %d, %d, %d, %d ", A, B, C, D);
				end
				if (!(ex_BCD2 == ac_BCD2));
				begin
					$display("Incorrect value of BCD2 at %d, %d, %d, %d ", A, B, C, D);
				end
				if (!(ex_BCD3 == ac_BCD3));
				begin
					$display("Incorrect value of BCD3 at %d, %d, %d, %d ", A, B, C, D);
				end
				if (!(ex_BCD4 == ac_BCD4));
				begin
					$display("Incorrect value of BCD4 at %d, %d, %d, %d ", A, B, C, D);
				end
			end
		end
	endmodule