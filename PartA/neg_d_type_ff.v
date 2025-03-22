`timescale 1ns / 1ps

module d_ff_reset(input wire clk, reset, d, output reg q);

   // At negative edge of clk or reset
   always @(negedge clk, negedge reset)
      // If reset then q to zero
      if (reset)
         q <= 1'b0;
      // Otherwise q set to input d
      else
         q <= d;

endmodule