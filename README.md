# hdl-sim

A Verilog subset simulator written in OCaml. Parses, elaborates, and simulates Verilog designs, generating VCD waveform output.

## Features

- **Verilog parsing** via OCamllex + Menhir
- **Elaboration**: symbol resolution, width inference, multi-driver detection, combinational cycle detection
- **Simulation**: cycle-based evaluation with topological ordering of combinational logic
- **VCD output**: waveform files compatible with standard EDA viewers (GTKWave, etc.)
- **Error detection**: invalid assignments, width mismatches, cycles, and more

## Supported Verilog Subset

- Module declarations with input/output/wire/reg ports
- `assign` (continuous assignment)
- `always @(posedge clk)` (synchronous sequential logic)
- `always @*` (combinational logic)
- Arithmetic, bitwise, logical, shift, and ternary operators
- Bit selection, part selection, and concatenation
- Sized numeric literals (binary, decimal, hex)

## Building

Requires OCaml, [Dune](https://dune.build/) >= 3.20, and [Menhir](https://gallium.inria.fr/~fpottier/menhir/) >= 3.0.

```bash
dune build
```

## Running

**Run built-in example circuits (parallel counters):**
```bash
dune exec bin/main.exe
```

**Simulate a Verilog file and check correctness:**
```bash
dune exec bin/verilog_sim.exe [test_name]
```

Available test names: `counter`, `alu`, `register`, `mux`, `invalid`, `all`

**Debug drivers (print intermediate representations):**
```bash
dune exec bin/parse_driver.exe   # Parse tree only
dune exec bin/elab_driver.exe    # After elaboration
dune exec bin/lower_driver.exe   # After lowering to final AST
```

## Testing

```bash
dune test
```

Unit tests cover the `Graph` module (DAG construction and topological sort).

## Project Structure

```
bin/           Executable entry points
lib/           Core simulator library
  Lexer.mll      Tokenizer
  Parser.mly     Menhir grammar
  Ptree.ml       Parse tree types
  Elaborate.ml   Elaboration pass
  Elab_ir.ml     Elaborated IR types
  AstConv.ml     Lowering + topological ordering
  Ast.ml         Final AST types
  Graph.ml       DAG and topological sort
  EvalEnv.ml     Circuit compilation and evaluation
  Vcd.ml         VCD waveform writer
  Operations.ml  Operator definitions
examples/      Verilog test files (valid and invalid)
test/          Unit tests
```

## Compilation Pipeline

```
Verilog source
  → Lexer/Parser  → Parse tree (Ptree)
  → Elaborate     → Elaborated IR (Elab_ir) — validates semantics
  → AstConv       → Final AST (Ast) — topologically ordered
  → EvalEnv       → Compiled netlist
  → Simulate      → Cycle-by-cycle evaluation
  → Vcd           → .vcd waveform output
```

## Example Output

Running `dune exec bin/verilog_sim.exe counter` simulates an 8-bit counter with reset, prints cycle-by-cycle output, checks expected values, and writes a `counter.vcd` file.

## Error Detection

The simulator catches and reports:

| Error | Example file |
|-------|-------------|
| Assignment to input port | `invalid_assign_input.v` |
| Combinational cycle | `invalid_cycle.v` |
| Width mismatch | `invalid_width.v` |
| Multiple drivers | `invalid_multi_driver.v` |
| Invalid sensitivity list | `invalid_sensitivity.v` |
| Blocking assignment in sequential block | `invalid_blocking_in_ff.v` |
