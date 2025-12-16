(* Lower driver: test the full pipeline from Verilog to AST *)

open Verilog_parser
open Verilog_elab
open Verilog_lower

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.eprintf "Usage: %s <file.v>\n" Sys.argv.(0);
    exit 1
  end;
  
  let filename = Sys.argv.(1) in
  
  (* Parse *)
  let m = Parse.parse_file filename in
  Printf.printf "Parsing successful.\n";
  
  (* Elaborate *)
  begin try
    let elab = Elaborate.elaborate m in
    Printf.printf "Elaboration successful.\n\n";
    
    (* Lower to AST *)
    begin try
      let ast = AstConv.lower elab in
      Printf.printf "Lowering successful.\n\n";
      Printf.printf "=== AST ===\n";
      print_string (AstConv.pp_exp 0 ast)
    with AstConv.Conv_error msg ->
      Printf.eprintf "Lowering error: %s\n" msg;
      exit 1
    end
  with Elab_ir.Elab_error (msg, loc) ->
    Printf.eprintf "Elaboration error at %s: %s\n" (Ptree.string_of_loc loc) msg;
    exit 1
  end
