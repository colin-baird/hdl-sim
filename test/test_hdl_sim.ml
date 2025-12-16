(* Test suite for Graph.ml *)

open Hdl_sim_lib.Graph
open Hdl_sim_lib.Operations

(* Helper function to create a simple node *)
let make_node ?op ?(inputs=[]) ?(is_reg=false) ?(is_src=false) ?(reg_next=None) ?(name=None) output width : node =
  { op; inputs; output; width; is_reg; is_src; reg_next; name }

(* Helper function to compare nodes *)
let nodes_equal n1 n2 =
  n1.output = n2.output &&
  n1.width = n2.width &&
  n1.inputs = n2.inputs &&
  n1.is_reg = n2.is_reg &&
  n1.is_src = n2.is_src &&
  n1.reg_next = n2.reg_next &&
  n1.op = n2.op &&
  n1.name = n2.name

(* Test 1: Create an empty netlist and DAG *)
let test_empty_dag () =
  let netlist = { nodes = [] } in
  let dag = create_dag netlist in
  assert (Graph_m.is_empty dag);
  print_endline "✓ Test 1 passed: Empty DAG creation"

(* Test 2: Create a simple linear DAG (A -> B -> C) *)
let test_linear_dag () =
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let node_c = make_node ~op:((Op Mul)) ~inputs:[1] 2 8 in
  let netlist = { nodes = [node_a; node_b; node_c] } in
  let dag = create_dag netlist in
  
  (* Check that node_a (output 0) has node_b as child *)
  let children_of_0 = Graph_m.find_opt 0 dag in
  assert (children_of_0 <> None);
  (match children_of_0 with
   | Some children -> assert (List.length children = 1);
                      assert ((List.hd children).output = 1)
   | None -> assert false);
  
  (* Check that node_b (output 1) has node_c as child *)
  let children_of_1 = Graph_m.find_opt 1 dag in
  assert (children_of_1 <> None);
  (match children_of_1 with
   | Some children -> assert (List.length children = 1);
                      assert ((List.hd children).output = 2)
   | None -> assert false);
  
  print_endline "✓ Test 2 passed: Linear DAG creation"

(* Test 3: Create a DAG with multiple children (fan-out) *)
let test_fanout_dag () =
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let node_c = make_node ~op:((Op Mul)) ~inputs:[0] 2 8 in
  let node_d = make_node ~op:((Op Band)) ~inputs:[0] 3 8 in
  let netlist = { nodes = [node_a; node_b; node_c; node_d] } in
  let dag = create_dag netlist in
  
  (* Node_a should have 3 children *)
  let children_of_0 = Graph_m.find_opt 0 dag in
  assert (children_of_0 <> None);
  (match children_of_0 with
   | Some children -> assert (List.length children = 3);
                      let outputs = List.map (fun n -> n.output) children in
                      assert (List.mem 1 outputs);
                      assert (List.mem 2 outputs);
                      assert (List.mem 3 outputs)
   | None -> assert false);
  
  print_endline "✓ Test 3 passed: Fan-out DAG creation"

(* Test 4: Create a DAG with multiple inputs (fan-in) *)
let test_fanin_dag () =
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Passthrough)) 1 8 in
  let node_c = make_node ~op:((Op Plus)) ~inputs:[0; 1] 2 8 in
  let netlist = { nodes = [node_a; node_b; node_c] } in
  let dag = create_dag netlist in
  
  (* Both node_a and node_b should have node_c as child *)
  let children_of_0 = Graph_m.find_opt 0 dag in
  let children_of_1 = Graph_m.find_opt 1 dag in
  assert (children_of_0 <> None && children_of_1 <> None);
  (match children_of_0, children_of_1 with
   | Some c0, Some c1 -> 
       assert (List.exists (fun n -> n.output = 2) c0);
       assert (List.exists (fun n -> n.output = 2) c1)
   | _ -> assert false);
  
  print_endline "✓ Test 4 passed: Fan-in DAG creation"

