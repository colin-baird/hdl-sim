(** Elaborate: Main elaboration pass for Verilog parse tree.
    
    Transforms Ptree.vmodule into Elab_ir.elaborated_module with:
    - Symbol resolution
    - Width inference and checking
    - Separation of combinational and sequential logic
    - Dependency graph construction and cycle detection
*)

open Ptree
open Elab_ir

(* ============================================================ *)
(* Utility functions                                             *)
(* ============================================================ *)

(** Compute minimum bits needed to represent a non-negative value *)
let min_width_for_value v =
  if v = 0 then 1
  else
    let rec count_bits n acc =
      if n = 0 then acc
      else count_bits (n lsr 1) (acc + 1)
    in
    count_bits v 0

(** Parse a numeric literal to integer value *)
let parse_literal (lit: num_literal) : int =
  let digits = lit.digits in
  match lit.base with
  | BinBase -> int_of_string ("0b" ^ digits)
  | DecBase -> int_of_string digits
  | HexBase -> int_of_string ("0x" ^ digits)

(** Get width of a numeric literal *)
let literal_width (lit: num_literal) : int =
  match lit.width with
  | Some w -> w
  | None -> 
    (* Unsized decimal: minimum width to represent *)
    let value = parse_literal lit in
    min_width_for_value value

(* ============================================================ *)
(* Symbol Table Construction                                     *)
(* ============================================================ *)

