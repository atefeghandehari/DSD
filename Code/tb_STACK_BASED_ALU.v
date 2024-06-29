module tb_STACK_BASED_ALU;
    parameter n = 8;  
    reg [n-1:0] input_data;
    reg [2:0] opcode;
    wire [n-1:0] output_data;
    wire overflow;
    
    // Instantiate the ALU module
    STACK_BASED_ALU #(n) alu (
        .input_data(input_data),
        .opcode(opcode),
        .output_data(output_data),
        .overflow(overflow)
    );
    
    initial begin
        // Test addition
        opcode = 3'b110; input_data = 8'd10; #10;  // PUSH 10
        opcode = 3'b110; input_data = 8'd20; #10;  // PUSH 20
        opcode = 3'b100; #10;  // ADD
        $display("Addition: %d, Overflow: %b", output_data, overflow);
        
        // Test multiplication
        opcode = 3'b110; input_data = 8'd3; #10;  // PUSH 3
        opcode = 3'b110; input_data = 8'd4; #10;  // PUSH 4
        opcode = 3'b101; #10;  // MULTIPLY
        $display("Multiplication: %d, Overflow: %b", output_data, overflow);
        
        // Test POP
        opcode = 3'b111; #10;  // POP
        $display("POP: %d", output_data);
        
        // Test overflow detection in addition
        opcode = 3'b110; input_data = 8'h7F; #10;  // PUSH Max positive int
        opcode = 3'b110; input_data = 8'd1; #10;  // PUSH 1
        opcode = 3'b100; #10;  // ADD
        $display("Addition with overflow: %d, Overflow: %b", output_data, overflow);
        
        // Test overflow detection in multiplication
        opcode = 3'b110; input_data = 8'h80; #10;  // PUSH Max negative int
        opcode = 3'b110; input_data = 8'd2; #10;  // PUSH 2
        opcode = 3'b101; #10;  // MULTIPLY
        $display("Multiplication with overflow: %d, Overflow: %b", output_data, overflow);
        
        $finish;
    end
endmodule
