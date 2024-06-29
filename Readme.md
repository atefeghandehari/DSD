![Logo](https://via.placeholder.com/600x150?text=Your+Logo+Here+600x150)

# STACK_BASED_ALU

A Verilog project for designing a stack-based arithmetic logic unit (ALU) that supports signed integers with n-bit width. This project is suitable for digital design enthusiasts and students learning about hardware description languages and ALU design.

## Tools
In this section, you should mention the hardware or simulators utilized in your project.
- ModelSim
- Quartus Prime
- Vivado
- Synopsys VCS
- Verilator

## Implementation Details

### Overview

The `STACK_BASED_ALU` module supports the following operations:
- Addition (Opcode '100')
- Multiplication (Opcode '101')
- Push to stack (Opcode '110')
- Pop from stack (Opcode '111')
- No Operation (Opcode '0xx')

Operands for addition and multiplication are the top two elements of the stack. The result is available at the output without altering the stack.

### Module Details

#### STACK_BASED_ALU
A stack-based ALU supporting basic arithmetic operations.
```verilog
module STACK_BASED_ALU #(
    parameter n = 32  // Width of the data
)(
    input wire [n-1:0] input_data,
    input wire [2:0] opcode,
    output reg [n-1:0] output_data,
    output reg overflow
);
    // Implementation details...
endmodule
```

#### Testbenches
Separate testbenches are provided for different bit widths:
- `tb4_STACK_BASED_ALU`
- `tb8_STACK_BASED_ALU`
- `tb16_STACK_BASED_ALU`
- `tb32_STACK_BASED_ALU`

Each testbench verifies the functionality of the ALU for the respective bit width.

#### InfixToPostfix
Converts infix expressions to postfix notation.
```verilog
module InfixToPostfix (
    input [2047:0] infix,
    output reg [2047:0] postfix
);
    // Implementation details...
endmodule
```

#### PostfixEvaluator
Evaluates postfix expressions using the `STACK_BASED_ALU`.
```verilog
module PostfixEvaluator (
    input [2047:0] postfix,
    output reg [31:0] result,
    output reg overflow
);
    // Implementation details...
endmodule
```

#### ExpressionEvaluator
Combines `InfixToPostfix` and `PostfixEvaluator` to evaluate infix expressions.
```verilog
module ExpressionEvaluator;
    // Implementation details...
endmodule
```

## How to Run

### Prerequisites
Ensure you have the necessary tools installed:
- ModelSim or any other Verilog simulator
- A suitable Verilog compiler (Quartus, Vivado, etc.)

### Running the Testbenches

To run the testbenches for different bit widths, use the following commands in your Verilog simulator:

#### Example for 32-bit
1. Compile the Verilog files:
```bash
vlog STACK_BASED_ALU.v tb32_STACK_BASED_ALU.v
```
2. Run the simulation:
```bash
vsim tb32_STACK_BASED_ALU
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `input_data` | `n-bit` | **Required**. Input data for ALU |
| `opcode` | `3-bit` | **Required**. Operation code |
| `output_data` | `n-bit` | **Output**. Result of the operation |
| `overflow` | `1-bit` | **Output**. Overflow flag |

## Results

The results of the simulations should verify the correct operation of the ALU. Below are some sample outputs for a 32-bit ALU:

### Addition Operation
```
Input: 10, 20
Opcode: 100 (Addition)
Output: 30
Overflow: 0
```

### Multiplication Operation
```
Input: 3, 4
Opcode: 101 (Multiply)
Output: 12
Overflow: 0
```

### Overflow Detection
```
Input: 0x7FFFFFFF, 1
Opcode: 100 (Addition)
Output: 0x80000000
Overflow: 1
```

![Sample Simulation]([https://via.placeholder.com/600x400?text=Sample+Simulation+Image](https://www.google.com/url?sa=i&url=https%3A%2F%2Fgithub.com%2FVerilog-Solutions&psig=AOvVaw0cScMb1rb5RdGz7OIC9Not&ust=1719755928878000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLjN7vDugIcDFQAAAAAdAAAAABAE))

## Related Links
Some links related to your project come here.
- [ModelSim User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683472/current/modelsim-altera-starter-edition.html)
- [Verilog HDL Reference](https://sutherland-hdl.com/pdfs/verilog_2001_ref_guide.pdf)
- [Quartus Prime Documentation](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html)

## Authors
Authors and their github link come here.
- [@Author1](https://github.com/Sharif-University-ESRLab)
- [@Author2](https://github.com/Sharif-University-ESRLab)
