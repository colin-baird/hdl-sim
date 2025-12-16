{
(* Lexer for a small Verilog subset *)
open Parser

exception Lexer_error of string * Lexing.position

let error lexbuf msg =
  raise (Lexer_error (msg, lexbuf.Lexing.lex_curr_p))

(* Update position for newlines *)
let newline lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  lexbuf.Lexing.lex_curr_p <- { pos with
    Lexing.pos_lnum = pos.Lexing.pos_lnum + 1;
    Lexing.pos_bol = pos.Lexing.pos_cnum;
  }

(* Keywords table *)
let keywords = Hashtbl.create 32
let () = List.iter (fun (k, v) -> Hashtbl.add keywords k v) [
  ("module", MODULE);
  ("endmodule", ENDMODULE);
  ("input", INPUT);
  ("output", OUTPUT);
  ("wire", WIRE);
  ("reg", REG);
  ("assign", ASSIGN);
  ("always", ALWAYS);
  (* Rejected keywords - we'll detect them and give nice errors *)
  ("begin", BEGIN);
  ("end", END);
  ("posedge", POSEDGE);
  ("negedge", NEGEDGE);
  ("always_ff", ALWAYS_FF);
  ("always_comb", ALWAYS_COMB);
  ("inout", INOUT);
  ("signed", SIGNED);
  ("if", IF);
  ("else", ELSE);
  ("case", CASE);
  ("endcase", ENDCASE);
  ("for", FOR);
  ("while", WHILE);
  ("function", FUNCTION);
  ("endfunction", ENDFUNCTION);
  ("task", TASK);
  ("endtask", ENDTASK);
  ("generate", GENERATE);
  ("endgenerate", ENDGENERATE);
  ("parameter", PARAMETER);
]

let lookup_ident s =
  try Hashtbl.find keywords s
  with Not_found -> IDENT s
}

let whitespace = [' ' '\t' '\r']
let newline = '\n'
let digit = ['0'-'9']
let hex_digit = ['0'-'9' 'a'-'f' 'A'-'F']
let bin_digit = ['0' '1']
let alpha = ['a'-'z' 'A'-'Z' '_']
let alphanum = ['a'-'z' 'A'-'Z' '0'-'9' '_' '$']
let ident = alpha alphanum*

rule token = parse
  | whitespace+      { token lexbuf }
  | newline          { newline lexbuf; token lexbuf }
  
  (* Comments *)
  | "//" [^'\n']*    { token lexbuf }
  | "/*"             { block_comment lexbuf; token lexbuf }
  
  (* Sized literals with base *)
  | (digit+ as width) "'" (['b' 'B'] as _base) (bin_digit+ as digits)
    { SIZED_BIN (int_of_string width, digits) }
  | (digit+ as width) "'" (['d' 'D'] as _base) (digit+ as digits)
    { SIZED_DEC (int_of_string width, digits) }
  | (digit+ as width) "'" (['h' 'H'] as _base) (hex_digit+ as digits)
    { SIZED_HEX (int_of_string width, digits) }
  
  (* Reject x/z in literals *)
  | digit+ "'" ['b' 'B' 'd' 'D' 'h' 'H'] (['0'-'9' 'a'-'f' 'A'-'F' 'x' 'X' 'z' 'Z' '_']* as digits)
    { if String.contains digits 'x' || String.contains digits 'X' ||
         String.contains digits 'z' || String.contains digits 'Z'
      then error lexbuf "x and z digits are not supported"
      else error lexbuf ("invalid literal: " ^ Lexing.lexeme lexbuf) }
  
  (* Unsized decimal *)
  | digit+ as n      { DECIMAL n }
  
  (* Identifiers and keywords *)
  | ident as id      { lookup_ident id }
  
  (* Operators *)
  | "("              { LPAREN }
  | ")"              { RPAREN }
  | "["              { LBRACKET }
  | "]"              { RBRACKET }
  | "{"              { LBRACE }
  | "}"              { RBRACE }
  | ","              { COMMA }
  | ";"              { SEMI }
  | ":"              { COLON }
  | "@"              { AT }
  | "*"              { STAR }
  | "+"              { PLUS }
  | "-"              { MINUS }
  | "/"              { SLASH }
  | "%"              { PERCENT }
  | "!"              { BANG }
  | "~"              { TILDE }
  | "?"              { QUESTION }
  
  (* Multi-character operators *)
  | "<<"             { LSHIFT }
  | ">>"             { RSHIFT }
  | "<<<"            { ALSHIFT }  (* will be rejected in parser *)
  | ">>>"            { ARSHIFT }  (* will be rejected in parser *)
  | "<="             { LTEQ }
  | ">="             { GE }
  | "<"              { LT }
  | ">"              { GT }
  | "=="             { EQEQ }
  | "!="             { NE }
  | "&&"             { LAND }
  | "||"             { LOR }
  | "&"              { AMP }
  | "|"              { PIPE }
  | "^"              { CARET }
  | "="              { EQ }
  
  (* End of file *)
  | eof              { EOF }
  
  (* Error *)
  | _ as c           { error lexbuf (Printf.sprintf "unexpected character: %c" c) }

and block_comment = parse
  | "*/"             { () }
  | newline          { newline lexbuf; block_comment lexbuf }
  | eof              { error lexbuf "unterminated block comment" }
  | _                { block_comment lexbuf }