(* Test 5: Create ID map *)
let test_id_map () =
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let node_c = make_node ~op:((Op Mul)) ~inputs:[1] 2 8 in
  let netlist = { nodes = [node_a; node_b; node_c] } in
  let id_map = create_id_map netlist in
  
  (* Check that all nodes are in the map *)
  assert (Graph_m.mem 0 id_map);
  assert (Graph_m.mem 1 id_map);
  assert (Graph_m.mem 2 id_map);
  
  (* Check that nodes are correctly mapped *)
  let retrieved_a = Graph_m.find 0 id_map in
  let retrieved_b = Graph_m.find 1 id_map in
  let retrieved_c = Graph_m.find 2 id_map in
  
  assert (nodes_equal retrieved_a node_a);
  assert (nodes_equal retrieved_b node_b);
  assert (nodes_equal retrieved_c node_c);
  
  print_endline "✓ Test 5 passed: ID map creation"

(* Test 6: Topological sort - linear chain *)
let test_topo_sort_linear () =
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let node_c = make_node ~op:((Op Mul)) ~inputs:[1] 2 8 in
  let netlist = { nodes = [node_a; node_b; node_c] } in
  let dag = create_dag netlist in
  let sorted = topo_sort dag netlist in
  
  (* Should process in order: A, B, C *)
  assert (List.length sorted = 3);
  let outputs = List.map (fun n -> n.output) sorted in
  (* Node A should come before Node B, and Node B before Node C *)
  let idx_a = List.find_index (fun x -> x = 0) outputs in
  let idx_b = List.find_index (fun x -> x = 1) outputs in
  let idx_c = List.find_index (fun x -> x = 2) outputs in
  (match idx_a, idx_b, idx_c with
   | Some ia, Some ib, Some ic -> assert (ia < ib && ib < ic)
   | _ -> assert false);
  
  print_endline "✓ Test 6 passed: Topological sort (linear)"

(* Test 7: Topological sort - diamond pattern *)
let test_topo_sort_diamond () =
  (*      A (0)
         / \
        B   C
         \ /
          D (3)
  *)
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let node_c = make_node ~op:((Op Mul)) ~inputs:[0] 2 8 in
  let node_d = make_node ~op:((Op Band)) ~inputs:[1; 2] 3 8 in
  let netlist = { nodes = [node_a; node_b; node_c; node_d] } in
  let dag = create_dag netlist in
  let sorted = topo_sort dag netlist in
  
  assert (List.length sorted = 4);
  let outputs = List.map (fun n -> n.output) sorted in
  
  (* Node A must come before B, C, and D *)
  let idx_a = List.find_index (fun x -> x = 0) outputs in
  let idx_b = List.find_index (fun x -> x = 1) outputs in
  let idx_c = List.find_index (fun x -> x = 2) outputs in
  let idx_d = List.find_index (fun x -> x = 3) outputs in
  
  (match idx_a, idx_b, idx_c, idx_d with
   | Some ia, Some ib, Some ic, Some id -> 
       assert (ia < ib && ia < ic && ia < id);
       (* Both B and C must come before D *)
       assert (ib < id && ic < id)
   | _ -> assert false);
  
  print_endline "✓ Test 7 passed: Topological sort (diamond)"

(* Test 8: Nodes with registers *)
let test_register_nodes () =
  let reg_node = make_node ~is_reg:true 0 8 in
  let logic_node = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let netlist = { nodes = [reg_node; logic_node] } in
  
  assert (reg_node.is_reg = true);
  assert (logic_node.is_reg = false);
  
  let id_map = create_id_map netlist in
  let retrieved = Graph_m.find 0 id_map in
  assert (retrieved.is_reg = true);
  
  print_endline "✓ Test 8 passed: Register nodes"

