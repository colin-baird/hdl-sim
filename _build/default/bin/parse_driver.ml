(* Simple parse driver to test the Verilog parser *)

open Verilog_parser

let rec string_of_expr = function
  | Ptree.EId (name, _) -> name
  | Ptree.ENum lit -> 
    (match lit.width with
     | Some w -> Printf.sprintf "%d'%s%s" w 
         (match lit.base with Ptree.BinBase -> "b" | Ptree.DecBase -> "d" | Ptree.HexBase -> "h")
         lit.digits
     | None -> lit.digits)
  | Ptree.EUnop (op, e, _) ->
    let op_str = match op with Ptree.UNot -> "!" | Ptree.UBitNot -> "~" in
    Printf.sprintf "%s(%s)" op_str (string_of_expr e)
  | Ptree.EBinop (op, e1, e2, _) ->
    let op_str = match op with
      | Ptree.BAdd -> "+" | Ptree.BSub -> "-" | Ptree.BMul -> "*" 
      | Ptree.BDiv -> "/" | Ptree.BMod -> "%"
      | Ptree.BShl -> "<<" | Ptree.BShr -> ">>"
      | Ptree.BLt -> "<" | Ptree.BLe -> "<=" | Ptree.BGt -> ">" | Ptree.BGe -> ">="
      | Ptree.BEq -> "==" | Ptree.BNe -> "!="
      | Ptree.BAnd -> "&" | Ptree.BOr -> "|" | Ptree.BXor -> "^"
      | Ptree.BLAnd -> "&&" | Ptree.BLOr -> "||"
    in
    Printf.sprintf "(%s %s %s)" (string_of_expr e1) op_str (string_of_expr e2)
  | Ptree.ETernary (c, t, e, _) ->
    Printf.sprintf "(%s ? %s : %s)" (string_of_expr c) (string_of_expr t) (string_of_expr e)
  | Ptree.EConcat (es, _) ->
    Printf.sprintf "{%s}" (String.concat ", " (List.map string_of_expr es))
  | Ptree.EIndex (e, i, _) ->
    Printf.sprintf "%s[%s]" (string_of_expr e) (string_of_expr i)
  | Ptree.ESlice (e, m, l, _) ->
    Printf.sprintf "%s[%s:%s]" (string_of_expr e) (string_of_expr m) (string_of_expr l)
  | Ptree.EParen (e, _) ->
    Printf.sprintf "(%s)" (string_of_expr e)

let string_of_lvalue = function
  | Ptree.LVId (name, _) -> name
  | Ptree.LVIndex (name, i, _) -> Printf.sprintf "%s[%s]" name (string_of_expr i)
  | Ptree.LVSlice (name, m, l, _) -> Printf.sprintf "%s[%s:%s]" name (string_of_expr m) (string_of_expr l)

let string_of_range (msb, lsb) =
  Printf.sprintf "[%s:%s]" (string_of_expr msb) (string_of_expr lsb)

let print_module m =
  Printf.printf "Module: %s\n" m.Ptree.mod_name;
  Printf.printf "\nPorts (%d):\n" (List.length m.Ptree.mod_ports);
  List.iter (fun p ->
    let dir = match p.Ptree.port_dir with Ptree.DirInput -> "input" | Ptree.DirOutput -> "output" in
    let range = match p.Ptree.port_range with Some r -> string_of_range r ^ " " | None -> "" in
    let wire = if p.Ptree.port_wire_explicit then "wire " else "" in
    Printf.printf "  %s %s%s%s\n" dir wire range p.Ptree.port_name
  ) m.Ptree.mod_ports;
  
  Printf.printf "\nDeclarations (%d):\n" (List.length m.Ptree.mod_decls);
  List.iter (fun d ->
    let kind = match d.Ptree.var_kind with Ptree.VarWire -> "wire" | Ptree.VarReg -> "reg" in
    let range = match d.Ptree.var_range with Some r -> string_of_range r ^ " " | None -> "" in
    Printf.printf "  %s %s%s\n" kind range d.Ptree.var_name
  ) m.Ptree.mod_decls;
  
  Printf.printf "\nItems (%d):\n" (List.length m.Ptree.mod_items);
  List.iter (fun item ->
    match item with
    | Ptree.ItemAssign (lv, e, _) ->
      Printf.printf "  assign %s = %s;\n" (string_of_lvalue lv) (string_of_expr e)
    | Ptree.ItemAlwaysComb (lv, e, _) ->
      Printf.printf "  always @* %s = %s;\n" (string_of_lvalue lv) (string_of_expr e)
    | Ptree.ItemAlwaysFF (clk, lv, e, _) ->
      Printf.printf "  always @(posedge %s) %s <= %s;\n" clk (string_of_lvalue lv) (string_of_expr e)
  ) m.Ptree.mod_items

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.eprintf "Usage: %s <file.v>\n" Sys.argv.(0);
    exit 1
  end;
  let filename = Sys.argv.(1) in
  try
    let m = Parse.parse_file filename in
    print_module m;
    Printf.printf "\nParsing successful!\n"
  with
  | Ptree.Parse_error (msg, loc) ->
    Printf.eprintf "Parse error at %s: %s\n" (Ptree.string_of_loc loc) msg;
    exit 1
  | Sys_error msg ->
    Printf.eprintf "Error: %s\n" msg;
    exit 1
