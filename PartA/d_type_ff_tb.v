`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Trinity College Dublin
// Engineer: Dylan Neve (21364333)
// 
// Create Date: 03/11/2025 10:02:44 AM
// Design Name: LabF
// Module Name: d_ff_reset_tb
// Project Name: LabF
// Target Devices: Basys 3
// 
//////////////////////////////////////////////////////////////////////////////////


module d_ff_reset_tb();

    reg clk;
    reg reset;
    reg d;
    wire q;

    d_ff_reset uut (.clk(clk), .reset(reset), .d(d), .q(q));
    
    always begin
        #10 clk = ~clk;
    end
    
    initial begin
        clk = 1;
        reset = 1;
        d = 0;
        
        #20 d = 1;
        #17 reset = 0;
        #9 d = 0;
        
        #30 d = 1;
        #40 reset = 1;
        #30 reset = 0;
        #30 d = 0;
        
        #50 $stop;
    end

endmodule
