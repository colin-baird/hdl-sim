(** AstConv: Convert elaborated IR to the AST format.
    
    This module lowers the elaborated IR to the final AST representation,
    performing topological ordering so that definitions appear after
    their dependencies.
*)

open Elab_ir

(** Conversion error *)
exception Conv_error of string

(** Get free variables in an elaborated expression *)
let rec eexpr_free_vars (e: eexpr) : string list =
  match e with
  | EEVar (v, _) -> [v]
  | EEConst (_, _) -> []
  | EEUnop (_, e1, _) -> eexpr_free_vars e1
  | EEBinop (_, e1, e2, _) -> eexpr_free_vars e1 @ eexpr_free_vars e2
  | EETernary (c, t, f, _) -> 
      eexpr_free_vars c @ eexpr_free_vars t @ eexpr_free_vars f
  | EEConcat (es, _) -> List.concat_map eexpr_free_vars es
  | EEIndex (e1, e2, _) -> eexpr_free_vars e1 @ eexpr_free_vars e2
  | EESlice (e1, _, _, _) -> eexpr_free_vars e1

(** Topological sort for variable dependencies using Graph.ml.
    
    Adapts the Graph.ml netlist/node structure to work with named definitions.
    Returns definitions in topologically sorted order (dependencies first).
*)
let topo_sort_defns (defns: defn list) (all_names: string list) : defn list =
  (* Assign unique IDs to each definition name *)
  let name_to_id = 
    List.mapi (fun i name -> (name, i)) all_names
    |> List.to_seq
    |> Hashtbl.of_seq
  in
  let id_to_defn =
    List.mapi (fun i d -> (i, d)) defns
    |> List.to_seq
    |> Hashtbl.of_seq
  in
  
  (* Build Graph.ml-compatible node structure *)
  let nodes = List.map (fun d ->
    let output_id = Hashtbl.find name_to_id d.def_name in
    let input_ids = match d.def_rhs with
      | None -> []
      | Some rhs -> 
        let deps = eexpr_free_vars rhs in
        List.filter_map (fun dep -> 
          Hashtbl.find_opt name_to_id dep
        ) deps
    in
    { Graph.op = None;
      Graph.inputs = input_ids;
      Graph.output = output_id;
      Graph.width = d.def_width;
      Graph.is_reg = false;
      Graph.is_src = (d.def_rhs = None);
      Graph.reg_next = None;
      Graph.name = Some d.def_name;
    }
  ) defns in
  
  let netlist = { Graph.nodes = nodes } in
  let dag = Graph.create_dag netlist in
  let sorted_nodes = Graph.topo_sort dag netlist in
  
  (* Convert back to definitions *)
  List.map (fun node ->
    let id = node.Graph.output in
    Hashtbl.find id_to_defn id
  ) sorted_nodes

(** Convert an integer to a bool list (vector) of given width, LSB first *)
let int_to_vector (value: int) (width: int) : bool list =
  let rec aux i acc =
    if i >= width then List.rev acc
    else 
      let bit = (value land (1 lsl i)) <> 0 in
      aux (i + 1) (bit :: acc)
  in
  aux 0 []

(** Convert Ptree unary operator to Operations operator *)
let conv_unop (op: Ptree.unop) : Operations.operator =
  match op with
  | Ptree.UNot -> Operations.Lnot
  | Ptree.UBitNot -> Operations.Bnot

(** Convert Ptree binary operator to Operations operator *)
let conv_binop (op: Ptree.binop) : Operations.operator =
  match op with
  | Ptree.BAdd -> Operations.Plus
  | Ptree.BSub -> Operations.Minus
  | Ptree.BMul -> Operations.Mul
  | Ptree.BDiv -> Operations.Div
  | Ptree.BMod -> Operations.Mod
  | Ptree.BShl -> Operations.Lsl
  | Ptree.BShr -> Operations.Lsr
  | Ptree.BLt -> Operations.Less
  | Ptree.BLe -> Operations.Leq
  | Ptree.BGt -> Operations.Greater
  | Ptree.BGe -> Operations.Geq
  | Ptree.BEq -> Operations.Equal
  | Ptree.BNe -> Operations.Nequal
  | Ptree.BAnd -> Operations.Band
  | Ptree.BOr -> Operations.Bor
  | Ptree.BXor -> Operations.Bxor
  | Ptree.BLAnd -> Operations.Land
  | Ptree.BLOr -> Operations.Lor

(** Convert an elaborated expression to an AST expression *)
let rec conv_eexpr (e: eexpr) : Ast.exp =
  match e with
  | EEVar (v, _) -> Ast.Var v
  | EEConst (value, width) -> Ast.Const (int_to_vector value width)
  | EEUnop (op, e1, _) -> Ast.Unop (conv_unop op, conv_eexpr e1)
  | EEBinop (op, e1, e2, _) -> Ast.Binop (conv_binop op, conv_eexpr e1, conv_eexpr e2)
  | EETernary (c, t, f, _) -> Ast.Ternary (conv_eexpr c, conv_eexpr t, conv_eexpr f)
  | EEConcat (es, _) -> Ast.Concat (List.map conv_eexpr es)
  | EEIndex (e1, e2, _) -> Ast.Index (conv_eexpr e1, conv_eexpr e2)
  | EESlice (e1, msb, lsb, width) -> 
      Ast.Slice (conv_eexpr e1, int_to_vector msb width, int_to_vector lsb width)

