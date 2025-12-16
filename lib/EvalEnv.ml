open Ast
open Graph

type env = Ast.env
(* Error conditions *)

exception UnboundVariable of variable 
exception BadNet of string
exception BadApplication of exp 
exception BadIf of exp 
exception BadMatch of exp 
exception BadOp of exp * Operations.operator * exp 
exception BadPair of exp 
exception BadLogic of exp

let all_false vector = 
  List.fold_left (fun (acc:bool) (x:bool) -> if (x || (not acc)) then false else true) true vector

let pad_to_width vec width =
  let len = List.length vec in
  if len >= width then vec
  else vec @ (List.init (width - len) (fun _ -> false))

let vec_to_int (v: vector) : int =
  let rec aux lst pow acc =
    match lst with
    | [] -> acc
    | h :: t -> 
        let bit_val = if h then 1 lsl pow else 0 in
        aux t (pow + 1) (acc + bit_val)
  in
  aux v 0 0

let int_to_vec (n: int) (width: int) : vector =
  let rec aux i acc =
    if i >= width then List.rev acc
    else 
      let bit = (n land (1 lsl i)) <> 0 in
      aux (i + 1) (bit :: acc)
  in
  aux 0 []

let int_pow base exp =
  let rec aux b e acc =
    if e = 0 then acc
    else aux b (e - 1) (acc * b)
  in
  aux base exp 1

(* The first thing I need to do with an AST is to conduct the logic graph 
   To do this I need to build a netlist then call the functions to turn this into
   a dag. *)
let counter = ref 0
let build_node op inputs width is_reg is_src reg_next name: Graph.node = 
  let node = 
  {
    op = op;
    inputs = inputs;
    output = !counter;
    width = width;
    is_reg = is_reg;
    is_src = is_src;
    reg_next = reg_next;
    name = name;
  } in
  counter := !counter + 1;
  node
  

(* When I have a net_let I create a named node mapping that other nodes can take as an input by name *)
(* When I have a reg_let I create a named node mapping but I also need to build in the storage structure somehow *)
(* Each call should return a node *)

