(** Parse: Wrapper for lexer and parser.
    
    Provides parse_string and parse_file functions that return the parse tree.
*)

open Ptree

(** Initialize lexer position with filename *)
let init_lexbuf filename lexbuf =
  let open Lexing in
  lexbuf.lex_curr_p <- {
    pos_fname = filename;
    pos_lnum = 1;
    pos_bol = 0;
    pos_cnum = 0;
  };
  lexbuf

(** Parse from a string, with optional filename for error messages *)
let parse_string ?(filename="<string>") input =
  let lexbuf = Lexing.from_string input in
  let lexbuf = init_lexbuf filename lexbuf in
  try
    Parser.vmodule Lexer.token lexbuf
  with
  | Lexer.Lexer_error (msg, pos) ->
    let loc = mk_loc pos pos in
    raise (Parse_error (msg, loc))
  | Parser.Error ->
    let pos = lexbuf.Lexing.lex_curr_p in
    let loc = mk_loc pos pos in
    raise (Parse_error ("syntax error", loc))

(** Parse from a file *)
let parse_file filename =
  let ic = open_in filename in
  Fun.protect ~finally:(fun () -> close_in ic) (fun () ->
    let lexbuf = Lexing.from_channel ic in
    let lexbuf = init_lexbuf filename lexbuf in
    try
      Parser.vmodule Lexer.token lexbuf
    with
    | Lexer.Lexer_error (msg, pos) ->
      let loc = mk_loc pos pos in
      raise (Parse_error (msg, loc))
    | Parser.Error ->
      let pos = lexbuf.Lexing.lex_curr_p in
      let loc = mk_loc pos pos in
      raise (Parse_error ("syntax error", loc))
  )

(** Format a parse error for display *)
let format_error msg loc =
  Printf.sprintf "%s: %s" (string_of_loc loc) msg
