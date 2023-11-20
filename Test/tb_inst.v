`define TEST_FILE "Mem_INST.mem"

module tb_inst();

    reg clk;
    reg write_enable;
    reg read_enable_cpu;

    reg [31:0] test_instr;
    reg [31:0] tb_address;
    reg [31:0] cpu_address;

    wire [31:0] cpu_inst;

    inst_rom rom(
        clk,
        read_enable_cpu,
        cpu_address,
        cpu_inst
    );

    integer data_f;
    integer scan_f;
    integer index_address;
    reg [31:0] data_captured;

    always #5 clk = ~clk;
    initial begin
        index_address = 0;
        clk = 0;
        write_enable = 0;
        read_enable_cpu = 0;
        test_instr = 0;
        tb_address = 0;
        cpu_address = 0;
        data_f = $fopen(`TEST_FILE, "r");
        if (data_f == 0) begin
            $display("FILE DIDNT OPEN \nTRY AGAIN");
            $finish;
        end
    end
    // Initialize the ROM
    always @(negedge clk ) begin
        scan_f = $fscanf(data_f, "%b\n", data_captured);
        if($feof(data_f) == 0) begin
            $display("============  Instruction Read:%x - Write to Address: %d ============", data_captured, index_address);
            write_enable = 1;
            read_enable_cpu=1;
            if ((data_captured[6:0] == 7'b1100011) || (data_captured[6:0] == 7'b0100011)) begin
                write_enable = 0;
            end
            test_instr = data_captured;
            tb_address = index_address;
            index_address = index_address + 4;
        end
            
    end
//    always @(negedge clk) begin
//        write_enable = 1;
//        test_instr = data_captured;
//        tb_address = index_address;
//        index_address = index_address + 4;
//    end

    initial begin
        #250
        cpu_address = 4;
        read_enable_cpu = 1;
        $display("Reading From CPU Port for PC:%d - CPU Instruction:%x", cpu_address, cpu_inst);
        $finish;
    end

endmodule 