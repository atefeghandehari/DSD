module ExpressionEvaluator;
    reg [2047:0] infix;
    wire [2047:0] postfix;
    wire [31:0] result;
    wire overflow;

    InfixToPostfix itp (
        .infix(infix),
        .postfix(postfix)
    );

    PostfixEvaluator pe (
        .postfix(postfix),
        .result(result),
        .overflow(overflow)
    );

    initial begin
        infix = "5 6 + 20 + 3 4 + 10 + * 3 2 * -";
        #100; 

        $display("Result: %d, Overflow: %b", result, overflow);
    end
endmodule