let build_netlist (env: env) (eval_loop: env -> exp -> node list) (e: Ast.exp): (node list) = 
  match e with 
    | Input (var, width, exp) -> begin
      let new_node = build_node (Some (Op Passthrough)) ([]) (width) (false) (true) (None) (Some var) in
      let new_env = update_env env var new_node in
      new_node :: eval_loop new_env exp
    end
    | Net_let (var, width, exp1, exp2) -> begin
      match eval_loop env exp1 with
        | [] -> raise (BadNet var)
        | exp1_node::nodes -> begin 
          let new_node = build_node (Some (Op Passthrough)) ([exp1_node.output]) (width) (false) (false) (None) (Some var) in 
          let new_env = update_env env var new_node in
          new_node::(exp1_node::nodes) @ eval_loop new_env exp2
        end
    end
    (* Still no explicit storage structure for register values *)
    | Reg_let (var, width , exp1, exp2) -> begin
      let new_node_output = build_node (Some (Op Passthrough)) ([]) (width) (false) (true) (None) (Some var) in 
      let new_env = update_env env var new_node_output in
      match eval_loop new_env exp1 with
        | [] -> raise (BadNet var)
        | exp1_node::nodes -> begin 
          let new_node_input = build_node (None) ([exp1_node.output]) (width) (true) (false) (Some new_node_output.output) (Some (var ^ "_in")) in
          new_node_output::new_node_input::(exp1_node::nodes) @ eval_loop new_env exp2
        end
    end
    | Const (value) -> [build_node (Some (Const value)) ([]) (List.length(value)) (false) (false) (None) (None)]
    | Var (var) -> (match lookup_env env var with 
  	  | None -> raise (UnboundVariable var)
	    | Some v -> [v])
    | Binop (op, exp1, exp2) -> begin
      match (eval_loop env exp1, eval_loop env exp2) with 
        | ([],_) -> raise (BadLogic e)
        | (_,[]) -> raise (BadLogic e)
        | (exp1_node::nodes1,exp2_node::nodes2) -> begin
          let width = match op with 
            | Land | Lor | Less | Leq | Greater | Geq | Equal | Nequal -> 1
            | _ -> max exp1_node.width exp2_node.width
          in
          let logic_node = build_node (Some (Op op)) ([exp1_node.output; exp2_node.output]) (width) (false) (false) (None) (None) in
          logic_node::(exp1_node::nodes1) @ (exp2_node::nodes2)
        end
    end
    | Unop (op, exp1) -> begin
      match eval_loop env exp1 with
        | [] -> raise (BadLogic e)
        | exp1_node::nodes1 -> begin
          let width = match op with 
            | Lnot -> 1
            | _ -> exp1_node.width
          in
          let logic_node = build_node (Some (Op op)) ([exp1_node.output]) (width) (false) (false) (None) (None) in
          logic_node::exp1_node::nodes1
        end
    end
    | Ternary (exp1, exp2, exp3) -> begin
      match (eval_loop env exp1, eval_loop env exp2, eval_loop env exp3) with 
        | ([],_,_) -> raise (BadLogic e)
        | (_,[],_) -> raise (BadLogic e)
        | (_,_,[]) -> raise (BadLogic e)
        | (exp1_node::nodes1,exp2_node::nodes2, exp3_node::nodes3) -> begin
          let logic_node = build_node (Some Ternary) ([exp1_node.output;exp2_node.output;exp3_node.output]) (max exp2_node.width exp3_node.width) (false) (false) (None) (None) in
          logic_node::(exp1_node::nodes1) @ (exp2_node::nodes2) @ (exp3_node::nodes3)
        end
    end
    | Concat (exps) -> begin
      let rec process_exps exps acc_nodes acc_outputs total_width =
        match exps with
        | [] -> (acc_nodes, List.rev acc_outputs, total_width)
        | e::es -> 
            match eval_loop env e with
            | [] -> raise (BadLogic e)
            | node::nodes -> 
                process_exps es (nodes @ acc_nodes @ [node]) (node.output :: acc_outputs) (total_width + node.width)
      in
      let (all_nodes, inputs, width) = process_exps exps [] [] 0 in
      let logic_node = build_node (Some Concat) inputs width false false None None in
      logic_node :: all_nodes
    end
    | Index (exp1, exp2) -> begin
      match (eval_loop env exp1, eval_loop env exp2) with
      | ([], _) | (_, []) -> raise (BadLogic e)
      | (node1::nodes1, node2::nodes2) ->
          let logic_node = build_node (Some Index) [node1.output; node2.output] 1 false false None None in
          logic_node :: (node1::nodes1) @ (node2::nodes2)
    end
    | Slice (exp, msb_vec, lsb_vec) -> begin
      match eval_loop env exp with
      | [] -> raise (BadLogic e)
      | node::nodes ->
          let msb_node = build_node (Some (Const msb_vec)) [] (List.length msb_vec) false false None None in
          let lsb_node = build_node (Some (Const lsb_vec)) [] (List.length lsb_vec) false false None None in
          let msb = vec_to_int msb_vec in
          let lsb = vec_to_int lsb_vec in
          let width = abs(msb - lsb) + 1 in
          let logic_node = build_node (Some Slice) [node.output; msb_node.output; lsb_node.output] width false false None None in
          logic_node :: msb_node :: lsb_node :: node :: nodes
    end




(* 
  When I have a constructed DAG from a netlist I need to be able to execute a cycle 
  
  The exec function should take a set of input states (regs+inputs) and compute a set of register + output
  states that represent the end of the cycle.

  The topologic sort return a sorted netlist and I should just be able to iterate over this and process each node

  I think I can use an env to store input+reg state and another env to store the new state
  env actually needs to store state for each link in the dag
*)
(* Maps vertexes to their values after they are computed *)
module Graph_m = Map.Make(Int)
type wires = vector Graph_m.t

