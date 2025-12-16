# Verilog Parser for Small Subset

A lexer and parser for a small Verilog subset, built with OCaml using ocamllex and Menhir.

## Supported Language Subset

### Module Structure
- Single `module ... endmodule` per file
- ANSI-style ports only (declared in module header)
- No nested modules, parameters, or generate blocks

### Ports
- `input` and `output` only (no `inout`)
- Outputs must be wires (no `output reg`)
- Optional `wire` keyword on ports
- Optional packed ranges `[msb:lsb]`
- No `signed` keyword

### Declarations
- `wire` and `reg` declarations with optional ranges
- Comma-separated declarators supported

### Module Items
- `assign <lvalue> = <expr>;` (continuous assignment)
- `always @* <lvalue> = <expr>;` (combinational only, single blocking assignment)
- `always @(posedge clk) <lvalue> <= <expr>;` (sequential only, single nonblocking assignment)

### Lvalues
- Identifiers: `x`
- Bit-select: `x[i]`
- Part-select: `x[msb:lsb]`

### Expressions
- Identifiers and parenthesized expressions
- Numeric literals:
  - Unsized decimal: `42`
  - Sized with base: `8'hFF`, `4'b1010`, `8'd255`
  - No `x` or `z` digits
- Ternary: `cond ? a : b`
- Concatenation: `{e1, e2, ...}`
- Bit/part select: `e[i]`, `e[msb:lsb]`
- Operators:
  - Unary: `!` (logical not), `~` (bitwise not)
  - Arithmetic: `+`, `-`, `*`, `/`, `%`
  - Shifts: `<<`, `>>` (no arithmetic shifts `<<<`, `>>>`)
  - Relational: `<`, `<=`, `>`, `>=`
  - Equality: `==`, `!=`
  - Bitwise: `&`, `|`, `^`
  - Logical: `&&`, `||`

### Comments
- Line comments: `// ...`
- Block comments: `/* ... */`

## What's Rejected

- `output reg` (parse-time error)
- `inout` ports
- `signed` keyword
- `begin`/`end` blocks
- `if`, `case`, loops (`for`, `while`)
- `always @(...)` with explicit sensitivity lists other than `@*` or `@(posedge clk)`
- `negedge` (only `posedge` is supported)
- Multiple signals in sensitivity list (only single `posedge clk` allowed)
- `always_ff`, `always_comb` keywords (use `always @(posedge clk)` or `always @*`)
- Blocking assignment `=` in `always @(posedge clk)` (must use `<=`)
- Nonblocking assignment `<=` in `always @*` (must use `=`)
- Reduction operators (unary `&`, `|`, `^`)
- Arithmetic shifts `<<<`, `>>>`
- `x` or `z` in numeric literals
- Tasks, functions, parameters, generate

## Building

Requires OCaml with dune and menhir.

```bash
cd hdl-sim
dune build
```

## Running the Parser

```bash
# Parse a file and print the parse tree
dune exec -- verilog-parse <file.v>

# Examples
dune exec -- verilog-parse examples/valid_mux.v
dune exec -- verilog-parse examples/valid_alu.v
dune exec -- verilog-parse examples/valid_counter.v

# These should fail with descriptive errors:
dune exec -- verilog-parse examples/invalid_output_reg.v
dune exec -- verilog-parse examples/invalid_begin_end.v
dune exec -- verilog-parse examples/invalid_xz_digits.v
dune exec -- verilog-parse examples/invalid_sensitivity.v
dune exec -- verilog-parse examples/invalid_blocking_in_ff.v
```

## API Usage

```ocaml
open Verilog_parser

(* Parse from string *)
let m = Parse.parse_string "module foo(...); ... endmodule"

(* Parse from file *)
let m = Parse.parse_file "mymodule.v"

(* Handle errors *)
try
  let m = Parse.parse_file "test.v" in
  (* use m *)
with Ptree.Parse_error (msg, loc) ->
  Printf.eprintf "%s: %s\n" (Ptree.string_of_loc loc) msg
```

## Parse Tree Types

See `Ptree.mli` for the complete type definitions:

- `vmodule` - Top-level module
- `port_decl` - Port declaration with direction, name, range
- `var_decl` - Wire/reg declaration
- `item` - Module item (assign, always @*, or always @(posedge clk))
- `lvalue` - Assignment target
- `expr` - Expression (operators, literals, ternary, concat, etc.)
- `num_literal` - Numeric literal with optional width, base, digits

## File Structure

```
lib/
  Ptree.ml / Ptree.mli     - Parse tree types and locations
  Lexer.mll                - ocamllex lexer
  Parser.mly               - Menhir grammar
  Parse.ml / Parse.mli     - Wrapper with parse_string/parse_file
  dune                     - Build configuration
bin/
  parse_driver.ml          - Command-line parse driver
examples/
  valid_mux.v              - Simple mux (should parse)
  valid_alu.v              - ALU with operators (should parse)
  valid_counter.v          - Counter with posedge clk (should parse)
  invalid_output_reg.v     - output reg (should fail)
  invalid_begin_end.v      - begin/end (should fail)
  invalid_xz_digits.v      - x/z digits (should fail)
  invalid_sensitivity.v    - negedge (should fail)
  invalid_blocking_in_ff.v - blocking = in posedge (should fail)
```