(** Try to evaluate a range expression to a constant *)
let rec eval_const_expr (e: expr) : int option =
  match e with
  | ENum lit -> Some (parse_literal lit)
  | EParen (e', _) -> eval_const_expr e'
  | EBinop (op, e1, e2, _) ->
    (match eval_const_expr e1, eval_const_expr e2 with
     | Some v1, Some v2 ->
       Some (match op with
         | BAdd -> v1 + v2
         | BSub -> v1 - v2
         | BMul -> v1 * v2
         | BDiv -> if v2 = 0 then 0 else v1 / v2
         | BMod -> if v2 = 0 then 0 else v1 mod v2
         | BShl -> v1 lsl v2
         | BShr -> v1 lsr v2
         | _ -> 0)  (* Other ops not typically used in ranges *)
     | _ -> None)
  | EUnop (_, e', _) ->
    (match eval_const_expr e' with
     | Some v -> Some (lnot v)  (* Simplified *)
     | None -> None)
  | _ -> None

(** Compute width from a range specification *)
let width_of_range (msb_expr, lsb_expr) loc : int =
  match eval_const_expr msb_expr, eval_const_expr lsb_expr with
  | Some msb, Some lsb ->
    let w = abs (msb - lsb) + 1 in
    if w <= 0 then
      elab_error "invalid range: width must be positive" loc
    else w
  | _ ->
    elab_error "range bounds must be constant expressions" loc

(** Build symbol table from ports and declarations *)
let build_symbol_table (m: vmodule) : symtab =
  let add_symbol tab name kind width loc =
    if SymbolTable.mem name tab then
      elab_error (Printf.sprintf "duplicate declaration of '%s'" name) loc
    else
      SymbolTable.add name { sym_name = name; sym_kind = kind; sym_width = width; sym_loc = loc } tab
  in
  
  (* Process ports *)
  let tab = List.fold_left (fun tab port ->
    let width = match port.port_range with
      | Some r -> width_of_range r port.port_loc
      | None -> 1
    in
    if width <= 0 then
      elab_error "port width must be positive" port.port_loc;
    let kind = match port.port_dir with
      | DirInput -> SymInput
      | DirOutput -> SymOutput
    in
    add_symbol tab port.port_name kind width port.port_loc
  ) SymbolTable.empty m.mod_ports in
  
  (* Process internal declarations *)
  let tab = List.fold_left (fun tab decl ->
    let width = match decl.var_range with
      | Some r -> width_of_range r decl.var_loc
      | None -> 1
    in
    if width <= 0 then
      elab_error "declaration width must be positive" decl.var_loc;
    (* Check if this shadows a port - that's an error *)
    if SymbolTable.mem decl.var_name tab then begin
      let existing = SymbolTable.find decl.var_name tab in
      match existing.sym_kind with
      | SymInput | SymOutput ->
        elab_error (Printf.sprintf "internal declaration '%s' shadows port" decl.var_name) decl.var_loc
      | _ ->
        elab_error (Printf.sprintf "duplicate declaration of '%s'" decl.var_name) decl.var_loc
    end;
    let kind = match decl.var_kind with
      | VarWire -> SymWire
      | VarReg -> SymReg
    in
    add_symbol tab decl.var_name kind width decl.var_loc
  ) tab m.mod_decls in
  
  tab

(** Look up a symbol, raising an error if not found *)
let lookup_symbol (tab: symtab) (name: string) (loc: loc) : symbol =
  match SymbolTable.find_opt name tab with
  | Some sym -> sym
  | None -> elab_error (Printf.sprintf "undeclared identifier '%s'" name) loc

(* ============================================================ *)
(* Expression Elaboration                                        *)
(* ============================================================ *)

(** Elaborate an expression, returning width-annotated eexpr *)
let rec elaborate_expr (tab: symtab) (e: expr) : eexpr =
  match e with
  | EId (name, loc) ->
    let sym = lookup_symbol tab name loc in
    EEVar (name, sym.sym_width)
    
  | ENum lit ->
    let value = parse_literal lit in
    let width = literal_width lit in
    EEConst (value, width)
    
  | EParen (e', _) ->
    elaborate_expr tab e'
    
  | EUnop (op, e', _loc) ->
    let ee = elaborate_expr tab e' in
    let w = eexpr_width ee in
    let result_width = match op with
      | UNot -> 1      (* Logical not always produces 1 bit *)
      | UBitNot -> w   (* Bitwise not preserves width *)
    in
    EEUnop (op, ee, result_width)
    
  | EBinop (op, e1, e2, loc) ->
    let ee1 = elaborate_expr tab e1 in
    let ee2 = elaborate_expr tab e2 in
    let w1 = eexpr_width ee1 in
    let w2 = eexpr_width ee2 in
    let result_width = match op with
      (* Arithmetic: max of operand widths *)
      | BAdd | BSub | BMul | BDiv | BMod ->
        max w1 w2
      (* Bitwise: operands must match *)
      | BAnd | BOr | BXor ->
        if w1 <> w2 then
          elab_error (Printf.sprintf "bitwise operator requires matching widths (%d vs %d)" w1 w2) loc;
        w1
      (* Shifts: result is LHS width *)
      | BShl | BShr -> w1
      (* Relational/equality: result is 1 bit *)
      | BLt | BLe | BGt | BGe | BEq | BNe -> 1
      (* Logical: result is 1 bit *)
      | BLAnd | BLOr -> 1
    in
    EEBinop (op, ee1, ee2, result_width)
    
  | ETernary (cond, then_e, else_e, loc) ->
    let econd = elaborate_expr tab cond in
    let ethen = elaborate_expr tab then_e in
    let eelse = elaborate_expr tab else_e in
    let cond_w = eexpr_width econd in
    let then_w = eexpr_width ethen in
    let else_w = eexpr_width eelse in
    if cond_w <> 1 then
      elab_error (Printf.sprintf "ternary condition must be 1 bit, got %d" cond_w) loc;
    if then_w <> else_w then
      elab_error (Printf.sprintf "ternary branches must have matching widths (%d vs %d)" then_w else_w) loc;
    EETernary (econd, ethen, eelse, then_w)
    
  | EConcat (exprs, loc) ->
    let eexprs = List.map (elaborate_expr tab) exprs in
    let total_width = List.fold_left (fun acc ee -> acc + eexpr_width ee) 0 eexprs in
    if total_width <= 0 then
      elab_error "concatenation must have positive width" loc;
    EEConcat (eexprs, total_width)
    
  | EIndex (base, idx, _loc) ->
    let ebase = elaborate_expr tab base in
    let eidx = elaborate_expr tab idx in
    (* Bit select always produces width 1 *)
    EEIndex (ebase, eidx, 1)
    
  | ESlice (base, msb, lsb, loc) ->
    let ebase = elaborate_expr tab base in
    (* Slice bounds must be constant *)
    let msb_val = match eval_const_expr msb with
      | Some v -> v
      | None -> elab_error "slice MSB must be constant" loc
    in
    let lsb_val = match eval_const_expr lsb with
      | Some v -> v
      | None -> elab_error "slice LSB must be constant" loc
    in
    let base_width = eexpr_width ebase in
    (* Validate bounds are within range *)
    if msb_val < 0 || lsb_val < 0 then
      elab_error "slice bounds must be non-negative" loc;
    if msb_val >= base_width || lsb_val >= base_width then
      elab_error (Printf.sprintf "slice bounds [%d:%d] exceed width %d" msb_val lsb_val base_width) loc;
    let slice_width = abs (msb_val - lsb_val) + 1 in
    EESlice (ebase, msb_val, lsb_val, slice_width)

(* ============================================================ *)
(* Lvalue Resolution                                             *)
(* ============================================================ *)

(** Context for assignment: combinational or sequential *)
type assign_context = 
  | CtxCombinational
  | CtxSequential

(** Elaborate an lvalue with context checking *)
let elaborate_lvalue (tab: symtab) (ctx: assign_context) (lv: lvalue) : elvalue =
  let check_assignable sym loc =
    match sym.sym_kind with
    | SymInput ->
      elab_error (Printf.sprintf "cannot assign to input '%s'" sym.sym_name) loc
    | SymOutput | SymWire ->
      (match ctx with
       | CtxSequential ->
         elab_error (Printf.sprintf "cannot assign to wire '%s' in sequential block" sym.sym_name) loc
       | CtxCombinational -> ())
    | SymReg ->
      (match ctx with
       | CtxCombinational ->
         elab_error (Printf.sprintf "cannot assign to reg '%s' in combinational block" sym.sym_name) loc
       | CtxSequential -> ())
  in
  
  match lv with
  | LVId (name, loc) ->
    let sym = lookup_symbol tab name loc in
    check_assignable sym loc;
    ELVar (name, sym.sym_width)
    
  | LVIndex (name, idx, loc) ->
    let sym = lookup_symbol tab name loc in
    check_assignable sym loc;
    let eidx = elaborate_expr tab idx in
    ELIndex (name, eidx, 1)
    
  | LVSlice (name, msb, lsb, loc) ->
    let sym = lookup_symbol tab name loc in
    check_assignable sym loc;
    let msb_val = match eval_const_expr msb with
      | Some v -> v
      | None -> elab_error "slice MSB must be constant" loc
    in
    let lsb_val = match eval_const_expr lsb with
      | Some v -> v
      | None -> elab_error "slice LSB must be constant" loc
    in
    if msb_val >= sym.sym_width || lsb_val >= sym.sym_width then
      elab_error (Printf.sprintf "slice bounds [%d:%d] exceed width %d" msb_val lsb_val sym.sym_width) loc;
    let slice_width = abs (msb_val - lsb_val) + 1 in
    ELSlice (name, msb_val, lsb_val, slice_width)

(* ============================================================ *)
(* Driver Tracking                                               *)
(* ============================================================ *)

(** Record a driver, checking for multiple drivers *)
let record_driver (drivers: drivers) (name: variable) (loc: loc) : drivers =
  match DriverMap.find_opt name drivers with
  | Some prev_loc ->
    elab_error (Printf.sprintf "multiple drivers for '%s' (previously assigned at %s)" 
      name (string_of_loc prev_loc)) loc
  | None ->
    DriverMap.add name loc drivers

(* ============================================================ *)
(* Combinational and Sequential Lowering                         *)
(* ============================================================ *)

(** Result of processing module items *)
type lower_result = {
  nets: defn list;
  regs: defn list;
  net_drivers: drivers;
  reg_drivers: drivers;
}

(** Lower a single module item *)
let lower_item (tab: symtab) (acc: lower_result) (item: item) : lower_result =
  match item with
  | ItemAssign (lv, rhs, loc) ->
    (* Continuous assignment: combinational *)
    let elv = elaborate_lvalue tab CtxCombinational lv in
    let erhs = elaborate_expr tab rhs in
    let var = elvalue_var elv in
    let sym = lookup_symbol tab var loc in
    (* Check width compatibility for full variable assignment *)
    (match elv with
     | ELVar (_, lv_width) ->
       let rhs_width = eexpr_width erhs in
       if lv_width <> rhs_width then
         elab_error (Printf.sprintf "width mismatch in assignment: %s is %d bits, RHS is %d bits" 
           var lv_width rhs_width) loc
     | _ -> ());
    let net_drivers = record_driver acc.net_drivers var loc in
    let defn = {
      def_name = var;
      def_width = sym.sym_width;
      def_rhs = Some erhs;
      def_kind = DefNet;
      def_loc = loc;
    } in
    { acc with nets = defn :: acc.nets; net_drivers }
    
  | ItemAlwaysComb (lv, rhs, loc) ->
    (* always @* : combinational *)
    let elv = elaborate_lvalue tab CtxCombinational lv in
    let erhs = elaborate_expr tab rhs in
    let var = elvalue_var elv in
    let sym = lookup_symbol tab var loc in
    (match elv with
     | ELVar (_, lv_width) ->
       let rhs_width = eexpr_width erhs in
       if lv_width <> rhs_width then
         elab_error (Printf.sprintf "width mismatch in assignment: %s is %d bits, RHS is %d bits" 
           var lv_width rhs_width) loc
     | _ -> ());
    let net_drivers = record_driver acc.net_drivers var loc in
    let defn = {
      def_name = var;
      def_width = sym.sym_width;
      def_rhs = Some erhs;
      def_kind = DefNet;
      def_loc = loc;
    } in
    { acc with nets = defn :: acc.nets; net_drivers }
    
  | ItemAlwaysFF (_clk, lv, rhs, loc) ->
    (* always @(posedge clk): sequential *)
    let elv = elaborate_lvalue tab CtxSequential lv in
    let erhs = elaborate_expr tab rhs in
    let var = elvalue_var elv in
    let sym = lookup_symbol tab var loc in
    (match elv with
     | ELVar (_, lv_width) ->
       let rhs_width = eexpr_width erhs in
       if lv_width <> rhs_width then
         elab_error (Printf.sprintf "width mismatch in assignment: %s is %d bits, RHS is %d bits" 
           var lv_width rhs_width) loc
     | _ -> ());
    let reg_drivers = record_driver acc.reg_drivers var loc in
    (* Create reg definition with next-state expression *)
    let reg_defn = {
      def_name = var;
      def_width = sym.sym_width;
      def_rhs = Some erhs;
      def_kind = DefReg;
      def_loc = loc;
    } in
    { acc with regs = reg_defn :: acc.regs; reg_drivers }

(** Lower all module items *)
let lower_items (tab: symtab) (items: item list) : lower_result =
  let init = {
    nets = [];
    regs = [];
    net_drivers = DriverMap.empty;
    reg_drivers = DriverMap.empty;
  } in
  List.fold_left (lower_item tab) init items

(* ============================================================ *)
(* Dependency Graph and Cycle Detection                          *)
(* ============================================================ *)

module StringSet = Set.Make(String)
module DepGraph = Map.Make(String)

(** Extract variable references from an expression *)
let rec expr_deps (ee: eexpr) : StringSet.t =
  match ee with
  | EEVar (v, _) -> StringSet.singleton v
  | EEConst _ -> StringSet.empty
  | EEUnop (_, e, _) -> expr_deps e
  | EEBinop (_, e1, e2, _) -> StringSet.union (expr_deps e1) (expr_deps e2)
  | EETernary (c, t, e, _) -> 
    StringSet.union (expr_deps c) (StringSet.union (expr_deps t) (expr_deps e))
  | EEConcat (es, _) -> 
    List.fold_left (fun acc e -> StringSet.union acc (expr_deps e)) StringSet.empty es
  | EEIndex (e, i, _) -> StringSet.union (expr_deps e) (expr_deps i)
  | EESlice (e, _, _, _) -> expr_deps e

(** Build dependency graph for combinational logic *)
let build_dep_graph (nets: defn list) (reg_states: StringSet.t) : StringSet.t DepGraph.t =
  List.fold_left (fun graph defn ->
    let deps = match defn.def_rhs with
      | Some rhs -> 
        (* Filter out reg states - they are sources, not same-cycle deps *)
        let all_deps = expr_deps rhs in
        StringSet.diff all_deps reg_states
      | None -> StringSet.empty
    in
    DepGraph.add defn.def_name deps graph
  ) DepGraph.empty nets

(** Detect cycles in the combinational logic graph using DFS *)
let detect_cycles (graph: StringSet.t DepGraph.t) (net_locs: loc DepGraph.t) : unit =
  let visited = ref StringSet.empty in
  let rec_stack = ref StringSet.empty in
  
  let rec dfs node path =
    if StringSet.mem node !rec_stack then begin
      (* Found a cycle - construct error message *)
      let cycle_path = node :: path in
      let cycle_str = String.concat " -> " (List.rev cycle_path) in
      let loc = match DepGraph.find_opt node net_locs with
        | Some l -> l
        | None -> dummy_loc
      in
      elab_error (Printf.sprintf "combinational cycle detected: %s" cycle_str) loc
    end;
    if not (StringSet.mem node !visited) then begin
      visited := StringSet.add node !visited;
      rec_stack := StringSet.add node !rec_stack;
      (match DepGraph.find_opt node graph with
       | Some deps -> StringSet.iter (fun dep -> dfs dep (node :: path)) deps
       | None -> ());
      rec_stack := StringSet.remove node !rec_stack
    end
  in
  
  DepGraph.iter (fun node _ -> dfs node []) graph

(* ============================================================ *)
(* Main Elaboration Entry Point                                  *)
(* ============================================================ *)

(** Elaborate a parsed module into the IR *)
let elaborate (m: vmodule) : elaborated_module =
  (* Step 1: Build symbol table *)
  let symtab = build_symbol_table m in
  
  (* Step 2: Lower all items *)
  let lower = lower_items symtab m.mod_items in
  
  (* Step 3: Build input definitions *)
  let inputs = SymbolTable.fold (fun _ sym acc ->
    match sym.sym_kind with
    | SymInput ->
      { def_name = sym.sym_name;
        def_width = sym.sym_width;
        def_rhs = None;
        def_kind = DefInput;
        def_loc = sym.sym_loc;
      } :: acc
    | _ -> acc
  ) symtab [] in
  
  (* Step 4: Collect output names *)
  let outputs = SymbolTable.fold (fun name sym acc ->
    match sym.sym_kind with
    | SymOutput -> name :: acc
    | _ -> acc
  ) symtab [] in
  
  (* Step 5: Build location map for error reporting *)
  let net_locs = List.fold_left (fun m d -> DepGraph.add d.def_name d.def_loc m) 
    DepGraph.empty lower.nets in
  
  (* Step 6: Build dependency graph and detect cycles *)
  (* Registers are treated as sources (their current value breaks cycles) *)
  let reg_names = List.fold_left 
    (fun s d -> StringSet.add d.def_name s) StringSet.empty lower.regs in
  let dep_graph = build_dep_graph lower.nets reg_names in
  detect_cycles dep_graph net_locs;
  
  (* Step 7: Verify all driven signals *)
  (* Check that all outputs have drivers *)
  List.iter (fun output_name ->
    let sym = SymbolTable.find output_name symtab in
    if not (DriverMap.mem output_name lower.net_drivers) then
      elab_error (Printf.sprintf "output '%s' has no driver" output_name) sym.sym_loc
  ) outputs;
  
  (* Check that all regs used in sequential blocks are declared *)
  DriverMap.iter (fun reg_name loc ->
    let sym = lookup_symbol symtab reg_name loc in
    match sym.sym_kind with
    | SymReg -> ()
    | _ -> elab_error (Printf.sprintf "'%s' must be a reg for sequential assignment" reg_name) loc
  ) lower.reg_drivers;
  
  (* Return elaborated module *)
  {
    elab_name = m.mod_name;
    elab_inputs = List.rev inputs;
    elab_nets = List.rev lower.nets;
    elab_regs = List.rev lower.regs;
    elab_outputs = List.rev outputs;
  }