let exec_comb (node: node) (state: wires) : vector =
  match node.op with 
    | Some op -> begin
      match op with 
        | Const v -> v
        | Ternary -> begin
          let e1 = Graph_m.find (List.nth node.inputs 0) state in
          let e2 = Graph_m.find (List.nth node.inputs 1) state in
          let e3 = Graph_m.find (List.nth node.inputs 2) state in
          if all_false e1 then e3 else e2
        end
        | Concat -> 
          let inputs = List.map (fun id -> Graph_m.find id state) node.inputs in
          List.concat inputs
        | Slice -> 
          let v = Graph_m.find (List.nth node.inputs 0) state in
          let msb_vec = Graph_m.find (List.nth node.inputs 1) state in
          let lsb_vec = Graph_m.find (List.nth node.inputs 2) state in
          let msb = vec_to_int msb_vec in
          let lsb = vec_to_int lsb_vec in
          let rec sublist lst start end_idx =
              if start > end_idx then []
              else 
                  let bit = if start < List.length lst then List.nth lst start else false in
                  bit :: sublist lst (start + 1) end_idx
          in
          sublist v lsb msb
        | Index -> 
          let v = Graph_m.find (List.nth node.inputs 0) state in
          let idx_vec = Graph_m.find (List.nth node.inputs 1) state in
          let idx = vec_to_int idx_vec in
          let bit = if idx < List.length v then List.nth v idx else false in
          [bit]
        | Op op -> begin
          match op with 
            | Plus -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              int_to_vec ((vec_to_int v1) + (vec_to_int v2)) node.width
            | Minus -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              int_to_vec ((vec_to_int v1) - (vec_to_int v2)) node.width
            | Mul -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              int_to_vec ((vec_to_int v1) * (vec_to_int v2)) node.width
            | Div -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              let i2 = vec_to_int v2 in
              if i2 = 0 then int_to_vec 0 node.width
              else int_to_vec ((vec_to_int v1) / i2) node.width
            | Mod -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              let i2 = vec_to_int v2 in
              if i2 = 0 then int_to_vec 0 node.width
              else int_to_vec ((vec_to_int v1) mod i2) node.width
            | Pow -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              int_to_vec (int_pow (vec_to_int v1) (vec_to_int v2)) node.width
            | Band -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              List.map2 (&&) v1 v2
            | Bor -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              List.map2 (||) v1 v2
            | Bxor -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              List.map2 (fun a b -> (a || b) && (not (a && b))) v1 v2
            | Bnand -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              List.map2 (fun a b -> not (a && b)) v1 v2
            | Bnor -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              List.map2 (fun a b -> not (a || b)) v1 v2
            | Bxnor -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              List.map2 (fun a b -> not ((a || b) && (not (a && b)))) v1 v2
            | Bnot -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              List.map (not) v1
            | Lnot -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              pad_to_width [all_false v1] node.width
            | Land -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              pad_to_width [(not (all_false v1)) && (not (all_false v2))] node.width
            | Lor -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              pad_to_width [(not (all_false v1)) || (not (all_false v2))] node.width
            | Less -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              [vec_to_int v1 < vec_to_int v2]
            | Leq -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              [vec_to_int v1 <= vec_to_int v2]
            | Greater -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              [vec_to_int v1 > vec_to_int v2]
            | Geq -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              [vec_to_int v1 >= vec_to_int v2]
            | Equal -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              [vec_to_int v1 = vec_to_int v2]
            | Nequal -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              [vec_to_int v1 <> vec_to_int v2]
            | Lsl -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              int_to_vec ((vec_to_int v1) lsl (vec_to_int v2)) node.width
            | Lsr -> 
              let v1 = Graph_m.find (List.nth node.inputs 0) state in
              let v2 = Graph_m.find (List.nth node.inputs 1) state in
              int_to_vec ((vec_to_int v1) lsr (vec_to_int v2)) node.width
            | Passthrough -> Graph_m.find (List.nth node.inputs 0) state
        end
      end
    | None -> Graph_m.find (List.nth node.inputs 0) state


