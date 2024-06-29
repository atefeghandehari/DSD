module PostfixEvaluator (
    input [2047:0] postfix, // Input postfix expression, maximum length 256 characters (8 bits each)
    output reg [31:0] result, // Output result
    output reg overflow // Overflow flag
);
    reg [31:0] input_data;
    reg [2:0] opcode;
    wire [31:0] output_data;
    wire alu_overflow;

    // Instantiate the ALU module
    STACK_BASED_ALU #(32) alu (
        .input_data(input_data),
        .opcode(opcode),
        .output_data(output_data),
        .overflow(alu_overflow)
    );

    reg [31:0] stack [0:255];
    integer sp;
    integer i;
    reg [7:0] current_char;
    reg done; // Variable to manage loop exit

    initial begin
        sp = 0;
        overflow = 0;
        done = 0;
        for (i = 0; i < 256 && !done; i = i + 1) begin
            current_char = postfix[i*8 +: 8];
            if (current_char == 8'd0) done = 1;
            else begin
                case (current_char)
                    8'd42: begin  // '*'
                        opcode = 3'b101;
                        #10; // Wait for ALU operation
                        stack[sp-2] = output_data;
                        sp = sp - 1;
                    end
                    8'd43: begin  // '+'
                        opcode = 3'b100;
                        #10; // Wait for ALU operation
                        stack[sp-2] = output_data;
                        sp = sp - 1;
                    end
                    8'd45: begin  // '-'
                        // Subtraction is not defined in the provided ALU, assuming a workaround using addition of negative numbers
                        opcode = 3'b110;
                        input_data = -stack[sp-1];
                        #10; // Push negative of the top value
                        opcode = 3'b100;
                        #10; // Perform addition
                        stack[sp-2] = output_data;
                        sp = sp - 1;
                    end
                    default: begin  // Operand
                        opcode = 3'b110;
                        input_data = current_char - 8'd48; // Convert ASCII to integer
                        #10; // Wait for ALU operation
                        stack[sp] = input_data;
                        sp = sp + 1;
                    end
                endcase
            end
        end
        result = stack[sp-1];
        overflow = alu_overflow;
    end
endmodule
