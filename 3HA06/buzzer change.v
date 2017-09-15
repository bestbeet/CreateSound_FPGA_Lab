`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:22:47 10/25/2016 
// Design Name: 
// Module Name:    buzzer 
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
module buzzer(
    input clk,
    input onoff,
    output reg sp 
    );
	 parameter clk56k= 25000000/450/4;
	 parameter clk28k= 25000000/440/8;
	 
	 reg sp1;
	 reg sp2;
	 reg speed;
	 always@(onoff)
		if(onoff ==0) sp<=0;
		else sp <= (speed ? sp1:sp2);
	reg[31:0] cnt1;
	always@(posedge clk)
		//
		begin 
			if(cnt1 == clk56k) begin sp1<= ~sp1; cnt1 <=0; end
			else begin cnt1 <= cnt1 +1; end
		end
	
	reg[31:0] cnt2;
	always@(posedge clk)
		//
		begin 
			if(cnt2 == clk28k) begin sp2<= ~sp2; cnt2 <=0; end
			else begin cnt2 <= cnt2 +1; end
		end
	
	reg[31:0] cnt;
	always@(posedge clk)
		if(cnt == 25000000/2)
			begin speed = ~speed; cnt <=0; end
		else cnt <= cnt + 1;
		/*if(onoff ==0) sp <=0; 
		else begin 
			if(cnt == clk56k) begin sp<= ~sp; cnt <=0; end
			else begin cnt <= cnt+1; end
		end*/
		
endmodule
