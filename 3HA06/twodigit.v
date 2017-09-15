`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:38 10/25/2016 
// Design Name: 
// Module Name:    sperkerfour 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module twodigit(
    input clk,
    input en,
    output reg sp,
    output [6:0] o,
    output [1:0] com
    );
	 parameter s0 = 0 ;
	 parameter s1 = 1;


reg [3:0] one;
reg [3:0] ten;
reg [6:0] ss1 ;
reg [6:0] ss2 ;
reg [6:0] so ;
reg [31:0] cnt,scnt;
reg sclk,ssclk;
reg state = s0;
reg [1:0] scom ;

assign o = so ;
assign com = scom;


always@(posedge sclk)
 if (en == 0)begin one <= 0; ten <=0 ;  end
 else 
	begin 
 if (one == 9) begin one <= 0; ten <= ten + 1; end else  begin one <= one +1 ; end
 
 end
 always@(one)
 
	if(en == 0) sp <=0  ; else begin if ((ten == 9 )&&(one==8))sp <=1 ; end
														
													
	
 always@(posedge clk)
	 begin if (cnt == 1000000) begin sclk <= ~sclk; cnt <=0; end else cnt <=cnt +1 ;end
	 
 always@*
	begin
		case(ten)
			4'b0000 : ss1 <=7'b0111111;
			4'b0001 : ss1 <=7'b0000110;
			4'b0010 : ss1 <=7'b1011011;
			4'b0011 : ss1 <=7'b1001111;
			4'b0100 : ss1 <=7'b1100110;
			4'b0101 : ss1 <=7'b1101101;
			4'b0110 : ss1 <=7'b1111101;
			4'b0111 : ss1 <=7'b0000111;
			4'b1000 : ss1 <=7'b1111111;
			4'b1001 : ss1 <=7'b1100111;
			default : ss1 <=7'b0000000;
		endcase
		end
			 
 always@*
	begin
		case(one)
			4'b0000 : ss2 <=7'b0111111;
			4'b0001 : ss2 <=7'b0000110;
			4'b0010 : ss2 <=7'b1011011;
			4'b0011 : ss2 <=7'b1001111;
			4'b0100 : ss2 <=7'b1100110;
			4'b0101 : ss2 <=7'b1101101;
			4'b0110 : ss2 <=7'b1111101;
			4'b0111 : ss2 <=7'b0000111;
			4'b1000 : ss2 <=7'b1111111;
			4'b1001 : ss2 <=7'b1100111;
			default : ss2 <=7'b0000000;
		endcase
	end
	
	always@(posedge ssclk)
	begin 
		case(state)
			s0 : begin so <=ss1; scom <= 2'b01; state <=s1; end
			s1 : begin so <=ss2; scom <= 2'b10; state <=s0; end
			endcase
	end
	
	always@(posedge clk)
	begin 
		if (scnt == 4000)
			begin ssclk <= 1 ; scnt <=0;end
			else begin ssclk <= 0 ;scnt <= scnt +1 ; end
	end
			
 

endmodule
