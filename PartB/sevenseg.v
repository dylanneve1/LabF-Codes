module seven_segment_controller(
    input clk, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
    input [7:0] temp,
    output reg [3:0] anode_select, // select one of the 4 7-segment modules by choosing one to be activated - note that this is an active low signal
    output reg [6:0] LED_out// cathode patterns of the 7-segment LED display
    );

 
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period

    wire [1:0] LED_activating_counter; 
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
    
    always @(posedge clk or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 

    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            anode_select = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = temp/100;
             // the first digit of the 8-bit temperature value
              end
        2'b01: begin
            anode_select = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (temp%100)/10;
            // the second digit of the 8-bit temperature value
              end
        2'b10: begin
            anode_select = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = (temp%100)%10;
            // the last digit of the 8-bit temperature value
                end
        2'b11: begin
            anode_select = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = 4'hF;
            // F symbol to indicate Fahrenheit
               end
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        4'b1111: LED_out = 7'b0111000; // "F"
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
 endmodule