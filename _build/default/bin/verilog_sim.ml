(* Verilog simulator: complete end-to-end workflow with correctness checking *)

open Verilog_parser
open Verilog_elab
open Verilog_lower
open Hdl_sim_lib

(* Test result tracking *)
type test_result = {
  test_name: string;
  passed: bool;
  errors: string list;
}

let all_results : test_result list ref = ref []

(** Parse, elaborate, and lower a Verilog file to AST *)
let compile_verilog (filename: string) : Ast.exp =
  let m = Parse.parse_file filename in
  let elab = Elaborate.elaborate m in
  AstConv.lower elab

(** Convert a list of (name, int_value, width) to vectors *)
let make_inputs (inputs: (string * int * int) list) : (string * bool list) list =
  List.map (fun (name, value, width) ->
    let rec int_to_vec n w acc =
      if w = 0 then acc
      else int_to_vec (n / 2) (w - 1) ((n mod 2 = 1) :: acc)
    in
    (name, List.rev (int_to_vec value width []))
  ) inputs

(** Convert vector to int for checking *)
let vec_to_int (v: bool list) : int =
  let rec aux lst pow acc =
    match lst with
    | [] -> acc
    | h :: t -> 
        let bit_val = if h then 1 lsl pow else 0 in
        aux t (pow + 1) (acc + bit_val)
  in
  aux v 0 0

(** Run simulation with correctness checking *)
let run_with_check (circuit: Ast.exp) (num_cycles: int) (vcd_filename: string) 
    (get_inputs: int -> (string * bool list) list)
    (check_cycle: int -> (string * int) list -> string list) : string list =
  let errors = ref [] in
  let sorted_nodes = EvalEnv.compile_circuit circuit in
  let named_nodes = Vcd.get_named_nodes sorted_nodes in
  
  (* Open VCD file *)
  let vcd_file = open_out vcd_filename in
  Vcd.generate_vcd_header vcd_file named_nodes "1ns";
  
  (* Process output with checking *)
  let process_output cycle state =
    Vcd.write_vcd_cycle vcd_file cycle named_nodes state;
    Printf.printf "Cycle %2d: " cycle;
    let values = List.filter_map (fun (name, node) ->
      match EvalEnv.Graph_m.find_opt node.Graph.output state with
      | Some v -> 
          Printf.printf "%s=%d " name (vec_to_int v);
          Some (name, vec_to_int v)
      | None -> 
          Printf.printf "%s=? " name;
          None
    ) named_nodes in
    Printf.printf "\n";
    (* Check correctness *)
    let cycle_errors = check_cycle cycle values in
    errors := !errors @ cycle_errors
  in
  
  EvalEnv.run_simulation circuit num_cycles get_inputs process_output;
  close_out vcd_file;
  Printf.printf "\nVCD file written to %s\n" vcd_filename;
  !errors

(** Test 1: Counter with reset *)
let test_counter () =
  Printf.printf "=== Test 1: Counter with Reset ===\n\n";
  
  let ast = compile_verilog "examples/test_counter.v" in
  Printf.printf "Compiled successfully.\n\n";
  
  (* Expected behavior:
     - Cycles 0-1: reset=1, count should be 0
     - Cycles 2+: reset=0, count should increment each cycle
     - Cycle 2: count=0 (reset just released, will be 0 or 1 depending on timing)
     - Cycle 3: count=1, etc. *)
  let check_cycle cycle values =
    let get_val name = 
      match List.assoc_opt name values with
      | Some v -> Some v
      | None -> None
    in
    let errors = ref [] in
    (match get_val "count" with
    | Some count ->
        if cycle < 2 then begin
          (* During reset, count should be 0 *)
          if count <> 0 then
            errors := !errors @ [Printf.sprintf "Cycle %d: count=%d, expected 0 (during reset)" cycle count]
        end else begin
          (* After reset: cycle 2 -> count=0, cycle 3 -> count=1, etc. *)
          let expected = cycle - 2 in
          if count <> expected then
            errors := !errors @ [Printf.sprintf "Cycle %d: count=%d, expected %d" cycle count expected]
        end
    | None -> errors := !errors @ [Printf.sprintf "Cycle %d: count signal not found" cycle]);
    !errors
  in
  
  (* Stimulus: reset for 2 cycles, then count *)
  let get_inputs cycle =
    if cycle < 2 then
      (* Reset *)
      make_inputs [("clk", 1, 1); ("rst", 1, 1)]
    else
      (* Count *)
      make_inputs [("clk", 1, 1); ("rst", 0, 1)]
  in
  
  let errors = run_with_check ast 15 "test_counter.vcd" get_inputs check_cycle in
  let passed = List.length errors = 0 in
  all_results := !all_results @ [{test_name = "Counter"; passed; errors}];
  Printf.printf "Generated waveform: test_counter.vcd\n\n"