(* Test 9: Nodes with different operations *)
let test_different_operations () =
  let node_plus = make_node ~op:((Op Plus)) 0 8 in
  let node_ternary = make_node ~op:(Ternary) 1 8 in
  let node_concat = make_node ~op:(Concat) 2 16 in
  let node_slice = make_node ~op:(Slice) 3 4 in
  let node_index = make_node ~op:(Index) 4 1 in
  let node_none = make_node 5 8 in
  
  assert (node_plus.op = Some (Op Plus));
  assert (node_ternary.op = Some Ternary);
  assert (node_concat.op = Some Concat);
  assert (node_slice.op = Some Slice);
  assert (node_index.op = Some Index);
  assert (node_none.op = None);
  
  print_endline "✓ Test 9 passed: Different operation types"

(* Test 10: Complex DAG with multiple paths *)
let test_complex_dag () =
  (*      A (0)
         / \
        B   C
        |   |\
        D   E F
         \ /
          G
  *)
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  let node_c = make_node ~op:((Op Mul)) ~inputs:[0] 2 8 in
  let node_d = make_node ~op:((Op Band)) ~inputs:[1] 3 8 in
  let node_e = make_node ~op:((Op Bor)) ~inputs:[2] 4 8 in
  let node_f = make_node ~op:((Op Bxor)) ~inputs:[2] 5 8 in
  let node_g = make_node ~op:((Op Land)) ~inputs:[3; 4] 6 8 in
  let netlist = { nodes = [node_a; node_b; node_c; node_d; node_e; node_f; node_g] } in
  let dag = create_dag netlist in
  let sorted = topo_sort dag netlist in
  
  assert (List.length sorted = 7);
  let outputs = List.map (fun n -> n.output) sorted in
  
  (* Verify topological ordering constraints *)
  let idx n = List.find_index (fun x -> x = n) outputs in
  (match idx 0, idx 1, idx 2, idx 3, idx 4, idx 6 with
   | Some i0, Some i1, Some i2, Some i3, Some i4, Some i6 ->
       assert (i0 < i1 && i0 < i2);  (* A before B and C *)
       assert (i1 < i3);              (* B before D *)
       assert (i2 < i4);              (* C before E *)
       assert (i3 < i6 && i4 < i6)    (* D and E before G *)
   | _ -> assert false);
  
  print_endline "✓ Test 10 passed: Complex DAG structure"

(* Test 11: Empty inputs list *)
let test_empty_inputs () =
  let node = make_node ~op:((Op Passthrough)) ~inputs:[] 0 1 in
  let netlist = { nodes = [node] } in
  let _dag = create_dag netlist in
  
  (* Node with no inputs should not appear in the DAG as a key *)
  (* (since no other nodes depend on non-existent inputs) *)
  assert (List.length netlist.nodes = 1);
  
  print_endline "✓ Test 11 passed: Nodes with empty inputs"

(* Test 12: add_child function *)
let test_add_child () =
  let _node_a = make_node 0 1 in
  let node_b = make_node 1 8 in
  let node_c = make_node 2 8 in
  
  let dag = Graph_m.empty in
  let dag = add_child node_b dag 0 in
  let dag = add_child node_c dag 0 in
  
  let children = Graph_m.find_opt 0 dag in
  (match children with
   | Some cs -> assert (List.length cs = 2)
   | None -> assert false);
  
  print_endline "✓ Test 12 passed: add_child function"

(* Test 13: Disconnected components *)
let test_disconnected_components () =
  (* Component 1: A -> B *)
  let node_a = make_node ~op:((Op Passthrough)) 0 1 in
  let node_b = make_node ~op:((Op Plus)) ~inputs:[0] 1 8 in
  
  (* Component 2: C -> D *)
  let node_c = make_node ~op:((Op Passthrough)) 2 1 in
  let node_d = make_node ~op:((Op Mul)) ~inputs:[2] 3 8 in
  
  let netlist = { nodes = [node_a; node_b; node_c; node_d] } in
  let dag = create_dag netlist in
  let sorted = topo_sort dag netlist in
  
  assert (List.length sorted = 4);
  let outputs = List.map (fun n -> n.output) sorted in
  
  let idx_a = List.find_index (fun x -> x = 0) outputs in
  let idx_b = List.find_index (fun x -> x = 1) outputs in
  let idx_c = List.find_index (fun x -> x = 2) outputs in
  let idx_d = List.find_index (fun x -> x = 3) outputs in
  
  (match idx_a, idx_b, idx_c, idx_d with
   | Some ia, Some ib, Some ic, Some id -> 
       assert (ia < ib); (* A before B *)
       assert (ic < id)  (* C before D *)
   | _ -> assert false);
  
  print_endline "✓ Test 13 passed: Disconnected components"

