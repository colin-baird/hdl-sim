type vector = bool list
(* mapping index for signal LUT *)
(* nodes are identified by the id of their output signal *)
type signal_id = int
type node_id = int

(* combo logic is a node with an op *)
(* register outputs and module inputs are nodes with no op, no input *)
(* register inputs match is_reg and write their input value to the update list *)
type full_op = | Op of Operations.operator | Ternary | Concat | Slice | Index | Const of vector
type node = {
  op: full_op option;
  inputs: signal_id list;
  output: signal_id;
  width: int;
  is_reg: bool;
  is_src: bool;
  reg_next: signal_id option;
  name: string option;
}

type netlist = {
  (*
  signals: (signal_id * int) list; (* id, width *)
  *)
  nodes: node list;
}

(* Agacency list for each node can be looked up in map *)
module Graph_m = Map.Make(Int)
type dag = node list Graph_m.t

let add_child child dag id = 
  Graph_m.update id 
    (fun old -> 
      match old with 
        | Some x -> Some (child::x)
        | None -> Some [child]) dag

let create_dag netlist = 
  let rec aux dag nodes = 
    match nodes with
      | [] -> dag
      | x::xs -> aux (List.fold_left (add_child x) dag x.inputs) (xs)
  in aux Graph_m.empty netlist.nodes

let create_id_map netlist = 
  let rec aux mapping nodes = 
    match nodes with 
    | [] -> mapping
    | x::xs -> aux (Graph_m.add x.output x mapping) xs
  in
  aux Graph_m.empty netlist.nodes

(* Takes in a netlist and dag and returns a topological ordering for processing the nodes *)
let topo_sort dag netlist = 
  let visited = ref Graph_m.empty in
  let stack = ref [] in
  let rec dfs node = 
    if not (Graph_m.mem node.output !visited) then begin
      visited := Graph_m.add node.output true !visited;
      let children = 
        match Graph_m.find_opt node.output dag with
        | Some c -> c
        | None -> []
      in
      List.iter dfs children;
      stack := node::!stack
    end
  in
  List.iter dfs netlist.nodes;
  !stack




(*
(* Agacency list for each node can be looked up in map *)
module Graph_m = Map.Make(Int)
type dag = node_id list * node_id list Graph_m.t

(* Each node also needs to be able to have data associated with it, for example
input nodes need to have values while logic nodes need to have transition functions
from input to output. *)
type value_lut = vector Graph_m.t
*)