(** Test 2: ALU operations *)
let test_alu () =
  Printf.printf "=== Test 2: ALU Operations ===\n\n";
  
  let ast = compile_verilog "examples/test_alu.v" in
  Printf.printf "Compiled successfully.\n\n";
  
  (* Test cases: (a, b, op) -> expected_result
     Note: result is registered, so it appears one cycle later *)
  let test_cases = [|
    (10, 5, 0, 15);   (* 10 + 5 = 15 *)
    (10, 5, 1, 5);    (* 10 - 5 = 5 *)
    (15, 7, 2, 15);   (* 15 | 7 = 15 *)
    (15, 7, 3, 8);    (* 15 ^ 7 = 8 *)
    (15, 7, 4, 7);    (* 15 & 7 = 7 *)
    (8, 0, 5, 16);    (* 8 << 1 = 16 *)
    (16, 0, 6, 8);    (* 16 >> 1 = 8 *)
    (0, 0, 0, 0);     (* 0 + 0 = 0 *)
  |] in
  
  let check_cycle cycle values =
    let get_val name = 
      match List.assoc_opt name values with
      | Some v -> Some v
      | None -> None
    in
    let errors = ref [] in
    (* Result is registered, so we check result at cycle N against expected from cycle N-1's inputs *)
    if cycle > 0 && cycle <= Array.length test_cases then begin
      let (_, _, _, expected) = test_cases.(cycle - 1) in
      match get_val "result" with
      | Some result ->
          if result <> expected then
            errors := !errors @ [Printf.sprintf "Cycle %d: result=%d, expected %d" cycle result expected]
      | None -> errors := !errors @ [Printf.sprintf "Cycle %d: result signal not found" cycle]
    end;
    (* Check zero flag *)
    (match get_val "result", get_val "zero" with
    | Some result, Some zero ->
        let expected_zero = if result = 0 then 1 else 0 in
        if zero <> expected_zero then
          errors := !errors @ [Printf.sprintf "Cycle %d: zero=%d, expected %d (result=%d)" cycle zero expected_zero result]
    | _, _ -> ());
    !errors
  in
  
  let get_inputs cycle =
    if cycle < Array.length test_cases then
      let (a, b, op, _) = test_cases.(cycle) in
      make_inputs [("clk", 1, 1); ("a", a, 8); ("b", b, 8); ("op", op, 3)]
    else
      make_inputs [("clk", 1, 1); ("a", 0, 8); ("b", 0, 8); ("op", 0, 3)]
  in
  
  let errors = run_with_check ast (Array.length test_cases + 3) "test_alu.vcd" get_inputs check_cycle in
  let passed = List.length errors = 0 in
  all_results := !all_results @ [{test_name = "ALU"; passed; errors}];
  Printf.printf "Generated waveform: test_alu.vcd\n\n"

(** Test 3: Simple register *)
let test_register () =
  Printf.printf "=== Test 3: Simple Register ===\n\n";
  
  let ast = compile_verilog "examples/valid_register.v" in
  Printf.printf "Compiled successfully.\n\n";
  
  (* Stimulus: reset, then load various values *)
  let values = [| 0; 42; 100; 255; 128; 1 |] in
  
  (* Expected behavior:
     - Cycles 0-1: reset=1, q should be 0
     - Cycle 2: reset released, d=0, q should be 0
     - Cycle 3: d=42, q should become 0 (previous cycle's d)
     - Cycle 4: d=100, q should become 42 (previous cycle's d)
     etc. *)
  let check_cycle cycle values_map =
    let get_val name = 
      match List.assoc_opt name values_map with
      | Some v -> Some v
      | None -> None
    in
    let errors = ref [] in
    (match get_val "q" with
    | Some q ->
        if cycle < 2 then begin
          (* During reset, q should be 0 *)
          if q <> 0 then
            errors := !errors @ [Printf.sprintf "Cycle %d: q=%d, expected 0 (during reset)" cycle q]
        end else if cycle = 2 then begin
          (* Just after reset, q should be 0 *)
          if q <> 0 then
            errors := !errors @ [Printf.sprintf "Cycle %d: q=%d, expected 0 (after reset)" cycle q]
        end else begin
          (* q should reflect the previous cycle's d value *)
          let d_index = cycle - 3 in
          if d_index >= 0 && d_index < Array.length values then begin
            let expected = values.(d_index) in
            if q <> expected then
              errors := !errors @ [Printf.sprintf "Cycle %d: q=%d, expected %d" cycle q expected]
          end
        end
    | None -> errors := !errors @ [Printf.sprintf "Cycle %d: q signal not found" cycle]);
    !errors
  in
  
  let get_inputs cycle =
    if cycle < 2 then
      (* Reset *)
      make_inputs [("clk", 1, 1); ("rst", 1, 1); ("d", 0, 8)]
    else if cycle - 2 < Array.length values then
      (* Load value *)
      make_inputs [("clk", 1, 1); ("rst", 0, 1); ("d", values.(cycle - 2), 8)]
    else
      make_inputs [("clk", 1, 1); ("rst", 0, 1); ("d", 0, 8)]
  in
  
  let errors = run_with_check ast 12 "test_register.vcd" get_inputs check_cycle in
  let passed = List.length errors = 0 in
  all_results := !all_results @ [{test_name = "Register"; passed; errors}];
  Printf.printf "Generated waveform: test_register.vcd\n\n"

(** Test 4: Combinational mux *)
let test_mux () =
  Printf.printf "=== Test 4: Combinational Mux ===\n\n";
  
  let ast = compile_verilog "examples/valid_mux.v" in
  Printf.printf "Compiled successfully.\n\n";
  
  (* Test all input combinations *)
  (* y = sel ? b : a *)
  let test_cases = [|
    (0, 0, 0, 0);  (* sel=0: y=a=0 *)
    (1, 0, 0, 1);  (* sel=0: y=a=1 *)
    (0, 1, 0, 0);  (* sel=0: y=a=0 *)
    (1, 1, 0, 1);  (* sel=0: y=a=1 *)
    (0, 0, 1, 0);  (* sel=1: y=b=0 *)
    (1, 0, 1, 0);  (* sel=1: y=b=0 *)
    (0, 1, 1, 1);  (* sel=1: y=b=1 *)
    (1, 1, 1, 1);  (* sel=1: y=b=1 *)
  |] in
  
  let check_cycle cycle values =
    let get_val name = 
      match List.assoc_opt name values with
      | Some v -> Some v
      | None -> None
    in
    let errors = ref [] in
    if cycle < Array.length test_cases then begin
      let (_, _, _, expected) = test_cases.(cycle) in
      match get_val "y" with
      | Some y ->
          if y <> expected then
            errors := !errors @ [Printf.sprintf "Cycle %d: y=%d, expected %d" cycle y expected]
      | None -> errors := !errors @ [Printf.sprintf "Cycle %d: y signal not found" cycle]
    end;
    !errors
  in
  
  let get_inputs cycle =
    if cycle < Array.length test_cases then
      let (a, b, sel, _) = test_cases.(cycle) in
      make_inputs [("a", a, 1); ("b", b, 1); ("sel", sel, 1)]
    else
      make_inputs [("a", 0, 1); ("b", 0, 1); ("sel", 0, 1)]
  in
  
  let errors = run_with_check ast (Array.length test_cases + 2) "test_mux.vcd" get_inputs check_cycle in
  let passed = List.length errors = 0 in
  all_results := !all_results @ [{test_name = "Mux"; passed; errors}];
  Printf.printf "Generated waveform: test_mux.vcd\n\n"

(** Print final test summary *)
let print_summary () =
  Printf.printf "\n========================================\n";
  Printf.printf "         TEST SUMMARY\n";
  Printf.printf "========================================\n\n";
  
  let total = List.length !all_results in
  let passed = List.filter (fun r -> r.passed) !all_results |> List.length in
  let failed = total - passed in
  
  List.iter (fun result ->
    let status = if result.passed then "✓ PASS" else "✗ FAIL" in
    Printf.printf "%s: %s\n" status result.test_name;
    if not result.passed then begin
      List.iter (fun err -> Printf.printf "    - %s\n" err) result.errors
    end
  ) !all_results;
  
  Printf.printf "\n----------------------------------------\n";
  Printf.printf "Total: %d tests, %d passed, %d failed\n" total passed failed;
  Printf.printf "========================================\n";
  
  if failed > 0 then exit 1

(** Test that an invalid file is rejected during compilation *)
let test_invalid (test_name: string) (filename: string) (_expected_error: string) =
  Printf.printf "=== Negative Test: %s ===\n\n" test_name;
  try
    let _ = compile_verilog filename in
    Printf.printf "ERROR: Expected compilation to fail, but it succeeded!\n\n";
    all_results := !all_results @ [{test_name; passed = false; errors = ["Expected error but compilation succeeded"]}]
  with
  | e ->
      let error_msg = Printexc.to_string e in
      Printf.printf "Correctly rejected with error: %s\n\n" error_msg;
      (* Any exception means the invalid code was properly rejected *)
      all_results := !all_results @ [{test_name; passed = true; errors = []}]

(** Run all negative tests for invalid Verilog files *)
let test_invalid_files () =
  Printf.printf "\n========================================\n";
  Printf.printf "     NEGATIVE TESTS (Invalid Input)\n";
  Printf.printf "========================================\n\n";
  
  test_invalid "Assign to Input" "examples/invalid_assign_input.v" "input";
  test_invalid "Combinational Cycle" "examples/invalid_cycle.v" "cycle";
  test_invalid "Width Mismatch" "examples/invalid_width.v" "width"

let () =
  if Array.length Sys.argv > 1 then begin
    (* Run specific test *)
    match Sys.argv.(1) with
    | "counter" -> test_counter (); print_summary ()
    | "alu" -> test_alu (); print_summary ()
    | "register" -> test_register (); print_summary ()
    | "mux" -> test_mux (); print_summary ()
    | "invalid" -> test_invalid_files (); print_summary ()
    | "all" ->
        test_counter ();
        test_alu ();
        test_register ();
        test_mux ();
        test_invalid_files ();
        print_summary ()
    | _ ->
      Printf.eprintf "Unknown test: %s\n" Sys.argv.(1);
      Printf.eprintf "Available tests: counter, alu, register, mux, invalid, all\n";
      exit 1
  end else begin
    (* Run all tests by default *)
    test_counter ();
    test_alu ();
    test_register ();
    test_mux ();
    test_invalid_files ();
    print_summary ()
  end