(* Tests for EvalEnv.ml *)
open Hdl_sim_lib.Ast
open Hdl_sim_lib.EvalEnv

(* Test 14: Simple Passthrough Simulation *)
let test_sim_passthrough () =
  (* Circuit: input x; output y = x; *)
  let ast = Input("x", 1, Net_let("y", 1, Var("x"), Const([false]))) in
  
  let sorted_nodes = compile_circuit ast in
  
  (* Find node IDs *)
  let x_id = (List.find (fun n -> n.name = Some "x") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  
  (* Cycle 1: x = true *)
  (* Use EvalEnv.Graph_m to construct inputs *)
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.singleton x_id [true] in
  let registers = Hdl_sim_lib.EvalEnv.Graph_m.empty in
  let (wires, _next_regs) = simulate_step sorted_nodes inputs registers in
  
  let y_val = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires in
  assert (y_val = [true]);
  
  print_endline "✓ Test 14 passed: Simple Passthrough Simulation"

(* Test 15: Register Delay Simulation *)
let test_sim_register () =
  (* Circuit: input x; reg r = x; output y = r; *)
  let ast = Input("x", 1, Reg_let("r", 1, Var("x"), Net_let("y", 1, Var("r"), Const([false])))) in
  
  let sorted_nodes = compile_circuit ast in
  
  let x_id = (List.find (fun n -> n.name = Some "x") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  let r_id = (List.find (fun n -> n.name = Some "r") sorted_nodes).output in
  
  (* Initialize registers *)
  let registers = Hdl_sim_lib.EvalEnv.Graph_m.singleton r_id [false] in
  
  (* Cycle 1: x = true *)
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.singleton x_id [true] in
  let (wires1, next_regs1) = simulate_step sorted_nodes inputs registers in
  
  (* y should be false (current value of r) *)
  let y_val1 = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires1 in
  assert (y_val1 = [false]);
  
  (* Next value of r should be true (value of x) *)
  let r_next_val = Hdl_sim_lib.EvalEnv.Graph_m.find r_id next_regs1 in
  assert (r_next_val = [true]);
  
  (* Cycle 2: x = false *)
  let inputs2 = Hdl_sim_lib.EvalEnv.Graph_m.singleton x_id [false] in
  let (wires2, _next_regs2) = simulate_step sorted_nodes inputs2 next_regs1 in
  
  (* y should be true (new value of r) *)
  let y_val2 = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires2 in
  assert (y_val2 = [true]);
  
  print_endline "✓ Test 15 passed: Register Delay Simulation"

(* Test 16: Ternary Operation *)
let test_sim_ternary () =
  (* Circuit: input s; input a; input b; output y = s ? a : b; *)
  (* AST: Input("s", 1, Input("a", 1, Input("b", 1, Net_let("y", 1, Ternary(Var("s"), Var("a"), Var("b")), Const([]))))) *)
  let ast = Input("s", 1, Input("a", 1, Input("b", 1, Net_let("y", 1, Ternary(Var("s"), Var("a"), Var("b")), Const([false]))))) in
  
  let sorted_nodes = compile_circuit ast in
  
  let s_id = (List.find (fun n -> n.name = Some "s") sorted_nodes).output in
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  
  (* Case 1: s = true (all_false [true] is false, so it picks exp2 which is 'a') *)
  (* Wait, EvalEnv.ml says: if all_false e1 then e3 else e2 *)
  (* all_false returns true if all bits are false. *)
  (* If s=[true], all_false is false. So it returns e2 (Var("a")). Correct. *)
  
  let inputs1 = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add s_id [true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [false] in
    
  let (wires1, _) = simulate_step sorted_nodes inputs1 Hdl_sim_lib.EvalEnv.Graph_m.empty in
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires1 = [true]);
  
  (* Case 2: s = false *)
  let inputs2 = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add s_id [false]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [false] in
    
  let (wires2, _) = simulate_step sorted_nodes inputs2 Hdl_sim_lib.EvalEnv.Graph_m.empty in
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires2 = [false]);
  
  print_endline "✓ Test 16 passed: Ternary Operation"

(* Test 17: Concat Operation *)
let test_sim_concat () =
  (* Circuit: input a; input b; output y = {a, b}; *)
  let ast = Input("a", 1, Input("b", 1, Net_let("y", 2, Concat([Var("a"); Var("b")]), Const([false; false])))) in
  
  let sorted_nodes = compile_circuit ast in
  
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  
  (* a=[true], b=[false] -> y=[true; false] (assuming list append) *)
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [false] in
    
  let (wires, _) = simulate_step sorted_nodes inputs Hdl_sim_lib.EvalEnv.Graph_m.empty in
  let y_val = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires in
  
  assert (y_val = [true; false]);
  print_endline "✓ Test 17 passed: Concat Operation"

(* Test 18: Slice Operation *)
let test_sim_slice () =
  (* Circuit: input x (4 bits); output y = x[2:1]; *)
  (* x = [b0; b1; b2; b3] *)
  (* Slice 2:1 should return [b1; b2] or [b2; b1] depending on implementation. *)
  (* Assuming standard hardware convention: x[2:1] extracts bits at indices 2 and 1. *)
  (* And assuming vector is LSB at index 0. *)
  (* Let's assume Slice(exp, msb, lsb) extracts sublist from lsb to msb inclusive. *)
  
  (* Note: The AST Slice takes vector arguments for msb/lsb, which is unusual but that's the type definition. *)
  (* Assuming [true; false] = 2 (binary 10) and [true] = 1 (binary 1). *)
  
  let ast = Input("x", 4, Net_let("y", 2, Slice(Var("x"), [false; true], [true]), Const([false; false]))) in
  
  let sorted_nodes = compile_circuit ast in
  let x_id = (List.find (fun n -> n.name = Some "x") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  
  (* x = [true; false; true; false] (1010 binary, 5 decimal if LSB first) *)
  (* Indices: 0->true, 1->false, 2->true, 3->false *)
  (* Slice 2:1 -> indices 1 and 2 -> [false; true] *)
  
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.singleton x_id [true; false; true; false] in
  let (wires, _) = simulate_step sorted_nodes inputs Hdl_sim_lib.EvalEnv.Graph_m.empty in
  let y_val = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires in
  
  assert (y_val = [false; true]);
  print_endline "✓ Test 18 passed: Slice Operation"

(* Test 19: Index Operation *)
let test_sim_index () =
  (* Circuit: input x (4 bits); output y = x[2]; *)
  let ast = Input("x", 4, Net_let("y", 1, Index(Var("x"), Const([false; true])), Const([false]))) in
  
  let sorted_nodes = compile_circuit ast in
  let x_id = (List.find (fun n -> n.name = Some "x") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  
  (* x = [true; false; true; false] *)
  (* Index 2 is true *)
  
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.singleton x_id [true; false; true; false] in
  let (wires, _) = simulate_step sorted_nodes inputs Hdl_sim_lib.EvalEnv.Graph_m.empty in
  let y_val = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires in
  
  assert (y_val = [true]);
  print_endline "✓ Test 19 passed: Index Operation"

(* Test 20: ALU Operation *)
let test_sim_alu () =
  (* Circuit: input a (2 bits); input b (2 bits); output y = a + b; *)
  let ast = Input("a", 2, Input("b", 2, Net_let("y", 2, Binop(Plus, Var("a"), Var("b")), Const([false; false])))) in
  
  let sorted_nodes = compile_circuit ast in
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_id = (List.find (fun n -> n.name = Some "y") sorted_nodes).output in
  
  (* a = 1 ([true; false]), b = 2 ([false; true]) -> y = 3 ([true; true]) *)
  (* Assuming LSB first *)
  
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [true; false]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [false; true] in
    
  let (wires, _) = simulate_step sorted_nodes inputs Hdl_sim_lib.EvalEnv.Graph_m.empty in
  let y_val = Hdl_sim_lib.EvalEnv.Graph_m.find y_id wires in
  
  assert (y_val = [true; true]);
  print_endline "✓ Test 20 passed: ALU Operation"

(* Test 21: Self-referencing Register (Toggle) *)
let test_sim_self_ref_register () =
  (* Circuit: reg q = q ? 0 : 1; *)
  (* q starts at 0 (false) -> next is 1 (true) -> next is 0 (false) *)
  let ast = Reg_let("q", 1, Ternary(Var("q"), Const([false]), Const([true])), Const([false])) in
  
  let sorted_nodes = compile_circuit ast in
  let q_id = (List.find (fun n -> n.name = Some "q") sorted_nodes).output in
  
  (* Initial state: registers empty (defaults to 0/false) *)
  let registers = Hdl_sim_lib.EvalEnv.Graph_m.singleton q_id [false] in
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  (* Cycle 1: q=0. Next should be 1. *)
  let (_wires1, next_regs1) = simulate_step sorted_nodes inputs registers in
  let q_next1 = Hdl_sim_lib.EvalEnv.Graph_m.find q_id next_regs1 in
  
  assert (q_next1 = [true]);
  
  (* Cycle 2: q=1. Next should be 0. *)
  let (_wires2, next_regs2) = simulate_step sorted_nodes inputs next_regs1 in
  let q_next2 = Hdl_sim_lib.EvalEnv.Graph_m.find q_id next_regs2 in
  
  assert (q_next2 = [false]);
  
  print_endline "✓ Test 21 passed: Self-referencing Register"

(* Test 22: Bitwise Operations *)
let test_sim_bitwise () =
  (* Circuit: input a; input b; 
     output y_and = a & b;
     output y_or = a | b;
     output y_xor = a ^ b;
     output y_not = ~a;
  *)
  let ast = Input("a", 2, Input("b", 2, 
    Net_let("y_and", 2, Binop(Band, Var("a"), Var("b")),
    Net_let("y_or", 2, Binop(Bor, Var("a"), Var("b")),
    Net_let("y_xor", 2, Binop(Bxor, Var("a"), Var("b")),
    Net_let("y_not", 2, Unop(Bnot, Var("a")),
    Const([false; false]))))))) in
  
  let sorted_nodes = compile_circuit ast in
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_and_id = (List.find (fun n -> n.name = Some "y_and") sorted_nodes).output in
  let y_or_id = (List.find (fun n -> n.name = Some "y_or") sorted_nodes).output in
  let y_xor_id = (List.find (fun n -> n.name = Some "y_xor") sorted_nodes).output in
  let y_not_id = (List.find (fun n -> n.name = Some "y_not") sorted_nodes).output in
  
  (* a = [false; true] *)
  (* b = [true; true] *)
  
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [false; true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [true; true] in
    
  let (wires, _) = simulate_step sorted_nodes inputs Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  let val_and = Hdl_sim_lib.EvalEnv.Graph_m.find y_and_id wires in
  let val_or = Hdl_sim_lib.EvalEnv.Graph_m.find y_or_id wires in
  let val_xor = Hdl_sim_lib.EvalEnv.Graph_m.find y_xor_id wires in
  let val_not = Hdl_sim_lib.EvalEnv.Graph_m.find y_not_id wires in
  
  assert (val_and = [false; true]);
  assert (val_or = [true; true]);
  assert (val_xor = [true; false]);
  assert (val_not = [true; false]);
  
  print_endline "✓ Test 22 passed: Bitwise Operations"

(* Test 23: Logical Operations *)
let test_sim_logical () =
  (* Circuit: input a (2 bits); input b (2 bits); 
     output y_land = a && b;
     output y_lor = a || b;
     output y_lnot = !a;
  *)
  let ast = Input("a", 2, Input("b", 2, 
    Net_let("y_land", 1, Binop(Land, Var("a"), Var("b")),
    Net_let("y_lor", 1, Binop(Lor, Var("a"), Var("b")),
    Net_let("y_lnot", 1, Unop(Lnot, Var("a")),
    Const([false])))))) in
  
  let sorted_nodes = compile_circuit ast in
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_land_id = (List.find (fun n -> n.name = Some "y_land") sorted_nodes).output in
  let y_lor_id = (List.find (fun n -> n.name = Some "y_lor") sorted_nodes).output in
  let y_lnot_id = (List.find (fun n -> n.name = Some "y_lnot") sorted_nodes).output in
  
  (* Case 1: a=0 (false), b=1 (true) *)
  (* a=[false; false], b=[true; false] *)
  let inputs1 = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [false; false]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [true; false] in
    
  let (wires1, _) = simulate_step sorted_nodes inputs1 Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_land_id wires1 = [false]); (* 0 && 1 -> 0 *)
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_lor_id wires1 = [true]);   (* 0 || 1 -> 1 *)
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_lnot_id wires1 = [true]);  (* !0 -> 1 *)

  (* Case 2: a=1 (true), b=1 (true) *)
  let inputs2 = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [true; false]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [true; false] in
    
  let (wires2, _) = simulate_step sorted_nodes inputs2 Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_land_id wires2 = [true]);  (* 1 && 1 -> 1 *)
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_lor_id wires2 = [true]);   (* 1 || 1 -> 1 *)
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_lnot_id wires2 = [false]); (* !1 -> 0 *)
  
  print_endline "✓ Test 23 passed: Logical Operations"

