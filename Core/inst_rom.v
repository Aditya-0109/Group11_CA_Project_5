`define inst_mem_size 256
`define inst_mem_size_two_power 20
`define TEST_FILE "Mem_INST.mem"
// Change the name of the Test File

module inst_rom(
    input clk,
    input read_enable_cpu,
    input [31:0] cpu_addr,
    output reg [31:0] cpu_inst 
    
    );

    reg [31:0] Mem_INST [0:`inst_mem_size-1];
    integer i;
    integer len=23;
    integer current_addr = 0;
    
    // Read For CPU
    always @(*) begin
          for(i=0;i<len;i=i+1) begin
            cpu_inst=Mem_INST[i];
          end
          
//        if ((cpu_addr>>2) > 256) begin
//            cpu_inst = 32'b00000000000000000000000000010011;
//        end
//        else if (read_enable_cpu == 1) begin
//            cpu_inst = Mem_INST[cpu_addr>>2]; // PC/4, as PC=PC+4
//        end
    end
    
//    always @(posedge clk) begin
//        if (read_enable_cpu) begin
//            if (current_addr < len) begin
//                cpu_inst <= Mem_INST[current_addr];
//                current_addr <= current_addr + 1;
//            end else begin
//                // Stop reading when we have read all values
//                cpu_inst <= 32'b0;
//            end
//        end
//    end
    
    initial begin   
        $readmemb(`TEST_FILE, Mem_INST);
    end

endmodule