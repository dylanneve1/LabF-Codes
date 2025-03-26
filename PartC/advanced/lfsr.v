`timescale 1ns / 1ps

module lfsr(input clk, sh_en, reset, output [15:0] Q_out, ones, zeros, output reg max_tick_reg);
    // Seed
    localparam seed = 16'b1111111111111111;
    
    // Current State
    reg [15:0] Q_state;
    // Next State
    wire [15:0] Q_ns;
    // Feedback
    wire Q_fb;
    
    // Connect counter to MSB
    counter cnt(.clk(clk), .sh_en(sh_en), .reset(reset), .i0(Q_state[15]), .ones(ones), .zeros(zeros));
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset All
            Q_state <= seed;
            max_tick_reg <= 1'b0;
        end else if (sh_en) begin
            // State to next
            Q_state <= Q_ns;
            // If next state is seed
            if (Q_ns == seed) begin
                // Max tick and increment
                max_tick_reg <= 1'b1;
            end else
                // Max tick low
                max_tick_reg <= 1'b0;
        end
    end
    
    // Next State Logic
    assign Q_fb = ~(Q_state[15] ^ Q_state[14] ^ Q_state[12] ^ Q_state[3]);
    assign Q_ns = {Q_state[14:0], Q_fb};
    
    // Output Logic
    assign Q_out = Q_state;
    
endmodule
