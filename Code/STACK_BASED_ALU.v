module STACK_BASED_ALU #(parameter n = 4) (
    input [n-1:0] input_data,
    input [2:0] opcode,
    output reg [n-1:0] output_data,
    output reg overflow
);

    reg [n-1:0] stack [0:15]; // A simple stack of 16 elements
    reg [3:0] sp; // Stack pointer
    
    initial begin
        sp = 0;
    end

    always @(*) begin
        overflow = 0;
        case(opcode)
            3'b100: begin // Addition
                {overflow, output_data} = stack[sp-1] + stack[sp-2];
            end
            3'b101: begin // Multiply
                {overflow, output_data} = stack[sp-1] * stack[sp-2];
            end
            3'b110: begin // PUSH
                stack[sp] = input_data;
                sp = sp + 1;
            end
            3'b111: begin // POP
                sp = sp - 1;
                output_data = stack[sp];
            end
            default: begin
                output_data = 0;
            end
        endcase
    end

endmodule
