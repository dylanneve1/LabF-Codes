`timescale 1ns / 1ps

module d_ff_reset_tb();
    reg clk, reset, d;
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
