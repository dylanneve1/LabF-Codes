`timescale 1ns / 1ps

module lfsr_tb;
    // Inputs clk, sh_en and reset 
    reg clk, sh_en, reset;
    // Output Q_out, ones and zeros
    wire [15:0] Q_out;
    // Tick register output
    wire max_tick_reg;

    // Connect the LFSR
    lfsr uut (
        .clk(clk),
        .sh_en(sh_en),
        .reset(reset),
        .Q_out(Q_out),
        .max_tick_reg(max_tick_reg)
    );

    initial begin
        // clk 0 initially
        clk = 0;
        // Toggle clk
        forever #10 clk = ~clk;
    end

    initial begin
        reset = 1;    // Assert reser
        sh_en = 0;    // Disable shifting during reset
        #100;         // Hold reset for 10 cycles (10 ns period => 100 ns)
        reset = 0;    // Deassert reset
        sh_en = 1;    // Enable shifting after reset

        #15000000;    // Wait until after first max_tick_reg
        reset = 1;    // Assert reser
        sh_en = 0;    // Disable shifting during reset
        #100;         // Hold reset for 10 cycles (10 ns period => 100 ns)
        reset = 0;    // Deassert reset
        sh_en = 1;    // Enable shifting after reset
        $finish;
    end

    initial begin
        $monitor("Time=%t, Q_out=%h, max_tick_reg=%b", $time, Q_out, max_tick_reg);
    end

endmodule