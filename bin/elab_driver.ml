(* Elaboration driver to test the Verilog elaborator *)

open Verilog_parser
open Verilog_elab

let string_of_def_kind = function
  | Elab_ir.DefInput -> "input"
  | Elab_ir.DefNet -> "net"
  | Elab_ir.DefReg -> "reg"

let rec string_of_eexpr = function
  | Elab_ir.EEVar (v, w) -> Printf.sprintf "%s[%d]" v w
  | Elab_ir.EEConst (value, w) -> Printf.sprintf "%d'd%d" w value
  | Elab_ir.EEUnop (op, e, w) ->
    let op_str = match op with Ptree.UNot -> "!" | Ptree.UBitNot -> "~" in
    Printf.sprintf "%s(%s)[%d]" op_str (string_of_eexpr e) w
  | Elab_ir.EEBinop (op, e1, e2, w) ->
    let op_str = match op with
      | Ptree.BAdd -> "+" | Ptree.BSub -> "-" | Ptree.BMul -> "*" 
      | Ptree.BDiv -> "/" | Ptree.BMod -> "%"
      | Ptree.BShl -> "<<" | Ptree.BShr -> ">>"
      | Ptree.BLt -> "<" | Ptree.BLe -> "<=" | Ptree.BGt -> ">" | Ptree.BGe -> ">="
      | Ptree.BEq -> "==" | Ptree.BNe -> "!="
      | Ptree.BAnd -> "&" | Ptree.BOr -> "|" | Ptree.BXor -> "^"
      | Ptree.BLAnd -> "&&" | Ptree.BLOr -> "||"
    in
    Printf.sprintf "(%s %s %s)[%d]" (string_of_eexpr e1) op_str (string_of_eexpr e2) w
  | Elab_ir.EETernary (c, t, e, w) ->
    Printf.sprintf "(%s ? %s : %s)[%d]" (string_of_eexpr c) (string_of_eexpr t) (string_of_eexpr e) w
  | Elab_ir.EEConcat (es, w) ->
    Printf.sprintf "{%s}[%d]" (String.concat ", " (List.map string_of_eexpr es)) w
  | Elab_ir.EEIndex (e, i, w) ->
    Printf.sprintf "%s[%s][%d]" (string_of_eexpr e) (string_of_eexpr i) w
  | Elab_ir.EESlice (e, msb, lsb, w) ->
    Printf.sprintf "%s[%d:%d][%d]" (string_of_eexpr e) msb lsb w

let print_defn d =
  let rhs_str = match d.Elab_ir.def_rhs with
    | Some e -> " = " ^ string_of_eexpr e
    | None -> ""
  in
  Printf.printf "  %s %s : %d bits%s\n" 
    (string_of_def_kind d.Elab_ir.def_kind)
    d.Elab_ir.def_name
    d.Elab_ir.def_width
    rhs_str

let print_elaborated m =
  Printf.printf "Elaborated Module: %s\n" m.Elab_ir.elab_name;
  
  Printf.printf "\nInputs (%d):\n" (List.length m.Elab_ir.elab_inputs);
  List.iter print_defn m.Elab_ir.elab_inputs;
  
  Printf.printf "\nNets (%d):\n" (List.length m.Elab_ir.elab_nets);
  List.iter print_defn m.Elab_ir.elab_nets;
  
  Printf.printf "\nRegisters (%d):\n" (List.length m.Elab_ir.elab_regs);
  List.iter print_defn m.Elab_ir.elab_regs;
  
  Printf.printf "\nOutputs: %s\n" (String.concat ", " m.Elab_ir.elab_outputs)

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.eprintf "Usage: %s <file.v>\n" Sys.argv.(0);
    exit 1
  end;
  let filename = Sys.argv.(1) in
  try
    let ptree = Parse.parse_file filename in
    Printf.printf "Parsing successful.\n\n";
    let elab = Elaborate.elaborate ptree in
    print_elaborated elab;
    Printf.printf "\nElaboration successful!\n"
  with
  | Ptree.Parse_error (msg, loc) ->
    Printf.eprintf "Parse error at %s: %s\n" (Ptree.string_of_loc loc) msg;
    exit 1
  | Elab_ir.Elab_error (msg, loc) ->
    Printf.eprintf "Elaboration error at %s: %s\n" (Ptree.string_of_loc loc) msg;
    exit 1
  | Sys_error msg ->
    Printf.eprintf "Error: %s\n" msg;
    exit 1
