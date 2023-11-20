module reg_IF_ID(
    input clk,
    input reset,

    input [4:0] stall,
    
    input [31:0] inst_if,
    input [31:0] pc_if,
    input wire do_stall,
    input br,

    output reg [31:0] pc_id,
    output reg [31:0] inst_id
    );

    always @(posedge clk) begin
        if (reset == 1 || br == 1 || (stall[2] == 0 && stall[1] == 1)) begin
            pc_id <= 0;
            inst_id <= 0;
        end
        else if(stall[1] == 0) begin
            pc_id <= pc_if;
            inst_id <= inst_if; 
        end            
    end

endmodule
