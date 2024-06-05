`timescale 1ns / 1ps

module fft8(clk,rst,write,start,ready,state,x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i,y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i,y4r,y4i,y5r,y5i,y6r,y6i,y7r,y7i);
input clk,rst,write,start;
input [15:0]x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i;
output reg [15:0] y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i,y4r,y4i,y5r,y5i,y6r,y6i,y7r,y7i;
output reg ready;
output reg [1:0]state;

wire [15:0] y0r_t,y0i_t,y1r_t,y1i_t,y2r_t,y2i_t,y3r_t,y3i_t,y4r_t,y4i_t,y5r_t,y5i_t,y6r_t,y6i_t,y7r_t,y7i_t;
wire [15:0] x20r,x20i,x21r,x21i,x22r,x22i,x23r,x23i,x24r,x24i,x25r,x25i,x26r,x26i,x27r,x27i;
wire [15:0] x10r,x10i,x11r,x11i,x12r,x12i,x13r,x13i,x14r,x14i,x15r,x15i,x16r,x16i,x17r,x17i;
reg[15:0] x0r_temp,x0i_temp,x1r_temp,x1i_temp,x2r_temp,x2i_temp,x3r_temp,x3i_temp,x4r_temp,x4i_temp,x5r_temp,x5i_temp,x6r_temp,x6i_temp,x7r_temp,x7i_temp;
reg[15:0] x0r_t,x0i_t,x1r_t,x1i_t,x2r_t,x2i_t,x3r_t,x3i_t,x4r_t,x4i_t,x5r_t,x5i_t,x6r_t,x6i_t,x7r_t,x7i_t;

//Define Twiddle Factors
parameter w0r=16'b1_00000000;
parameter w0i=16'b0_00000000;
parameter w1r=16'b00000000_10110101;//0.707=0.10110101
parameter w1i=16'b11111111_01001011;//-0.707=1.01001011
parameter w2r=16'b00000000_00000000;
parameter w2i=16'b11111111_00000000;//-1
parameter w3r=16'b11111111_01001011;//-0.707=1.01001011
parameter w3i=16'b11111111_01001011;//-0.707=1.01001011

always @(posedge clk) begin
		if (~rst) begin
		    //If Reset Signal is Low then output=0
		    state<=2'b00;
			ready <= 1'b0;
		end
		else begin
		  case(state)
		      2'b00 : if(write) begin
		                  state<=2'b01;
		                  ready<=1'b0;
		              end
		              else begin 
		                   state<=2'b00;
		                   ready<=1'b0;
		              end
		      2'b01: begin
		      //Storing input values into temporary variables 
					x0r_temp<=x0r;
                    x0i_temp<=x0i;
                    x1r_temp<=x1r;
                    x1i_temp<=x1i;
                    x2r_temp<=x2r;
                    x2i_temp<=x2i;
                    x3r_temp<=x3r;
                    x3i_temp<=x3i;
                    x4r_temp<=x4r;
                    x4i_temp<=x4i;
                    x5r_temp<=x5r;
                    x5i_temp<=x5i;
                    x6r_temp<=x6r;
                    x6i_temp<=x6i;
                    x7r_temp<=x7r;
                    x7i_temp<=x7i;
                    state<=2'b10;
		             end
		     2'b10: begin
		              if(start) begin
		              x0r_t<=x0r_temp;
                      x0i_t<=x0i_temp;
                      x1r_t<=x1r_temp;
                      x1i_t<=x1i_temp;
                      x2r_t<=x2r_temp;
                      x2i_t<=x2i_temp;
                      x3r_t<=x3r_temp;
                      x3i_t<=x3i_temp;
                      x4r_t<=x4r_temp;
                      x4i_t<=x4i_temp;
                      x5r_t<=x5r_temp;
                      x5i_t<=x5i_temp;
                      x6r_t<=x6r_temp;
                      x6i_t<=x6i_temp;
                      x7r_t<=x7r_temp;
                      x7i_t<=x7i_temp;
                      state<=2'b11;
		              end
		            end
		     2'b11: begin 
		      //assigning outputs to registers
                        y0r<=y0r_t;
                        y0i<=y0i_t;
                        y1r<=y1r_t;
                        y1i<=y1i_t;
                        y2r<=y2r_t;
                        y2i<=y2i_t;
                        y3r<=y3r_t;
                        y3i<=y3i_t;
                        y4r<=y4r_t;
                        y4i<=y4i_t;
                        y5r<=y5r_t;
                        y5i<=y5i_t;
                        y6r<=y6r_t;
                        y6i<=y6i_t;
                        y7r<=y7r_t;
                        y7i<=y7i_t;
		              ready<=1'b1;
		            end
		        default : state<=2'b00;
		  endcase
	
		end
	end

//Butterfly Stage1
bfly_cal s11(x0r_t,x0i_t,x4r_t,x4i_t,w0r,w0i,x10r,x10i,x11r,x11i);
bfly_cal s12(x2r_t,x2i_t,x6r_t,x6i_t,w0r,w0i,x12r,x12i,x13r,x13i);
bfly_cal s13(x1r_t,x1i_t,x5r_t,x5i_t,w0r,w0i,x14r,x14i,x15r,x15i);
bfly_cal s14(x3r_t,x3i_t,x7r_t,x7i_t,w0r,w0i,x16r,x16i,x17r,x17i);
//Butterfly Stage2
bfly_cal s21(x10r,x10i,x12r,x12i,w0r,w0i,x20r,x20i,x22r,x22i);
bfly_cal s22(x11r,x11i,x13r,x13i,w2r,w2i,x21r,x21i,x23r,x23i);
bfly_cal s23(x14r,x14i,x16r,x16i,w0r,w0i,x24r,x24i,x26r,x26i);
bfly_cal s24(x15r,x15i,x17r,x17i,w2r,w2i,x25r,x25i,x27r,x27i);
//Butterfly Stage3
bfly_cal s31(x20r,x20i,x24r,x24i,w0r,w0i,y0r_t,y0i_t,y4r_t,y4i_t);
bfly_cal s32(x21r,x21i,x25r,x25i,w1r,w1i,y1r_t,y1i_t,y5r_t,y5i_t);
bfly_cal s33(x22r,x22i,x26r,x26i,w2r,w2i,y2r_t,y2i_t,y6r_t,y6i_t);
bfly_cal s34(x23r,x23i,x27r,x27i,w3r,w3i,y3r_t,y3i_t,y7r_t,y7i_t);

endmodule

//Butterfly Calculations 
module bfly_cal(xr,xi,yr,yi,wr,wi,x0r,x0i,x1r,x1i);
input signed [15:0]xr,xi,yr,yi;
input signed [15:0]wr,wi;
output [15:0]x0r,x0i,x1r,x1i;
wire [31:0]p1,p2,p3,p4;
// (yr+jyi)*(wr+jwi)
assign p1=wr*yr;
assign p2=wi*yr;
assign p3=wr*yi;
assign p4=wi*yi;
assign x0r=xr+p1[23:8]-p4[23:8];
assign x0i=xi+p2[23:8]+p3[23:8];
assign x1r=xr-p1[23:8]+p4[23:8];
assign x1i=xi-p2[23:8]-p3[23:8];
endmodule