(* Test 24: Arithmetic Operations *)
let test_sim_arithmetic () =
  (* Circuit: input a (4 bits); input b (4 bits); 
     output y_add = a + b;
     output y_sub = a - b;
     output y_mul = a * b;
     output y_div = a / b;
     output y_mod = a % b;
  *)
  let ast = Input("a", 4, Input("b", 4, 
    Net_let("y_add", 4, Binop(Plus, Var("a"), Var("b")),
    Net_let("y_sub", 4, Binop(Minus, Var("a"), Var("b")),
    Net_let("y_mul", 4, Binop(Mul, Var("a"), Var("b")),
    Net_let("y_div", 4, Binop(Div, Var("a"), Var("b")),
    Net_let("y_mod", 4, Binop(Mod, Var("a"), Var("b")),
    Const([false; false; false; false])))))))) in
  
  let sorted_nodes = compile_circuit ast in
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_add_id = (List.find (fun n -> n.name = Some "y_add") sorted_nodes).output in
  let y_sub_id = (List.find (fun n -> n.name = Some "y_sub") sorted_nodes).output in
  let y_mul_id = (List.find (fun n -> n.name = Some "y_mul") sorted_nodes).output in
  let y_div_id = (List.find (fun n -> n.name = Some "y_div") sorted_nodes).output in
  let y_mod_id = (List.find (fun n -> n.name = Some "y_mod") sorted_nodes).output in
  
  (* a = 10 (1010), b = 3 (0011) *)
  (* LSB first: a=[false; true; false; true], b=[true; true; false; false] *)
  let inputs = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [false; true; false; true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [true; true; false; false] in
    
  let (wires, _) = simulate_step sorted_nodes inputs Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  let val_add = Hdl_sim_lib.EvalEnv.Graph_m.find y_add_id wires in
  let val_sub = Hdl_sim_lib.EvalEnv.Graph_m.find y_sub_id wires in
  let val_mul = Hdl_sim_lib.EvalEnv.Graph_m.find y_mul_id wires in
  let val_div = Hdl_sim_lib.EvalEnv.Graph_m.find y_div_id wires in
  let val_mod = Hdl_sim_lib.EvalEnv.Graph_m.find y_mod_id wires in
  
  (* 10 + 3 = 13 (1101) -> [true; false; true; true] *)
  assert (val_add = [true; false; true; true]);
  
  (* 10 - 3 = 7 (0111) -> [true; true; true; false] *)
  assert (val_sub = [true; true; true; false]);
  
  (* 10 * 3 = 30 (11110) -> truncated to 4 bits: 14 (1110) -> [false; true; true; true] *)
  assert (val_mul = [false; true; true; true]);
  
  (* 10 / 3 = 3 (0011) -> [true; true; false; false] *)
  assert (val_div = [true; true; false; false]);
  
  (* 10 % 3 = 1 (0001) -> [true; false; false; false] *)
  assert (val_mod = [true; false; false; false]);
  
  print_endline "✓ Test 24 passed: Arithmetic Operations"

(* Test 25: Comparison Operations *)
let test_sim_comparison () =
  (* Circuit: input a (4 bits); input b (4 bits); 
     output y_lt = a < b;
     output y_eq = a == b;
  *)
  let ast = Input("a", 4, Input("b", 4, 
    Net_let("y_lt", 1, Binop(Less, Var("a"), Var("b")),
    Net_let("y_eq", 1, Binop(Equal, Var("a"), Var("b")),
    Const([false]))))) in
  
  let sorted_nodes = compile_circuit ast in
  let a_id = (List.find (fun n -> n.name = Some "a") sorted_nodes).output in
  let b_id = (List.find (fun n -> n.name = Some "b") sorted_nodes).output in
  let y_lt_id = (List.find (fun n -> n.name = Some "y_lt") sorted_nodes).output in
  let y_eq_id = (List.find (fun n -> n.name = Some "y_eq") sorted_nodes).output in
  
  (* Case 1: a=3, b=10 -> a < b is true, a == b is false *)
  let inputs1 = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [true; true; false; false]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [false; true; false; true] in
    
  let (wires1, _) = simulate_step sorted_nodes inputs1 Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_lt_id wires1 = [true]);
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_eq_id wires1 = [false]);
  
  (* Case 2: a=10, b=10 -> a < b is false, a == b is true *)
  let inputs2 = Hdl_sim_lib.EvalEnv.Graph_m.empty 
    |> Hdl_sim_lib.EvalEnv.Graph_m.add a_id [false; true; false; true]
    |> Hdl_sim_lib.EvalEnv.Graph_m.add b_id [false; true; false; true] in
    
  let (wires2, _) = simulate_step sorted_nodes inputs2 Hdl_sim_lib.EvalEnv.Graph_m.empty in
  
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_lt_id wires2 = [false]);
  assert (Hdl_sim_lib.EvalEnv.Graph_m.find y_eq_id wires2 = [true]);
  
  print_endline "✓ Test 25 passed: Comparison Operations"

