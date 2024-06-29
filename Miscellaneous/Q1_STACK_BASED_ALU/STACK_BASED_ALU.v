module STACK_BASED_ALU #(
    parameter n = 4  
)(
    input wire [n-1:0] input_data,
    input wire [2:0] opcode,
    output reg [n-1:0] output_data,
    output reg overflow
);

    reg [n-1:0] stack [0:n-1];  
    integer sp = 0;  
    
    reg [n-1:0] op1, op2, result;
    reg [2*n-1:0] result_extended;  

    always @(*) begin
        overflow = 0;
        case (opcode)
            3'b100: begin  
                if (sp >= 2) begin
                    op1 = stack[sp-1];
                    op2 = stack[sp-2];
                    result = op1 + op2;
                    
                    if ((op1[n-1] == op2[n-1]) && (result[n-1] != op1[n-1]))
                        overflow = 1;
                    output_data = result;
                end
            end
            3'b101: begin 
                if (sp >= 2) begin
                    op1 = stack[sp-1];
                    op2 = stack[sp-2];
                    result_extended = op1 * op2;
                    
                    if (result_extended[n-1:0] != result_extended[2*n-1:n])
                        overflow = 1;
                    output_data = result_extended[n-1:0];
                end
            end
            3'b110: begin  
                if (sp < 32) begin
                    stack[sp] = input_data;
                    sp = sp + 1;
                end
            end
            3'b111: begin  
                if (sp > 0) begin
                    sp = sp - 1;
                    output_data = stack[sp];
                end
            end
            default: begin  
                output_data = 0;
            end
        endcase
    end

endmodule
