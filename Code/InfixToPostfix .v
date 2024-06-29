module InfixToPostfix (
    input [2047:0] infix, // Input infix expression, maximum length 256 characters (8 bits each)
    output reg [2047:0] postfix // Output postfix expression
);
    reg [7:0] stack [0:255];
    integer sp;
    integer i, j;
    reg [7:0] current_char;
    reg done; // Variable to manage loop exit

    initial begin
        sp = 0;  // Initialize stack pointer
        j = 0;  // Initialize output index
        done = 0;
        for (i = 0; i < 256 && !done; i = i + 1) begin
            current_char = infix[i*8 +: 8];
            if (current_char == 8'd0) done = 1;
            else begin
                case (current_char)
                    8'd40: begin  // '('
                        stack[sp] = current_char;
                        sp = sp + 1;
                    end
                    8'd41: begin  // ')'
                        while (sp > 0 && stack[sp-1] != 8'd40) begin
                            postfix[j*8 +: 8] = stack[sp-1];
                            sp = sp - 1;
                            j = j + 1;
                        end
                        sp = sp - 1; // Pop '('
                    end
                    8'd42, 8'd43, 8'd45: begin  // '*', '+', '-'
                        while (sp > 0 && stack[sp-1] != 8'd40) begin
                            postfix[j*8 +: 8] = stack[sp-1];
                            sp = sp - 1;
                            j = j + 1;
                        end
                        stack[sp] = current_char;
                        sp = sp + 1;
                    end
                    default: begin  // Operand
                        postfix[j*8 +: 8] = current_char;
                        j = j + 1;
                    end
                endcase
            end
        end
        
        while (sp > 0) begin
            postfix[j*8 +: 8] = stack[sp-1];
            sp = sp - 1;
            j = j + 1;
        end
        postfix[j*8 +: 8] = 8'd0; // Null terminate the postfix expression
    end
endmodule
