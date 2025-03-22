`timescale 1ns / 1ps

module d_ff_reset(input wire clk, reset, d, output reg q);

   // At positive edge of clk
   always @(posedge clk) begin
      // If reset then q to zero
      if (reset) begin
         q <= 1'b0;
      // Otherwise q set to input d
      end else begin
         q <= d;
      end
   end
endmodule
