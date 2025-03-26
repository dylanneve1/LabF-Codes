`timescale 1ns / 1ps

module d_ff_reset_tb();
    // Inputs clk, reset and d
    reg clk, reset, d;
    // Output Q
    wire q;

    // Connect D Fip-Flop
    d_ff_reset uut (.clk(clk), .reset(reset), .d(d), .q(q));
    
    always begin
        // Toggle clk
        #10 clk = ~clk;
    end
    
    initial begin
        // Assert clk and reset
        // Deassert d
        clk = 1;
        reset = 1;
        d = 0;
        
        // Assert d
        #20 d = 1;
        // Deassert reset
        #17 reset = 0;
        // Deassert d
        #9 d = 0;
        
        // Assert d
        #30 d = 1;
        // Assert reset
        #40 reset = 1;
        // Deassert reset
        #30 reset = 0;
        // Deassert d
        #30 d = 0;
        
        #50 $stop;
    end

endmodule