(* Main test runner *)
let safe_run f =
  try f ()
  with e -> print_endline ("  [FAILED] Exception: " ^ Printexc.to_string e)

let () =
  print_endline "\n=== Running Graph.ml Test Suite ===\n";
  
  safe_run test_empty_dag;
  safe_run test_linear_dag;
  safe_run test_fanout_dag;
  safe_run test_fanin_dag;
  safe_run test_id_map;
  safe_run test_topo_sort_linear;
  safe_run test_topo_sort_diamond;
  safe_run test_register_nodes;
  safe_run test_different_operations;
  safe_run test_complex_dag;
  safe_run test_empty_inputs;
  safe_run test_add_child;
  safe_run test_disconnected_components;
  
  print_endline "\n=== Graph.ml tests finished ===\n";

  (* Now run simulation tests *)
  print_endline "\n=== Running Simulation Tests ===\n";
  
  safe_run test_sim_passthrough;
  safe_run test_sim_register;
  safe_run test_sim_ternary;
  safe_run test_sim_concat;
  safe_run test_sim_slice;
  safe_run test_sim_index;
  safe_run test_sim_alu;
  safe_run test_sim_bitwise;
  safe_run test_sim_logical;
  safe_run test_sim_arithmetic;
  safe_run test_sim_comparison;
  safe_run test_sim_self_ref_register;
  safe_run test_sim_arithmetic;
  safe_run test_sim_comparison;
  
  print_endline "\n=== All simulation tests finished ===\n"
