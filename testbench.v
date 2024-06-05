`timescale 1ns/1ps
module ffttestbench ();
parameter CLOCK_PERIOD = 49; // 10 MHz clock
reg clk,rst,write,start;
reg signed [15:0] x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i;
wire signed [15:0] y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i,y4r,y4i,y5r,y5i,y6r,y6i,y7r,y7i;
wire ready;
wire [1:0]state;

//Module used for testing
fft8 fft8_test(.clk(clk),.rst(rst),.write(write),.start(start),.ready(ready),.state(state),.x0r(x0r),.x0i(x0i),.x1r(x1r),.x1i(x1i),.x2r(x2r),.x2i(x2i),.x3r(x3r),.x3i(x3i),.x4r(x4r),.x4i(x4i),.x5r(x5r),.x5i(x5i),.x6r(x6r),.x6i(x6i),.x7r(x7r),.x7i(x7i),.y0r(y0r),.y0i(y0i),.y1r(y1r),.y1i(y1i),.y2r(y2r),.y2i(y2i),.y3r(y3r),.y3i(y3i),.y4r(y4r),.y4i(y4i),.y5r(y5r),.y5i(y5i),.y6r(y6r),.y6i(y6i),.y7r(y7r),.y7i(y7i));

//Testing
initial begin
	clk=1'b0;
	rst=1'b0;
	
	//change reset signal 
	#5 rst=1;
	
	//Keep Write and Start signals Low
	write=0;
	start=0;

	//Give Inputs in Hexadecimal Format DDFF (Decimal Deciaml Fractional Fractional)
	x0r=16'h0000;//0
	x0i=16'h0000;//0
	x1r=16'h0100;//0
	x1i=16'h0000;//0
	x2r=16'h0200;//0
	x2i=16'h0000;//0
	x3r=16'h0300;//0
	x3i=16'h0000;//0
	x4r=16'h0400;//0
	x4i=16'h0000;//0
	x5r=16'h0500;//0
	x5i=16'h0000;//0
	x6r=16'h0600;//0
	x6i=16'h0000;//0
	x7r=16'h0700;//0
	x7i=16'h0000;//0

	//Make Write signal high to write the input data
	#10 write=1;
	
	//To start the Computation Make Start Signal High
	#10 start=1;
	
//	//We can even make the Write and Start Signal Low as has FFT Started Compuation
//	#(5*CLOCK_PERIOD) start=0;
//	#(5*CLOCK_PERIOD) write=0;
	
end
// System clock generator
always begin
	//after delay of clockperiod/2 we are inverting the clk value
	#(CLOCK_PERIOD/2) clk = ~clk;
end

// VCD dump
initial begin
	$dumpfile("fft.vcd");
	$dumpvars(0, fft8_test);
	#500 $finish;
end

endmodule