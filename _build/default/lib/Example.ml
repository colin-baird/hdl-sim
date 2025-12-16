open Ast

(* Example 1: Simple 4-bit counter with enable and reset *)
let counter_circuit : Ast.exp =
  Input("clk_en", 1,
  Input("reset", 1,
  Reg_let("count", 4,
    Ternary(
      Var("reset"),
      Const([false; false; false; false]),
      Ternary(
        Var("clk_en"),
        Binop(Plus, Var("count"), Const([true; false; false; false])),
        Var("count")
      )
    ),
  Net_let("count_out", 4, Var("count"),
  Const([false; false; false; false])
  ))))

let counter_inputs cycle =
  let reset = if cycle < 2 then [true] else [false] in
  let clk_en = if cycle >= 2 && cycle mod 2 = 0 then [true] else [false] in
  [("clk_en", clk_en); ("reset", reset)]

(* Example 2: Two parallel independent circuits *)
(* 
   Circuit A: 4-bit up counter (counts 0,1,2,3,...)
   Circuit B: 4-bit down counter (counts 15,14,13,...)
   
   They operate completely independently based on their own enable signals.
   Also includes a comparison output that shows when they are equal.
*)
let parallel_circuit : Ast.exp =
  (* Inputs *)
  Input("enable_up", 1,
  Input("enable_down", 1,
  Input("reset", 1,
  
  (* Up counter - increments when enable_up is high *)
  Reg_let("counter_a", 4,
    Ternary(
      Var("reset"),
      Const([false; false; false; false]),  (* Reset to 0 *)
      Ternary(
        Var("enable_up"),
        Binop(Plus, Var("counter_a"), Const([true; false; false; false])),  (* +1 *)
        Var("counter_a")
      )
    ),
  
  (* Down counter - decrements when enable_down is high *)
  Reg_let("counter_b", 4,
    Ternary(
      Var("reset"),
      Const([true; true; true; true]),  (* Reset to 15 *)
      Ternary(
        Var("enable_down"),
        Binop(Minus, Var("counter_b"), Const([true; false; false; false])),  (* -1 *)
        Var("counter_b")
      )
    ),
  
  (* Comparison: are the two counters equal? *)
  Net_let("counters_equal", 1, 
    Binop(Equal, Var("counter_a"), Var("counter_b")),
  
  (* Sum of both counters *)
  Net_let("sum", 4,
    Binop(Plus, Var("counter_a"), Var("counter_b")),
  
  (* XOR of both counters *)
  Net_let("xor_result", 4,
    Binop(Bxor, Var("counter_a"), Var("counter_b")),
  
  Const([false])
  ))))))))

let parallel_inputs cycle =
  let reset = if cycle < 2 then [true] else [false] in
  (* Up counter enabled on cycles 2,3,5,6,8,9,... (2 on, 1 off pattern) *)
  let enable_up = if cycle >= 2 && (cycle mod 3 <> 1) then [true] else [false] in
  (* Down counter enabled on every cycle after reset *)
  let enable_down = if cycle >= 2 then [true] else [false] in
  [("enable_up", enable_up); ("enable_down", enable_down); ("reset", reset)]

(* Run example 1 *)
let run_example1 () =
  Vcd.run_with_vcd counter_circuit 20 "counter_demo.vcd" counter_inputs ()

(* Run example 2 *)
let run_example2 () =
  Vcd.run_with_vcd parallel_circuit 30 "parallel_demo.vcd" parallel_inputs ()

(* Default: run example 2 (more complex) *)
let run_example = 
  Printf.printf "=== Example 1: Simple Counter ===\n\n";
  run_example1 ();
  Printf.printf "\n=== Example 2: Parallel Counters ===\n\n";
  run_example2 ()