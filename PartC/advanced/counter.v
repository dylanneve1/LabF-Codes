`timescale 1ns / 1ps

module counter(input clk, sh_en, reset, i0, output reg [15:0] ones, zeros);
    always @(posedge clk or posedge reset)
        if (reset) begin
            ones <= 16'b0;
            zeros <= 16'b0;
        end else if (sh_en) begin
            if (i0 == 0)
                zeros <= zeros + 1;
            else if (i0 == 1)
                ones <= ones + 1;
        end 
endmodule
