`timescale 1ns / 1ps

module clock(input CCLK, input [25:0] clkscale, output reg clk);
    // Counter
    reg [25:0] counter = 0;
    always @(posedge CCLK) begin
        // If counter reached 50M
        if (counter >= clkscale) begin
            // Reset counter
            counter <= 0;
            // Flip clock
            clk <= ~clk;
        end else
            // Inctement counter
            counter <= counter + 1;
    end
endmodule
