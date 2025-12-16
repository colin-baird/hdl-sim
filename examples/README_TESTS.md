# Verilog HDL Simulator - Test Examples

This directory contains end-to-end test examples demonstrating the complete Verilog-to-waveform simulation workflow.

## Current Status

### Working Examples
- **test_mux.v**: Combinational 2:1 multiplexer ✅
  - Demonstrates: Combinational logic, ternary operators
  - Output: `test_mux.vcd`

### Known Issues
- **test_counter.v**: Register updates not propagating correctly
  - The `$next` values are computed correctly, but register state isn't updating between cycles
  - This appears to be a mismatch between the lowering phase output and what the simulator expects

- **test_alu.v**: Parse error (begin/end blocks not supported in always @)
  - The parser currently only supports single-statement always blocks

## Running Tests

```bash
# Run all tests
dune exec ./bin/verilog_sim.exe

# Run specific test
dune exec ./bin/verilog_sim.exe -- mux
dune exec ./bin/verilog_sim.exe -- counter
dune exec ./bin/verilog_sim.exe -- register
dune exec ./bin/verilog_sim.exe -- alu
```

## Viewing Waveforms

Use `surfer` to view the generated VCD files:

```bash
surfer test_mux.vcd
surfer test_counter.vcd
```

## Pipeline

The complete flow is:

1. **Parse** (Lexer.mll + Parser.mly) → Parse tree (Ptree)
2. **Elaborate** (Elaborate.ml) → Elaborated IR (Elab_ir)  
   - Symbol table resolution
   - Width inference
   - Dependency analysis
3. **Lower** (AstConv.ml) → AST (Ast.ml)
   - Topological sorting using Graph.ml
   - Register handling
4. **Simulate** (EvalEnv.ml + Vcd.ml) → VCD waveform

## Next Steps

- Fix register state updates in simulation
- Investigate mismatch between lowering output and simulator expectations
- Consider whether registers should be split into state/next during lowering after all
