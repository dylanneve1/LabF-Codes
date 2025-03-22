module debouncer
(input clk, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
    input [4:0] button_in, 
    output reg [4:0] button_out
);

localparam threshold = 24'hFFFFFF;
reg [26:0] counter; 


reg [4:0] button_d1, button_d2; 
always @ (posedge clk) 
begin
    button_d1 <= button_in;
    button_d2 <= button_d1;
end

always @(posedge clk or posedge reset)
    begin
        if(reset==1) begin
            counter <= 1;
            button_out <= 0;
        end
        else begin
            button_out <= 0;
            if (|button_d2) begin
                 if(~&counter) 
                     counter <= counter + 1;
            end
            else begin
                if (|counter) 
                    counter <= counter - 1;
            end
            if (counter > threshold) begin
                button_out <= button_d2;
                counter <= 0;
            end
        end
    end 
 

 endmodule