let rec exec_cycle (state: wires) (out: wires) (netlist: node list) : wires =
  match netlist with 
    | [] -> out
    | node::xs -> begin
      if not node.is_src then begin
        let result = exec_comb node state in
        let state = Graph_m.add node.output result state in
        let out = Graph_m.add node.output result out in
        exec_cycle state out xs
      end else
        exec_cycle state out xs
    end

let simulate_step (netlist: node list) (inputs: wires) (registers: wires) : wires * wires =
  (* Merge inputs and registers into initial state *)
  let state = Graph_m.union (fun _k v1 _v2 -> Some v1) inputs registers in
  
  (* Execute cycle *)
  let computed_wires = exec_cycle state Graph_m.empty netlist in
  
  (* Extract next register values *)
  let next_registers = List.fold_left (fun acc node ->
    if node.is_reg then
      match node.reg_next with
      | Some src_id -> 
          let new_val = Graph_m.find node.output computed_wires in
          Graph_m.add src_id new_val acc
      | None -> acc
    else acc
  ) Graph_m.empty netlist in
  
  (computed_wires, next_registers)


let dedup lst =
  (List.fold_left (fun acc x -> if List.mem x acc then acc else x::acc) [] lst)

type circuit_interface = {
  inputs: node list;
  registers: node list;
  outputs: node list; 
}

let get_circuit_interface (netlist: node list) : circuit_interface =
  let reg_outputs = List.fold_left (fun acc node ->
    if node.is_reg then
      match node.reg_next with
      | Some id -> id :: acc
      | None -> acc
    else acc
  ) [] netlist in
  
  let inputs = List.filter (fun node ->
    node.is_src && not (List.mem node.output reg_outputs)
  ) netlist in
  
  let registers = List.filter (fun node ->
    List.mem node.output reg_outputs
  ) netlist in
  
  { inputs; registers; outputs = netlist }

let compile_circuit (e: Ast.exp) : node list =
  counter := 0;  (* Reset counter for each compilation *)
  let rec aux env e = build_netlist env aux e in
  let nodes = aux [] e in
  let netlist = { nodes } in
  let dag = create_dag netlist in
  topo_sort dag netlist

let run_simulation (e: Ast.exp) (cycles: int) (get_inputs: int -> (string * vector) list) (process_output: int -> wires -> unit) : unit =
  let sorted_nodes = compile_circuit e in
  
  (* Identify input nodes to map names to IDs *)
  let input_map = List.fold_left (fun acc node ->
    match node.name with
    | Some name when node.is_src && not node.is_reg -> (name, node.output) :: acc
    | _ -> acc
  ) [] sorted_nodes in

  (* Initialize registers to all false - use the reg_next id which points to the source node *)
  let initial_registers = List.fold_left (fun acc node ->
    if node.is_reg then
      match node.reg_next with
      | Some src_id -> Graph_m.add src_id (List.init node.width (fun _ -> false)) acc
      | None -> acc
    else acc
  ) Graph_m.empty sorted_nodes in

  let rec loop cycle registers =
    if cycle >= cycles then ()
    else
      (* Get inputs for this cycle and convert to wires map *)
      let input_list = get_inputs cycle in
      let inputs = List.fold_left (fun acc (name, vec) ->
        match List.assoc_opt name input_map with
        | Some id -> Graph_m.add id vec acc
        | None -> acc (* Ignore inputs not in the circuit *)
      ) Graph_m.empty input_list in

      let (computed_wires, next_registers) = simulate_step sorted_nodes inputs registers in
      
      (* Combine inputs, registers, and computed values for full visibility *)
      let full_state = Graph_m.union (fun _k v1 _v2 -> Some v1) inputs registers in
      let full_state = Graph_m.union (fun _k v1 _v2 -> Some v1) full_state computed_wires in
      
      process_output cycle full_state;
      
      loop (cycle + 1) next_registers
  in
  loop 0 initial_registers