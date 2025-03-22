`timescale 1ns / 1ps

module top(input CCLK, sh_en, reset, output [15:0] X);
    // Scaled clock
    wire clk;
    
    // Scale clock to 1hz
    clock scaler(.CCLK(CCLK), .clkscale(50000000), .clk(clk));
    
    // Connect scaled clock to LFSR and connect Q_out to X
    lfsr register(.clk(clk), .sh_en(sh_en), .reset(reset), .Q_out(X), .ones(), .zeros(), .max_tick_reg());
endmodule
