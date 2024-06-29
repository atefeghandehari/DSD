module tb8_STACK_BASED_ALU;
    parameter n = 8;  
    reg [n-1:0] input_data;
    reg [2:0] opcode;
    wire [n-1:0] output_data;
    wire overflow;
    
    STACK_BASED_ALU #(n) alu (
        .input_data(input_data),
        .opcode(opcode),
        .output_data(output_data),
        .overflow(overflow)
    );
    
    initial begin
        opcode = 3'b110; input_data = 8'd10; #10;  
        opcode = 3'b110; input_data = 8'd20; #10;  
        opcode = 3'b100; #10;  
        $display("Addition: %d, Overflow: %b", output_data, overflow);
        
        opcode = 3'b110; input_data = 8'd3; #10;  
        opcode = 3'b110; input_data = 8'd4; #10;  
        opcode = 3'b101; #10;  
        $display("Multiplication: %d, Overflow: %b", output_data, overflow);
        
        opcode = 3'b111; #10;  
        $display("POP: %d", output_data);
        
        opcode = 3'b110; input_data = 8'h7F; #10;  
        opcode = 3'b110; input_data = 8'd1; #10;  
        opcode = 3'b100; #10;  // ADD
        $display("Addition with overflow: %d, Overflow: %b", output_data, overflow);
        
        opcode = 3'b110; input_data = 8'h80; #10;  
        opcode = 3'b110; input_data = 8'd2; #10;  
        opcode = 3'b101; #10;  
        $display("Multiplication with overflow: %d, Overflow: %b", output_data, overflow);
        
        $finish;
    end
endmodule