(** Convert an elaborated module to the AST format.
    
    The conversion performs topological sorting to ensure that
    definitions appear after their dependencies in the let-chain.
    
    The resulting AST is a chain of:
    1. Input declarations (no dependencies, sources only)
    2. Net declarations in topological order  
    3. Register declarations (with next-state logic referencing nets)
    4. Output expression
*)
let lower (m: elaborated_module) : Ast.exp =
  let net_names = List.map (fun d -> d.def_name) m.elab_nets in
  let reg_names = List.map (fun d -> d.def_name) m.elab_regs in
  
  (* Topologically sort all nets and registers together *)
  let all_defns = m.elab_nets @ m.elab_regs in
  let all_names = net_names @ reg_names in
  let sorted_all = topo_sort_defns all_defns all_names in
  
  (* Build the AST as a chain of let-bindings *)
  (* Start from the innermost expression and work outward *)
  
  (* The final expression returns the module outputs *)
  let terminal = 
    match m.elab_outputs with
    | [out] -> Ast.Var out
    | outs -> 
      (* Return concatenation of all outputs *)
      Ast.Concat (List.map (fun v -> Ast.Var v) outs)
  in
  
  (* Build definitions in topologically sorted order *)
  let ast = 
    List.fold_right (fun d acc ->
      match d.def_kind with
      | DefNet ->
        begin match d.def_rhs with
        | None -> acc
        | Some rhs -> Ast.Net_let (d.def_name, d.def_width, conv_eexpr rhs, acc)
        end
      | DefReg ->
        let next_state = match d.def_rhs with
          | Some rhs -> conv_eexpr rhs
          | None -> Ast.Const (int_to_vector 0 d.def_width)
        in
        Ast.Reg_let (d.def_name, d.def_width, next_state, acc)
      | DefInput -> acc  (* Inputs handled separately *)
    ) sorted_all terminal
  in
  
  (* Build input declarations (outermost) *)
  let ast = 
    List.fold_right (fun d acc ->
      Ast.Input (d.def_name, d.def_width, acc)
    ) m.elab_inputs ast
  in
  
  ast

(** Pretty-print an AST expression for debugging *)
let rec pp_exp indent (e: Ast.exp) : string =
  let ind = String.make (indent * 2) ' ' in
  match e with
  | Ast.Input (v, w, next) ->
    Printf.sprintf "%sinput %s[%d];\n%s" ind v w (pp_exp indent next)
  | Ast.Net_let (v, w, rhs, next) ->
    Printf.sprintf "%snet %s[%d] = %s;\n%s" ind v w (pp_simple_exp rhs) (pp_exp indent next)
  | Ast.Reg_let (v, w, rhs, next) ->
    Printf.sprintf "%sreg %s[%d] <= %s;\n%s" ind v w (pp_simple_exp rhs) (pp_exp indent next)
  | _ -> ind ^ pp_simple_exp e

and pp_simple_exp (e: Ast.exp) : string =
  match e with
  | Ast.Const bits -> 
    (* Reverse to print MSB first for human readability *)
    let s = String.concat "" (List.map (fun b -> if b then "1" else "0") (List.rev bits)) in
    Printf.sprintf "%d'b%s" (List.length bits) s
  | Ast.Var v -> v
  | Ast.Binop (op, e1, e2) ->
    Printf.sprintf "(%s %s %s)" (pp_simple_exp e1) (pp_op op) (pp_simple_exp e2)
  | Ast.Unop (op, e1) ->
    Printf.sprintf "%s%s" (pp_unop op) (pp_simple_exp e1)
  | Ast.Ternary (c, t, f) ->
    Printf.sprintf "(%s ? %s : %s)" (pp_simple_exp c) (pp_simple_exp t) (pp_simple_exp f)
  | Ast.Concat es ->
    Printf.sprintf "{%s}" (String.concat ", " (List.map pp_simple_exp es))
  | Ast.Index (e1, e2) ->
    Printf.sprintf "%s[%s]" (pp_simple_exp e1) (pp_simple_exp e2)
  | Ast.Slice (e1, msb, lsb) ->
    Printf.sprintf "%s[%s:%s]" (pp_simple_exp e1) (pp_simple_exp (Ast.Const msb)) (pp_simple_exp (Ast.Const lsb))
  | _ -> "<nested>"

and pp_op (op: Operations.operator) : string =
  match op with
  | Operations.Plus -> "+" | Operations.Minus -> "-" 
  | Operations.Mul -> "*" | Operations.Div -> "/" | Operations.Mod -> "%"
  | Operations.Band -> "&" | Operations.Bor -> "|" | Operations.Bxor -> "^"
  | Operations.Land -> "&&" | Operations.Lor -> "||"
  | Operations.Less -> "<" | Operations.Leq -> "<=" 
  | Operations.Greater -> ">" | Operations.Geq -> ">="
  | Operations.Equal -> "==" | Operations.Nequal -> "!="
  | Operations.Lsl -> "<<" | Operations.Lsr -> ">>"
  | _ -> "?"

and pp_unop (op: Operations.operator) : string =
  match op with
  | Operations.Lnot -> "!"
  | Operations.Bnot -> "~"
  | _ -> "?"
