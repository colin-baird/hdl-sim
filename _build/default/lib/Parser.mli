
(* The type of tokens. *)

type token = 
  | WIRE
  | WHILE
  | TILDE
  | TASK
  | STAR
  | SLASH
  | SIZED_HEX of (int * string)
  | SIZED_DEC of (int * string)
  | SIZED_BIN of (int * string)
  | SIGNED
  | SEMI
  | RSHIFT
  | RPAREN
  | REG
  | RBRACKET
  | RBRACE
  | QUESTION
  | POSEDGE
  | PLUS
  | PIPE
  | PERCENT
  | PARAMETER
  | OUTPUT
  | NEGEDGE
  | NE
  | MODULE
  | MINUS
  | LTEQ
  | LT
  | LSHIFT
  | LPAREN
  | LOR
  | LBRACKET
  | LBRACE
  | LAND
  | INPUT
  | INOUT
  | IF
  | IDENT of (string)
  | GT
  | GENERATE
  | GE
  | FUNCTION
  | FOR
  | EQEQ
  | EQ
  | EOF
  | ENDTASK
  | ENDMODULE
  | ENDGENERATE
  | ENDFUNCTION
  | ENDCASE
  | END
  | ELSE
  | DECIMAL of (string)
  | COMMA
  | COLON
  | CASE
  | CARET
  | BEGIN
  | BANG
  | AT
  | ASSIGN
  | ARSHIFT
  | AMP
  | ALWAYS_FF
  | ALWAYS_COMB
  | ALWAYS
  | ALSHIFT

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val vmodule: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ptree.vmodule)
