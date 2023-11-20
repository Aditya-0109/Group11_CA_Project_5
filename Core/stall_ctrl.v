module stall_ctrl(
    input reset,
    input stall_decode,
    output reg [4:0] stall_stage
    );

    always @(*) begin
        if(reset == 1) begin
            stall_stage = 5'b00000;
        end
        if(stall_decode == 1) begin
            stall_stage = 5'b00111;
        end
        else begin
            stall_stage = 5'b00000;
        end
    end

endmodule