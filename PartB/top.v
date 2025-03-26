`timescale 1ns / 1ps

module top(input clk, reset, input [4:0] button_input, output [6:0] led_out, output [3:0] anode_sel);
    wire [4:0] buttons; // To store debounced buttons
    wire [7:0] Q; // Store output of Flip-Flops
    reg [7:0] Q_next; // Store next state of Flip-Flops

    // Run button inputs through debouncer to stabilize
    debouncer dbouncer (.clk(clk), .reset(reset), .button_in(button_input), .button_out(buttons));
    
    always @(*) begin
        Q_next = Q; // Get current state
        
        if (buttons[0] || buttons[3]) // Increment
            Q_next = Q + 1;
        else if (buttons[1] || buttons[2]) // Decrement
            Q_next = Q - 1;
        else if (buttons[4]) // Reset
            Q_next = 8'd22;
    end
    
    // Connect the D Flip-Flops
    d_ff_reset DFF0 (.clk(clk), .reset(reset), .d(Q_next[0]), .q(Q[0]));
    d_ff_reset DFF1 (.clk(clk), .reset(reset), .d(Q_next[1]), .q(Q[1]));
    d_ff_reset DFF2 (.clk(clk), .reset(reset), .d(Q_next[2]), .q(Q[2]));
    d_ff_reset DFF3 (.clk(clk), .reset(reset), .d(Q_next[3]), .q(Q[3]));
    d_ff_reset DFF4 (.clk(clk), .reset(reset), .d(Q_next[4]), .q(Q[4]));
    d_ff_reset DFF5 (.clk(clk), .reset(reset), .d(Q_next[5]), .q(Q[5]));
    d_ff_reset DFF6 (.clk(clk), .reset(reset), .d(Q_next[6]), .q(Q[6]));
    d_ff_reset DFF7 (.clk(clk), .reset(reset), .d(Q_next[7]), .q(Q[7]));

    // Connect the seven segment display
    seven_segment_controller ssc (.clk(clk), .reset(reset), .temp(Q), .anode_select(anode_sel), .LED_out(led_out));

endmodule
