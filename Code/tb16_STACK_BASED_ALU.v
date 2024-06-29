module tb16_STACK_BASED_ALU;
    parameter n = 16;
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
        opcode = 3'b110; input_data = 10; #10;  
        opcode = 3'b110; input_data = 20; #10;  
        opcode = 3'b100; #10;  
        $display("Addition: %b, Overflow: %b", output_data, overflow);
        
        opcode = 3'b110; input_data = 3; #10;  
        opcode = 3'b110; input_data = 4; #10;  
        opcode = 3'b101; #10;  
        $display("Multiplication: %b, Overflow: %b", output_data, overflow);
        
        
        opcode = 3'b111; #10;  
        $display("POP: %b", output_data);
        
        
        opcode = 3'b110; input_data = 16'h7FFF; #10;  
        opcode = 3'b110; input_data = 1; #10;  
        opcode = 3'b100; #10;  
        $display("Addition with overflow: %b, Overflow: %b", output_data, overflow);
        
        opcode = 3'b110; input_data = 16'h8000; #10;  
        opcode = 3'b110; input_data = 2; #10;  
        opcode = 3'b101; #10;  
        $display("Multiplication with overflow: %b, Overflow: %b", output_data, overflow);
        
        $finish;
    end
endmodule