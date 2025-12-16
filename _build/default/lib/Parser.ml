
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WIRE
    | WHILE
    | TILDE
    | TASK
    | STAR
    | SLASH
    | SIZED_HEX of (
# 17 "lib/Parser.mly"
       (int * string)
# 21 "lib/Parser.ml"
  )
    | SIZED_DEC of (
# 16 "lib/Parser.mly"
       (int * string)
# 26 "lib/Parser.ml"
  )
    | SIZED_BIN of (
# 15 "lib/Parser.mly"
       (int * string)
# 31 "lib/Parser.ml"
  )
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
    | IDENT of (
# 13 "lib/Parser.mly"
       (string)
# 65 "lib/Parser.ml"
  )
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
    | DECIMAL of (
# 14 "lib/Parser.mly"
       (string)
# 85 "lib/Parser.ml"
  )
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
  
end

include MenhirBasics

# 1 "lib/Parser.mly"
  
(* Parser for a small Verilog subset *)
open Ptree

let mk_loc startpos endpos = { start_pos = startpos; end_pos = endpos }

let parse_error_at startpos endpos msg =
  let loc = mk_loc startpos endpos in
  raise (Parse_error (msg, loc))

# 117 "lib/Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState003 : ('s _menhir_cell0_MODULE _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_vmodule) _menhir_state
    (** State 003.
        Stack shape : MODULE IDENT LPAREN.
        Start symbol: vmodule. *)

  | MenhirState005 : (('s _menhir_cell0_MODULE _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_vmodule) _menhir_cell1_RPAREN _menhir_cell0_SEMI, _menhir_box_vmodule) _menhir_state
    (** State 005.
        Stack shape : MODULE IDENT LPAREN RPAREN SEMI.
        Start symbol: vmodule. *)

  | MenhirState006 : (('s, _menhir_box_vmodule) _menhir_cell1_WIRE, _menhir_box_vmodule) _menhir_state
    (** State 006.
        Stack shape : WIRE.
        Start symbol: vmodule. *)

  | MenhirState007 : (('s, _menhir_box_vmodule) _menhir_cell1_LBRACKET, _menhir_box_vmodule) _menhir_state
    (** State 007.
        Stack shape : LBRACKET.
        Start symbol: vmodule. *)

  | MenhirState008 : (('s, _menhir_box_vmodule) _menhir_cell1_TILDE, _menhir_box_vmodule) _menhir_state
    (** State 008.
        Stack shape : TILDE.
        Start symbol: vmodule. *)

  | MenhirState012 : (('s, _menhir_box_vmodule) _menhir_cell1_PIPE, _menhir_box_vmodule) _menhir_state
    (** State 012.
        Stack shape : PIPE.
        Start symbol: vmodule. *)

  | MenhirState013 : (('s, _menhir_box_vmodule) _menhir_cell1_LPAREN, _menhir_box_vmodule) _menhir_state
    (** State 013.
        Stack shape : LPAREN.
        Start symbol: vmodule. *)

  | MenhirState014 : (('s, _menhir_box_vmodule) _menhir_cell1_LBRACE, _menhir_box_vmodule) _menhir_state
    (** State 014.
        Stack shape : LBRACE.
        Start symbol: vmodule. *)

  | MenhirState017 : (('s, _menhir_box_vmodule) _menhir_cell1_CARET, _menhir_box_vmodule) _menhir_state
    (** State 017.
        Stack shape : CARET.
        Start symbol: vmodule. *)

  | MenhirState018 : (('s, _menhir_box_vmodule) _menhir_cell1_BANG, _menhir_box_vmodule) _menhir_state
    (** State 018.
        Stack shape : BANG.
        Start symbol: vmodule. *)

  | MenhirState019 : (('s, _menhir_box_vmodule) _menhir_cell1_AMP, _menhir_box_vmodule) _menhir_state
    (** State 019.
        Stack shape : AMP.
        Start symbol: vmodule. *)

  | MenhirState022 : (('s, _menhir_box_vmodule) _menhir_cell1_primary_expr, _menhir_box_vmodule) _menhir_state
    (** State 022.
        Stack shape : primary_expr.
        Start symbol: vmodule. *)

  | MenhirState026 : (('s, _menhir_box_vmodule) _menhir_cell1_shift_expr, _menhir_box_vmodule) _menhir_state
    (** State 026.
        Stack shape : shift_expr.
        Start symbol: vmodule. *)

  | MenhirState029 : (('s, _menhir_box_vmodule) _menhir_cell1_mul_expr, _menhir_box_vmodule) _menhir_state
    (** State 029.
        Stack shape : mul_expr.
        Start symbol: vmodule. *)

  | MenhirState031 : (('s, _menhir_box_vmodule) _menhir_cell1_mul_expr, _menhir_box_vmodule) _menhir_state
    (** State 031.
        Stack shape : mul_expr.
        Start symbol: vmodule. *)

  | MenhirState033 : (('s, _menhir_box_vmodule) _menhir_cell1_mul_expr, _menhir_box_vmodule) _menhir_state
    (** State 033.
        Stack shape : mul_expr.
        Start symbol: vmodule. *)

  | MenhirState036 : (('s, _menhir_box_vmodule) _menhir_cell1_add_expr, _menhir_box_vmodule) _menhir_state
    (** State 036.
        Stack shape : add_expr.
        Start symbol: vmodule. *)

  | MenhirState038 : (('s, _menhir_box_vmodule) _menhir_cell1_add_expr, _menhir_box_vmodule) _menhir_state
    (** State 038.
        Stack shape : add_expr.
        Start symbol: vmodule. *)

  | MenhirState040 : (('s, _menhir_box_vmodule) _menhir_cell1_shift_expr, _menhir_box_vmodule) _menhir_state
    (** State 040.
        Stack shape : shift_expr.
        Start symbol: vmodule. *)

  | MenhirState042 : (('s, _menhir_box_vmodule) _menhir_cell1_shift_expr, _menhir_box_vmodule) _menhir_state
    (** State 042.
        Stack shape : shift_expr.
        Start symbol: vmodule. *)

  | MenhirState044 : (('s, _menhir_box_vmodule) _menhir_cell1_shift_expr, _menhir_box_vmodule) _menhir_state
    (** State 044.
        Stack shape : shift_expr.
        Start symbol: vmodule. *)

  | MenhirState047 : (('s, _menhir_box_vmodule) _menhir_cell1_rel_expr, _menhir_box_vmodule) _menhir_state
    (** State 047.
        Stack shape : rel_expr.
        Start symbol: vmodule. *)

  | MenhirState050 : (('s, _menhir_box_vmodule) _menhir_cell1_rel_expr, _menhir_box_vmodule) _menhir_state
    (** State 050.
        Stack shape : rel_expr.
        Start symbol: vmodule. *)

  | MenhirState052 : (('s, _menhir_box_vmodule) _menhir_cell1_rel_expr, _menhir_box_vmodule) _menhir_state
    (** State 052.
        Stack shape : rel_expr.
        Start symbol: vmodule. *)

  | MenhirState054 : (('s, _menhir_box_vmodule) _menhir_cell1_rel_expr, _menhir_box_vmodule) _menhir_state
    (** State 054.
        Stack shape : rel_expr.
        Start symbol: vmodule. *)

  | MenhirState057 : (('s, _menhir_box_vmodule) _menhir_cell1_lor_expr, _menhir_box_vmodule) _menhir_state
    (** State 057.
        Stack shape : lor_expr.
        Start symbol: vmodule. *)

  | MenhirState059 : ((('s, _menhir_box_vmodule) _menhir_cell1_lor_expr, _menhir_box_vmodule) _menhir_cell1_ternary_expr, _menhir_box_vmodule) _menhir_state
    (** State 059.
        Stack shape : lor_expr ternary_expr.
        Start symbol: vmodule. *)

  | MenhirState062 : (('s, _menhir_box_vmodule) _menhir_cell1_land_expr, _menhir_box_vmodule) _menhir_state
    (** State 062.
        Stack shape : land_expr.
        Start symbol: vmodule. *)

  | MenhirState064 : (('s, _menhir_box_vmodule) _menhir_cell1_eq_expr, _menhir_box_vmodule) _menhir_state
    (** State 064.
        Stack shape : eq_expr.
        Start symbol: vmodule. *)

  | MenhirState066 : (('s, _menhir_box_vmodule) _menhir_cell1_eq_expr, _menhir_box_vmodule) _menhir_state
    (** State 066.
        Stack shape : eq_expr.
        Start symbol: vmodule. *)

  | MenhirState069 : (('s, _menhir_box_vmodule) _menhir_cell1_bitxor_expr _menhir_cell0_CARET, _menhir_box_vmodule) _menhir_state
    (** State 069.
        Stack shape : bitxor_expr CARET.
        Start symbol: vmodule. *)

  | MenhirState071 : (('s, _menhir_box_vmodule) _menhir_cell1_bitand_expr _menhir_cell0_AMP, _menhir_box_vmodule) _menhir_state
    (** State 071.
        Stack shape : bitand_expr AMP.
        Start symbol: vmodule. *)

  | MenhirState074 : (('s, _menhir_box_vmodule) _menhir_cell1_bitor_expr _menhir_cell0_PIPE, _menhir_box_vmodule) _menhir_state
    (** State 074.
        Stack shape : bitor_expr PIPE.
        Start symbol: vmodule. *)

  | MenhirState078 : (('s, _menhir_box_vmodule) _menhir_cell1_lor_expr, _menhir_box_vmodule) _menhir_state
    (** State 078.
        Stack shape : lor_expr.
        Start symbol: vmodule. *)

  | MenhirState082 : ((('s, _menhir_box_vmodule) _menhir_cell1_primary_expr, _menhir_box_vmodule) _menhir_cell1_expr, _menhir_box_vmodule) _menhir_state
    (** State 082.
        Stack shape : primary_expr expr.
        Start symbol: vmodule. *)

  | MenhirState090 : (('s, _menhir_box_vmodule) _menhir_cell1_expr _menhir_cell0_COMMA, _menhir_box_vmodule) _menhir_state
    (** State 090.
        Stack shape : expr COMMA.
        Start symbol: vmodule. *)

  | MenhirState097 : ((('s, _menhir_box_vmodule) _menhir_cell1_LBRACKET, _menhir_box_vmodule) _menhir_cell1_expr, _menhir_box_vmodule) _menhir_state
    (** State 097.
        Stack shape : LBRACKET expr.
        Start symbol: vmodule. *)

  | MenhirState101 : ((('s, _menhir_box_vmodule) _menhir_cell1_WIRE, _menhir_box_vmodule) _menhir_cell1_option_range_, _menhir_box_vmodule) _menhir_state
    (** State 101.
        Stack shape : WIRE option(range).
        Start symbol: vmodule. *)

  | MenhirState103 : (('s, _menhir_box_vmodule) _menhir_cell1_IDENT _menhir_cell0_COMMA, _menhir_box_vmodule) _menhir_state
    (** State 103.
        Stack shape : IDENT COMMA.
        Start symbol: vmodule. *)

  | MenhirState109 : (('s, _menhir_box_vmodule) _menhir_cell1_REG, _menhir_box_vmodule) _menhir_state
    (** State 109.
        Stack shape : REG.
        Start symbol: vmodule. *)

  | MenhirState110 : ((('s, _menhir_box_vmodule) _menhir_cell1_REG, _menhir_box_vmodule) _menhir_cell1_option_range_, _menhir_box_vmodule) _menhir_state
    (** State 110.
        Stack shape : REG option(range).
        Start symbol: vmodule. *)

  | MenhirState121 : (('s, _menhir_box_vmodule) _menhir_cell1_ASSIGN, _menhir_box_vmodule) _menhir_state
    (** State 121.
        Stack shape : ASSIGN.
        Start symbol: vmodule. *)

  | MenhirState123 : (('s, _menhir_box_vmodule) _menhir_cell1_IDENT, _menhir_box_vmodule) _menhir_state
    (** State 123.
        Stack shape : IDENT.
        Start symbol: vmodule. *)

  | MenhirState126 : ((('s, _menhir_box_vmodule) _menhir_cell1_IDENT, _menhir_box_vmodule) _menhir_cell1_expr, _menhir_box_vmodule) _menhir_state
    (** State 126.
        Stack shape : IDENT expr.
        Start symbol: vmodule. *)

  | MenhirState130 : ((('s, _menhir_box_vmodule) _menhir_cell1_ASSIGN, _menhir_box_vmodule) _menhir_cell1_lvalue, _menhir_box_vmodule) _menhir_state
    (** State 130.
        Stack shape : ASSIGN lvalue.
        Start symbol: vmodule. *)

  | MenhirState137 : (('s, _menhir_box_vmodule) _menhir_cell1_ALWAYS, _menhir_box_vmodule) _menhir_state
    (** State 137.
        Stack shape : ALWAYS.
        Start symbol: vmodule. *)

  | MenhirState139 : ((('s, _menhir_box_vmodule) _menhir_cell1_ALWAYS, _menhir_box_vmodule) _menhir_cell1_lvalue, _menhir_box_vmodule) _menhir_state
    (** State 139.
        Stack shape : ALWAYS lvalue.
        Start symbol: vmodule. *)

  | MenhirState145 : (('s, _menhir_box_vmodule) _menhir_cell1_ALWAYS _menhir_cell0_LPAREN _menhir_cell0_IDENT _menhir_cell0_RPAREN, _menhir_box_vmodule) _menhir_state
    (** State 145.
        Stack shape : ALWAYS LPAREN IDENT RPAREN.
        Start symbol: vmodule. *)

  | MenhirState147 : ((('s, _menhir_box_vmodule) _menhir_cell1_ALWAYS _menhir_cell0_LPAREN _menhir_cell0_IDENT _menhir_cell0_RPAREN, _menhir_box_vmodule) _menhir_cell1_lvalue, _menhir_box_vmodule) _menhir_state
    (** State 147.
        Stack shape : ALWAYS LPAREN IDENT RPAREN lvalue.
        Start symbol: vmodule. *)

  | MenhirState154 : (('s, _menhir_box_vmodule) _menhir_cell1_module_item, _menhir_box_vmodule) _menhir_state
    (** State 154.
        Stack shape : module_item.
        Start symbol: vmodule. *)

  | MenhirState161 : (('s, _menhir_box_vmodule) _menhir_cell1_OUTPUT, _menhir_box_vmodule) _menhir_state
    (** State 161.
        Stack shape : OUTPUT.
        Start symbol: vmodule. *)

  | MenhirState162 : ((('s, _menhir_box_vmodule) _menhir_cell1_OUTPUT, _menhir_box_vmodule) _menhir_cell1_WIRE, _menhir_box_vmodule) _menhir_state
    (** State 162.
        Stack shape : OUTPUT WIRE.
        Start symbol: vmodule. *)

  | MenhirState169 : (('s, _menhir_box_vmodule) _menhir_cell1_INPUT, _menhir_box_vmodule) _menhir_state
    (** State 169.
        Stack shape : INPUT.
        Start symbol: vmodule. *)

  | MenhirState170 : ((('s, _menhir_box_vmodule) _menhir_cell1_INPUT, _menhir_box_vmodule) _menhir_cell1_WIRE, _menhir_box_vmodule) _menhir_state
    (** State 170.
        Stack shape : INPUT WIRE.
        Start symbol: vmodule. *)

  | MenhirState179 : (('s _menhir_cell0_MODULE _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_vmodule) _menhir_cell1_port_list _menhir_cell0_RPAREN _menhir_cell0_SEMI, _menhir_box_vmodule) _menhir_state
    (** State 179.
        Stack shape : MODULE IDENT LPAREN port_list RPAREN SEMI.
        Start symbol: vmodule. *)

  | MenhirState184 : (('s, _menhir_box_vmodule) _menhir_cell1_port_decl _menhir_cell0_COMMA, _menhir_box_vmodule) _menhir_state
    (** State 184.
        Stack shape : port_decl COMMA.
        Start symbol: vmodule. *)


and ('s, 'r) _menhir_cell1_add_expr = 
  | MenhirCell1_add_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_bitand_expr = 
  | MenhirCell1_bitand_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_bitor_expr = 
  | MenhirCell1_bitor_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_bitxor_expr = 
  | MenhirCell1_bitxor_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_eq_expr = 
  | MenhirCell1_eq_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr)

and ('s, 'r) _menhir_cell1_land_expr = 
  | MenhirCell1_land_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_lor_expr = 
  | MenhirCell1_lor_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_lvalue = 
  | MenhirCell1_lvalue of 's * ('s, 'r) _menhir_state * (Ptree.lvalue)

and ('s, 'r) _menhir_cell1_module_item = 
  | MenhirCell1_module_item of 's * ('s, 'r) _menhir_state * ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ])

and ('s, 'r) _menhir_cell1_mul_expr = 
  | MenhirCell1_mul_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_option_range_ = 
  | MenhirCell1_option_range_ of 's * ('s, 'r) _menhir_state * (Ptree.range option)

and ('s, 'r) _menhir_cell1_port_decl = 
  | MenhirCell1_port_decl of 's * ('s, 'r) _menhir_state * (Ptree.port_decl)

and ('s, 'r) _menhir_cell1_port_list = 
  | MenhirCell1_port_list of 's * ('s, 'r) _menhir_state * (Ptree.port_decl list)

and ('s, 'r) _menhir_cell1_primary_expr = 
  | MenhirCell1_primary_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_rel_expr = 
  | MenhirCell1_rel_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_shift_expr = 
  | MenhirCell1_shift_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_ternary_expr = 
  | MenhirCell1_ternary_expr of 's * ('s, 'r) _menhir_state * (Ptree.expr) * Lexing.position

and ('s, 'r) _menhir_cell1_ALWAYS = 
  | MenhirCell1_ALWAYS of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_AMP = 
  | MenhirCell1_AMP of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_AMP = 
  | MenhirCell0_AMP of 's * Lexing.position

and ('s, 'r) _menhir_cell1_ASSIGN = 
  | MenhirCell1_ASSIGN of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_BANG = 
  | MenhirCell1_BANG of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_CARET = 
  | MenhirCell1_CARET of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_CARET = 
  | MenhirCell0_CARET of 's * Lexing.position

and 's _menhir_cell0_COMMA = 
  | MenhirCell0_COMMA of 's * Lexing.position

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 13 "lib/Parser.mly"
       (string)
# 483 "lib/Parser.ml"
) * Lexing.position * Lexing.position

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 13 "lib/Parser.mly"
       (string)
# 490 "lib/Parser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_INPUT = 
  | MenhirCell1_INPUT of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_LBRACE = 
  | MenhirCell1_LBRACE of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_LBRACKET = 
  | MenhirCell1_LBRACKET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_LPAREN = 
  | MenhirCell0_LPAREN of 's * Lexing.position

and 's _menhir_cell0_MODULE = 
  | MenhirCell0_MODULE of 's * Lexing.position

and ('s, 'r) _menhir_cell1_OUTPUT = 
  | MenhirCell1_OUTPUT of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_PIPE = 
  | MenhirCell1_PIPE of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_PIPE = 
  | MenhirCell0_PIPE of 's * Lexing.position

and ('s, 'r) _menhir_cell1_REG = 
  | MenhirCell1_REG of 's * ('s, 'r) _menhir_state * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_RPAREN = 
  | MenhirCell1_RPAREN of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_RPAREN = 
  | MenhirCell0_RPAREN of 's * Lexing.position

and 's _menhir_cell0_SEMI = 
  | MenhirCell0_SEMI of 's * Lexing.position

and ('s, 'r) _menhir_cell1_TILDE = 
  | MenhirCell1_TILDE of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_WIRE = 
  | MenhirCell1_WIRE of 's * ('s, 'r) _menhir_state * Lexing.position

and _menhir_box_vmodule = 
  | MenhirBox_vmodule of (Ptree.vmodule) [@@unboxed]

let _menhir_action_01 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 308 "lib/Parser.mly"
    ( EBinop (BAdd, l, r, mk_loc _startpos _endpos) )
# 548 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_02 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 310 "lib/Parser.mly"
    ( EBinop (BSub, l, r, mk_loc _startpos _endpos) )
# 558 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_03 =
  fun e ->
    (
# 311 "lib/Parser.mly"
               ( e )
# 566 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_04 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 270 "lib/Parser.mly"
    ( EBinop (BAnd, l, r, mk_loc _startpos _endpos) )
# 576 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_05 =
  fun e ->
    (
# 271 "lib/Parser.mly"
              ( e )
# 584 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_06 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 258 "lib/Parser.mly"
    ( EBinop (BOr, l, r, mk_loc _startpos _endpos) )
# 594 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_07 =
  fun e ->
    (
# 259 "lib/Parser.mly"
                  ( e )
# 602 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_08 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 264 "lib/Parser.mly"
    ( EBinop (BXor, l, r, mk_loc _startpos _endpos) )
# 612 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_09 =
  fun e ->
    (
# 265 "lib/Parser.mly"
                  ( e )
# 620 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_10 =
  fun name ->
    (
# 205 "lib/Parser.mly"
               ( [name] )
# 628 "lib/Parser.ml"
     : (string list))

let _menhir_action_11 =
  fun name rest ->
    (
# 206 "lib/Parser.mly"
                                          ( name :: rest )
# 636 "lib/Parser.ml"
     : (string list))

let _menhir_action_12 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 276 "lib/Parser.mly"
    ( EBinop (BEq, l, r, mk_loc _startpos _endpos) )
# 646 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_13 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 278 "lib/Parser.mly"
    ( EBinop (BNe, l, r, mk_loc _startpos _endpos) )
# 656 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_14 =
  fun e ->
    (
# 279 "lib/Parser.mly"
               ( e )
# 664 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_15 =
  fun e ->
    (
# 235 "lib/Parser.mly"
                   ( e )
# 672 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_16 =
  fun e ->
    (
# 371 "lib/Parser.mly"
           ( [e] )
# 680 "lib/Parser.ml"
     : (Ptree.expr list))

let _menhir_action_17 =
  fun e rest ->
    (
# 372 "lib/Parser.mly"
                                ( e :: rest )
# 688 "lib/Parser.ml"
     : (Ptree.expr list))

let _menhir_action_18 =
  fun _endpos__5_ _startpos__1_ e lv ->
    let _endpos = _endpos__5_ in
    let _startpos = _startpos__1_ in
    (
# 211 "lib/Parser.mly"
    ( ItemAssign (lv, e, mk_loc _startpos _endpos) )
# 698 "lib/Parser.ml"
     : (Ptree.item))

let _menhir_action_19 =
  fun _endpos__7_ _startpos__1_ e lv ->
    let _endpos = _endpos__7_ in
    let _startpos = _startpos__1_ in
    (
# 213 "lib/Parser.mly"
    ( ItemAlwaysComb (lv, e, mk_loc _startpos _endpos) )
# 708 "lib/Parser.ml"
     : (Ptree.item))

let _menhir_action_20 =
  fun _endpos__10_ _startpos__1_ clk e lv ->
    let _endpos = _endpos__10_ in
    let _startpos = _startpos__1_ in
    (
# 215 "lib/Parser.mly"
    ( ItemAlwaysFF (clk, lv, e, mk_loc _startpos _endpos) )
# 718 "lib/Parser.ml"
     : (Ptree.item))

let _menhir_action_21 =
  fun _endpos__6_ _startpos__1_ ->
    let _endpos = _endpos__6_ in
    let _startpos = _startpos__1_ in
    (
# 218 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "only single posedge signals are supported" )
# 728 "lib/Parser.ml"
     : (Ptree.item))

let _menhir_action_22 =
  fun _endpos__4_ _startpos__1_ ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 220 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "negedge is not supported" )
# 738 "lib/Parser.ml"
     : (Ptree.item))

let _menhir_action_23 =
  fun _endpos__4_ _startpos__1_ ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 222 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "explicit sensitivity lists without posedge are not supported; use always @*" )
# 748 "lib/Parser.ml"
     : (Ptree.item))

let _menhir_action_24 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 252 "lib/Parser.mly"
    ( EBinop (BLAnd, l, r, mk_loc _startpos _endpos) )
# 758 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_25 =
  fun e ->
    (
# 253 "lib/Parser.mly"
                 ( e )
# 766 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_26 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 774 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ] list))

let _menhir_action_27 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 782 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ] list))

let _menhir_action_28 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 246 "lib/Parser.mly"
    ( EBinop (BLOr, l, r, mk_loc _startpos _endpos) )
# 792 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_29 =
  fun e ->
    (
# 247 "lib/Parser.mly"
                ( e )
# 800 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_30 =
  fun _endpos_name_ _startpos_name_ name ->
    let _endpos = _endpos_name_ in
    let _startpos = _startpos_name_ in
    (
# 227 "lib/Parser.mly"
    ( LVId (name, mk_loc _startpos _endpos) )
# 810 "lib/Parser.ml"
     : (Ptree.lvalue))

let _menhir_action_31 =
  fun _endpos__4_ _startpos_name_ idx name ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos_name_ in
    (
# 229 "lib/Parser.mly"
    ( LVIndex (name, idx, mk_loc _startpos _endpos) )
# 820 "lib/Parser.ml"
     : (Ptree.lvalue))

let _menhir_action_32 =
  fun _endpos__6_ _startpos_name_ lsb msb name ->
    let _endpos = _endpos__6_ in
    let _startpos = _startpos_name_ in
    (
# 231 "lib/Parser.mly"
    ( LVSlice (name, msb, lsb, mk_loc _startpos _endpos) )
# 830 "lib/Parser.ml"
     : (Ptree.lvalue))

let _menhir_action_33 =
  fun items ->
    (
# 144 "lib/Parser.mly"
    (
      let decls = List.concat_map (function
        | `Decls ds -> ds
        | `Item _ -> []) items in
      let stmts = List.filter_map (function
        | `Item i -> Some i
        | `Decls _ -> None) items in
      (decls, stmts)
    )
# 846 "lib/Parser.ml"
     : (Ptree.var_decl list * Ptree.item list))

let _menhir_action_34 =
  fun d ->
    (
# 156 "lib/Parser.mly"
               ( `Decls d )
# 854 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_35 =
  fun i ->
    (
# 157 "lib/Parser.mly"
           ( `Item i )
# 862 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_36 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 160 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "begin/end blocks are not supported" )
# 872 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_37 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 162 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "begin/end blocks are not supported" )
# 882 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_38 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 164 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "if statements are not supported" )
# 892 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_39 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 166 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "case statements are not supported" )
# 902 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_40 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 168 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "for loops are not supported" )
# 912 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_41 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 170 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "while loops are not supported" )
# 922 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_42 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 172 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "functions are not supported" )
# 932 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_43 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 174 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "tasks are not supported" )
# 942 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_44 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 176 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "generate blocks are not supported" )
# 952 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_45 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 178 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "parameters are not supported" )
# 962 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_46 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 180 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "always_ff is not supported" )
# 972 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_47 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 182 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "always_comb keyword is not supported; use always @*" )
# 982 "lib/Parser.ml"
     : ([ `Decls of Ptree.var_decl list | `Item of Ptree.item ]))

let _menhir_action_48 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 316 "lib/Parser.mly"
    ( EBinop (BMul, l, r, mk_loc _startpos _endpos) )
# 992 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_49 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 318 "lib/Parser.mly"
    ( EBinop (BDiv, l, r, mk_loc _startpos _endpos) )
# 1002 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_50 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 320 "lib/Parser.mly"
    ( EBinop (BMod, l, r, mk_loc _startpos _endpos) )
# 1012 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_51 =
  fun e ->
    (
# 321 "lib/Parser.mly"
                 ( e )
# 1020 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_52 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1028 "lib/Parser.ml"
     : (Ptree.range option))

let _menhir_action_53 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 1036 "lib/Parser.ml"
     : (Ptree.range option))

let _menhir_action_54 =
  fun _endpos_name_ _startpos__1_ name r ->
    let _endpos = _endpos_name_ in
    let _startpos = _startpos__1_ in
    (
# 99 "lib/Parser.mly"
    ( { port_dir = DirInput;
        port_name = name;
        port_range = r;
        port_wire_explicit = true;
        port_loc = mk_loc _startpos _endpos } )
# 1050 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_55 =
  fun _endpos_name_ _startpos__1_ name r ->
    let _endpos = _endpos_name_ in
    let _startpos = _startpos__1_ in
    (
# 106 "lib/Parser.mly"
    ( { port_dir = DirInput;
        port_name = name;
        port_range = r;
        port_wire_explicit = false;
        port_loc = mk_loc _startpos _endpos } )
# 1064 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_56 =
  fun _endpos_name_ _startpos__1_ name r ->
    let _endpos = _endpos_name_ in
    let _startpos = _startpos__1_ in
    (
# 113 "lib/Parser.mly"
    ( { port_dir = DirOutput;
        port_name = name;
        port_range = r;
        port_wire_explicit = true;
        port_loc = mk_loc _startpos _endpos } )
# 1078 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_57 =
  fun _endpos_name_ _startpos__1_ name r ->
    let _endpos = _endpos_name_ in
    let _startpos = _startpos__1_ in
    (
# 120 "lib/Parser.mly"
    ( { port_dir = DirOutput;
        port_name = name;
        port_range = r;
        port_wire_explicit = false;
        port_loc = mk_loc _startpos _endpos } )
# 1092 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_58 =
  fun _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 127 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "output reg is not allowed; outputs must be wires" )
# 1102 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_59 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 130 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "inout ports are not supported" )
# 1112 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_60 =
  fun _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 133 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "signed is not supported" )
# 1122 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_61 =
  fun _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 135 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "signed is not supported" )
# 1132 "lib/Parser.ml"
     : (Ptree.port_decl))

let _menhir_action_62 =
  fun p ->
    (
# 92 "lib/Parser.mly"
                ( [p] )
# 1140 "lib/Parser.ml"
     : (Ptree.port_decl list))

let _menhir_action_63 =
  fun p rest ->
    (
# 93 "lib/Parser.mly"
                                     ( p :: rest )
# 1148 "lib/Parser.ml"
     : (Ptree.port_decl list))

let _menhir_action_64 =
  fun _endpos__4_ _startpos_e_ e idx ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos_e_ in
    (
# 341 "lib/Parser.mly"
    (
      (* Check if there's a colon for slice *)
      EIndex (e, idx, mk_loc _startpos _endpos)
    )
# 1161 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_65 =
  fun _endpos__6_ _startpos_e_ e lsb msb ->
    let _endpos = _endpos__6_ in
    let _startpos = _startpos_e_ in
    (
# 346 "lib/Parser.mly"
    ( ESlice (e, msb, lsb, mk_loc _startpos _endpos) )
# 1171 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_66 =
  fun e ->
    (
# 347 "lib/Parser.mly"
                   ( e )
# 1179 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_67 =
  fun _endpos_name_ _startpos_name_ name ->
    let _endpos = _endpos_name_ in
    let _startpos = _startpos_name_ in
    (
# 352 "lib/Parser.mly"
    ( EId (name, mk_loc _startpos _endpos) )
# 1189 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_68 =
  fun _endpos_n_ _startpos_n_ n ->
    let _endpos = _endpos_n_ in
    let _startpos = _startpos_n_ in
    (
# 354 "lib/Parser.mly"
    ( ENum { width = None; base = DecBase; digits = n; lit_loc = mk_loc _startpos _endpos } )
# 1199 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_69 =
  fun _endpos_lit_ _startpos_lit_ lit ->
    let _endpos = _endpos_lit_ in
    let _startpos = _startpos_lit_ in
    (
# 356 "lib/Parser.mly"
    ( let (w, d) = lit in
      ENum { width = Some w; base = BinBase; digits = d; lit_loc = mk_loc _startpos _endpos } )
# 1210 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_70 =
  fun _endpos_lit_ _startpos_lit_ lit ->
    let _endpos = _endpos_lit_ in
    let _startpos = _startpos_lit_ in
    (
# 359 "lib/Parser.mly"
    ( let (w, d) = lit in
      ENum { width = Some w; base = DecBase; digits = d; lit_loc = mk_loc _startpos _endpos } )
# 1221 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_71 =
  fun _endpos_lit_ _startpos_lit_ lit ->
    let _endpos = _endpos_lit_ in
    let _startpos = _startpos_lit_ in
    (
# 362 "lib/Parser.mly"
    ( let (w, d) = lit in
      ENum { width = Some w; base = HexBase; digits = d; lit_loc = mk_loc _startpos _endpos } )
# 1232 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_72 =
  fun _endpos__3_ _startpos__1_ e ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 365 "lib/Parser.mly"
    ( EParen (e, mk_loc _startpos _endpos) )
# 1242 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_73 =
  fun _endpos__3_ _startpos__1_ exprs ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 367 "lib/Parser.mly"
    ( EConcat (exprs, mk_loc _startpos _endpos) )
# 1252 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_74 =
  fun lsb msb ->
    (
# 139 "lib/Parser.mly"
                                              ( (msb, lsb) )
# 1260 "lib/Parser.ml"
     : (Ptree.range))

let _menhir_action_75 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 284 "lib/Parser.mly"
    ( EBinop (BLt, l, r, mk_loc _startpos _endpos) )
# 1270 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_76 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 286 "lib/Parser.mly"
    ( EBinop (BLe, l, r, mk_loc _startpos _endpos) )
# 1280 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_77 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 288 "lib/Parser.mly"
    ( EBinop (BGt, l, r, mk_loc _startpos _endpos) )
# 1290 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_78 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 290 "lib/Parser.mly"
    ( EBinop (BGe, l, r, mk_loc _startpos _endpos) )
# 1300 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_79 =
  fun e ->
    (
# 291 "lib/Parser.mly"
                 ( e )
# 1308 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_80 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 296 "lib/Parser.mly"
    ( EBinop (BShl, l, r, mk_loc _startpos _endpos) )
# 1318 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_81 =
  fun _endpos_r_ _startpos_l_ l r ->
    let _endpos = _endpos_r_ in
    let _startpos = _startpos_l_ in
    (
# 298 "lib/Parser.mly"
    ( EBinop (BShr, l, r, mk_loc _startpos _endpos) )
# 1328 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_82 =
  fun _endpos__r_ _l _r _startpos__l_ ->
    let _endpos = _endpos__r_ in
    let _startpos = _startpos__l_ in
    (
# 300 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "arithmetic left shift <<< is not supported" )
# 1338 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_83 =
  fun _endpos__r_ _l _r _startpos__l_ ->
    let _endpos = _endpos__r_ in
    let _startpos = _startpos__l_ in
    (
# 302 "lib/Parser.mly"
    ( parse_error_at _startpos _endpos "arithmetic right shift >>> is not supported" )
# 1348 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_84 =
  fun e ->
    (
# 303 "lib/Parser.mly"
               ( e )
# 1356 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_85 =
  fun _endpos_else_e_ _startpos_cond_ cond else_e then_e ->
    let _endpos = _endpos_else_e_ in
    let _startpos = _startpos_cond_ in
    (
# 240 "lib/Parser.mly"
    ( ETernary (cond, then_e, else_e, mk_loc _startpos _endpos) )
# 1366 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_86 =
  fun e ->
    (
# 241 "lib/Parser.mly"
               ( e )
# 1374 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_87 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 326 "lib/Parser.mly"
    ( EUnop (UNot, e, mk_loc _startpos _endpos) )
# 1384 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_88 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 328 "lib/Parser.mly"
    ( EUnop (UBitNot, e, mk_loc _startpos _endpos) )
# 1394 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_89 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 331 "lib/Parser.mly"
    ( let _ = e in parse_error_at _startpos _endpos "reduction AND (&) is not supported as unary operator" )
# 1404 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_90 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 333 "lib/Parser.mly"
    ( let _ = e in parse_error_at _startpos _endpos "reduction OR (|) is not supported as unary operator" )
# 1414 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_91 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 335 "lib/Parser.mly"
    ( let _ = e in parse_error_at _startpos _endpos "reduction XOR (^) is not supported as unary operator" )
# 1424 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_92 =
  fun e ->
    (
# 336 "lib/Parser.mly"
                   ( e )
# 1432 "lib/Parser.ml"
     : (Ptree.expr))

let _menhir_action_93 =
  fun _endpos__4_ _startpos__1_ names r ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 187 "lib/Parser.mly"
    (
      List.map (fun name ->
        { var_kind = VarWire;
          var_name = name;
          var_range = r;
          var_loc = mk_loc _startpos _endpos }) names
    )
# 1448 "lib/Parser.ml"
     : (Ptree.var_decl list))

let _menhir_action_94 =
  fun _endpos__4_ _startpos__1_ names r ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 195 "lib/Parser.mly"
    (
      List.map (fun name ->
        { var_kind = VarReg;
          var_name = name;
          var_range = r;
          var_loc = mk_loc _startpos _endpos }) names
    )
# 1464 "lib/Parser.ml"
     : (Ptree.var_decl list))

let _menhir_action_95 =
  fun _endpos__9_ _startpos__1_ body name ports ->
    let _endpos = _endpos__9_ in
    let _startpos = _startpos__1_ in
    (
# 70 "lib/Parser.mly"
    (
      let (decls, items) = body in
      { mod_name = name;
        mod_ports = ports;
        mod_decls = decls;
        mod_items = items;
        mod_loc = mk_loc _startpos _endpos }
    )
# 1481 "lib/Parser.ml"
     : (Ptree.vmodule))

let _menhir_action_96 =
  fun _endpos__8_ _startpos__1_ body name ->
    let _endpos = _endpos__8_ in
    let _startpos = _startpos__1_ in
    (
# 81 "lib/Parser.mly"
    (
      let (decls, items) = body in
      { mod_name = name;
        mod_ports = [];
        mod_decls = decls;
        mod_items = items;
        mod_loc = mk_loc _startpos _endpos }
    )
# 1498 "lib/Parser.ml"
     : (Ptree.vmodule))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ALSHIFT ->
        "ALSHIFT"
    | ALWAYS ->
        "ALWAYS"
    | ALWAYS_COMB ->
        "ALWAYS_COMB"
    | ALWAYS_FF ->
        "ALWAYS_FF"
    | AMP ->
        "AMP"
    | ARSHIFT ->
        "ARSHIFT"
    | ASSIGN ->
        "ASSIGN"
    | AT ->
        "AT"
    | BANG ->
        "BANG"
    | BEGIN ->
        "BEGIN"
    | CARET ->
        "CARET"
    | CASE ->
        "CASE"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | DECIMAL _ ->
        "DECIMAL"
    | ELSE ->
        "ELSE"
    | END ->
        "END"
    | ENDCASE ->
        "ENDCASE"
    | ENDFUNCTION ->
        "ENDFUNCTION"
    | ENDGENERATE ->
        "ENDGENERATE"
    | ENDMODULE ->
        "ENDMODULE"
    | ENDTASK ->
        "ENDTASK"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | EQEQ ->
        "EQEQ"
    | FOR ->
        "FOR"
    | FUNCTION ->
        "FUNCTION"
    | GE ->
        "GE"
    | GENERATE ->
        "GENERATE"
    | GT ->
        "GT"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | INOUT ->
        "INOUT"
    | INPUT ->
        "INPUT"
    | LAND ->
        "LAND"
    | LBRACE ->
        "LBRACE"
    | LBRACKET ->
        "LBRACKET"
    | LOR ->
        "LOR"
    | LPAREN ->
        "LPAREN"
    | LSHIFT ->
        "LSHIFT"
    | LT ->
        "LT"
    | LTEQ ->
        "LTEQ"
    | MINUS ->
        "MINUS"
    | MODULE ->
        "MODULE"
    | NE ->
        "NE"
    | NEGEDGE ->
        "NEGEDGE"
    | OUTPUT ->
        "OUTPUT"
    | PARAMETER ->
        "PARAMETER"
    | PERCENT ->
        "PERCENT"
    | PIPE ->
        "PIPE"
    | PLUS ->
        "PLUS"
    | POSEDGE ->
        "POSEDGE"
    | QUESTION ->
        "QUESTION"
    | RBRACE ->
        "RBRACE"
    | RBRACKET ->
        "RBRACKET"
    | REG ->
        "REG"
    | RPAREN ->
        "RPAREN"
    | RSHIFT ->
        "RSHIFT"
    | SEMI ->
        "SEMI"
    | SIGNED ->
        "SIGNED"
    | SIZED_BIN _ ->
        "SIZED_BIN"
    | SIZED_DEC _ ->
        "SIZED_DEC"
    | SIZED_HEX _ ->
        "SIZED_HEX"
    | SLASH ->
        "SLASH"
    | STAR ->
        "STAR"
    | TASK ->
        "TASK"
    | TILDE ->
        "TILDE"
    | WHILE ->
        "WHILE"
    | WIRE ->
        "WIRE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_goto_vmodule : type  ttv_stack. ttv_stack -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _v ->
      MenhirBox_vmodule _v
  
  let _menhir_run_180 : type  ttv_stack. (ttv_stack _menhir_cell0_MODULE _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_vmodule) _menhir_cell1_port_list _menhir_cell0_RPAREN _menhir_cell0_SEMI -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let MenhirCell0_SEMI (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_port_list (_menhir_stack, _, ports) = _menhir_stack in
          let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name, _, _) = _menhir_stack in
          let MenhirCell0_MODULE (_menhir_stack, _startpos__1_) = _menhir_stack in
          let (_endpos__9_, body) = (_endpos, _v) in
          let _v = _menhir_action_95 _endpos__9_ _startpos__1_ body name ports in
          _menhir_goto_vmodule _menhir_stack _v
      | _ ->
          _eRR ()
  
  let _menhir_run_157 : type  ttv_stack. (ttv_stack _menhir_cell0_MODULE _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_vmodule) _menhir_cell1_RPAREN _menhir_cell0_SEMI -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let MenhirCell0_SEMI (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_RPAREN (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name, _, _) = _menhir_stack in
          let MenhirCell0_MODULE (_menhir_stack, _startpos__1_) = _menhir_stack in
          let (body, _endpos__8_) = (_v, _endpos) in
          let _v = _menhir_action_96 _endpos__8_ _startpos__1_ body name in
          _menhir_goto_vmodule _menhir_stack _v
      | _ ->
          _eRR ()
  
  let _menhir_goto_module_body : type  ttv_stack. (ttv_stack _menhir_cell0_SEMI as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState179 ->
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState005 ->
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  let _menhir_run_160 : type  ttv_stack. (ttv_stack _menhir_cell0_SEMI as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let items = _v in
      let _v = _menhir_action_33 items in
      _menhir_goto_module_body _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  let rec _menhir_run_155 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_module_item -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_module_item (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_27 x xs in
      _menhir_goto_list_module_item_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_module_item_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState179 ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState005 ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState154 ->
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_006 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_WIRE (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState006
      | IDENT _ ->
          let _v = _menhir_action_52 () in
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState006 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState007 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_TILDE (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState008 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_009 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_lit_, _startpos_lit_, lit) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_71 _endpos_lit_ _startpos_lit_ lit in
      _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_lit_ _startpos_lit_ _v _menhir_s _tok
  
  and _menhir_goto_primary_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_primary_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState022 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | MINUS | NE | PERCENT | PIPE | PLUS | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI | SLASH | STAR ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_66 e in
          _menhir_goto_postfix_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_010 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_lit_, _startpos_lit_, lit) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_70 _endpos_lit_ _startpos_lit_ lit in
      _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_lit_ _startpos_lit_ _v _menhir_s _tok
  
  and _menhir_run_011 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_lit_, _startpos_lit_, lit) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_69 _endpos_lit_ _startpos_lit_ lit in
      _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_lit_ _startpos_lit_ _v _menhir_s _tok
  
  and _menhir_run_012 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_PIPE (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState012 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_013 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState013 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_014 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState014 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_name_, _startpos_name_, name) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_67 _endpos_name_ _startpos_name_ name in
      _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_name_ _startpos_name_ _v _menhir_s _tok
  
  and _menhir_run_016 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_n_, _startpos_n_, n) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_68 _endpos_n_ _startpos_n_ n in
      _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_n_ _startpos_n_ _v _menhir_s _tok
  
  and _menhir_run_017 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_CARET (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState017 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_BANG (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState018 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_019 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_AMP (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState019 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_postfix_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_92 e in
      _menhir_goto_unary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
  
  and _menhir_goto_unary_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState008 ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState012 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState017 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState018 ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState033 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState031 ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState029 ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState147 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState066 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState052 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState050 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState044 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState042 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState040 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState038 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState036 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState019 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_095 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_TILDE -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_TILDE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_e_, e) = (_endpos, _v) in
      let _v = _menhir_action_88 _endpos_e_ _startpos__1_ e in
      _menhir_goto_unary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_094 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_PIPE -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_PIPE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_e_, e) = (_endpos, _v) in
      let _v = _menhir_action_90 _endpos_e_ _startpos__1_ e in
      _menhir_goto_unary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_086 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_CARET -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_CARET (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_e_, e) = (_endpos, _v) in
      let _v = _menhir_action_91 _endpos_e_ _startpos__1_ e in
      _menhir_goto_unary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_085 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_BANG -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_BANG (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_e_, e) = (_endpos, _v) in
      let _v = _menhir_action_87 _endpos_e_ _startpos__1_ e in
      _menhir_goto_unary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_034 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_mul_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_mul_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
      let (_endpos_r_, r) = (_endpos, _v) in
      let _v = _menhir_action_50 _endpos_r_ _startpos_l_ l r in
      _menhir_goto_mul_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
  
  and _menhir_goto_mul_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState038 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState036 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState066 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState052 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState050 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState044 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState042 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState040 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_039 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_add_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PERCENT ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | MINUS | NE | PIPE | PLUS | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let MenhirCell1_add_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_02 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_add_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_029 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_mul_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState029 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_031 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_mul_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState031 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_mul_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState033 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_add_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState147 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState066 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState052 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState050 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState044 ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState042 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState040 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_049 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_84 e in
          _menhir_goto_shift_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_036 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_add_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState036 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_038 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_add_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState038 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_shift_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState054 ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState052 ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState050 ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState066 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_055 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ARSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_rel_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_78 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_rel_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_026 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState026 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState040 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_042 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState042 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_044 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState044 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_rel_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState066 ->
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_067 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_eq_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LTEQ ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | LAND | LOR | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_eq_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_12 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_eq_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_047 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState047 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_050 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState050 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_052 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState052 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_054 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState054 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_eq_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState071 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_072 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_bitand_expr _menhir_cell0_AMP as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | NE ->
          let _menhir_stack = MenhirCell1_eq_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_eq_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | LAND | LOR | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell0_AMP (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_bitand_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_04 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_bitand_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_064 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_eq_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState064 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_066 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_eq_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState066 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_bitand_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState147 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_076 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | AMP ->
          let _menhir_stack = MenhirCell1_bitand_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer
      | CARET | COLON | COMMA | LAND | LOR | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_09 e in
          _menhir_goto_bitxor_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_071 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_bitand_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell0_AMP (_menhir_stack, _startpos) in
      let _menhir_s = MenhirState071 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_bitxor_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState074 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_075 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_bitor_expr _menhir_cell0_PIPE as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | CARET ->
          let _menhir_stack = MenhirCell1_bitxor_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON | COMMA | LAND | LOR | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell0_PIPE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_bitor_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_06 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_bitor_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_069 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_bitxor_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell0_CARET (_menhir_stack, _startpos) in
      let _menhir_s = MenhirState069 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_bitor_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState147 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_077 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PIPE ->
          let _menhir_stack = MenhirCell1_bitor_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON | COMMA | LAND | LOR | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_25 e in
          _menhir_goto_land_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_074 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_bitor_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell0_PIPE (_menhir_stack, _startpos) in
      let _menhir_s = MenhirState074 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_land_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState078 ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_079 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_lor_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LAND ->
          let _menhir_stack = MenhirCell1_land_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_062 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON | COMMA | LOR | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_lor_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_28 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_lor_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_062 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_land_expr -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState062 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TILDE ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SIZED_HEX _v ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_DEC _v ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SIZED_BIN _v ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PIPE ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DECIMAL _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CARET ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BANG ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AMP ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_lor_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | QUESTION ->
          let _menhir_stack = MenhirCell1_lor_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState057 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | LOR ->
          let _menhir_stack = MenhirCell1_lor_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState078 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | COLON | COMMA | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_86 e in
          _menhir_goto_ternary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_ternary_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState059 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState057 ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState139 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState126 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_060 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_lor_expr, _menhir_box_vmodule) _menhir_cell1_ternary_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_ternary_expr (_menhir_stack, _, then_e, _) = _menhir_stack in
      let MenhirCell1_lor_expr (_menhir_stack, _menhir_s, cond, _startpos_cond_, _) = _menhir_stack in
      let (_endpos_else_e_, else_e) = (_endpos, _v) in
      let _v = _menhir_action_85 _endpos_else_e_ _startpos_cond_ cond else_e then_e in
      _menhir_goto_ternary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_else_e_ _v _menhir_s _tok
  
  and _menhir_run_058 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_lor_expr as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ternary_expr (_menhir_stack, _menhir_s, _v, _endpos) in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState059 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_024 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let e = _v in
      let _v = _menhir_action_15 e in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState147 ->
          _menhir_run_148 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState139 ->
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState130 ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState126 ->
          _menhir_run_127 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState123 ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState007 ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState090 ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState082 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState022 ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_148 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_ALWAYS _menhir_cell0_LPAREN _menhir_cell0_IDENT _menhir_cell0_RPAREN, _menhir_box_vmodule) _menhir_cell1_lvalue -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_lvalue (_menhir_stack, _, lv) = _menhir_stack in
          let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, clk, _, _) = _menhir_stack in
          let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ALWAYS (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (e, _endpos__10_) = (_v, _endpos) in
          let _v = _menhir_action_20 _endpos__10_ _startpos__1_ clk e lv in
          _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_item : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let i = _v in
      let _v = _menhir_action_35 i in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_module_item : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_module_item (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WIRE ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | WHILE ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | TASK ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | REG ->
          _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | PARAMETER ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | IF ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | GENERATE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | FUNCTION ->
          _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | FOR ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | END ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | CASE ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | BEGIN ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | ASSIGN ->
          _menhir_run_121 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | ALWAYS_FF ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | ALWAYS_COMB ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | ALWAYS ->
          _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | ENDMODULE ->
          let _v_0 = _menhir_action_26 () in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0
      | _ ->
          _eRR ()
  
  and _menhir_run_107 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_41 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_108 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_43 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_109 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell1_REG (_menhir_stack, _menhir_s, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | IDENT _ ->
          let _v = _menhir_action_52 () in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState109 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_110 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_REG as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_range_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState110
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_COMMA (_menhir_stack, _endpos) in
          let _menhir_s = MenhirState103 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | SEMI ->
          let name = _v in
          let _v = _menhir_action_10 name in
          _menhir_goto_declarator_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_declarator_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState110 ->
          _menhir_run_111 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState101 ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState103 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_111 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_REG, _menhir_box_vmodule) _menhir_cell1_option_range_ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_option_range_ (_menhir_stack, _, r) = _menhir_stack in
      let MenhirCell1_REG (_menhir_stack, _menhir_s, _startpos__1_, _) = _menhir_stack in
      let (_endpos__4_, names) = (_endpos, _v) in
      let _v = _menhir_action_94 _endpos__4_ _startpos__1_ names r in
      _menhir_goto_var_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_var_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let d = _v in
      let _v = _menhir_action_34 d in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_105 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_WIRE, _menhir_box_vmodule) _menhir_cell1_option_range_ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_option_range_ (_menhir_stack, _, r) = _menhir_stack in
      let MenhirCell1_WIRE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__4_, names) = (_endpos, _v) in
      let _v = _menhir_action_93 _endpos__4_ _startpos__1_ names r in
      _menhir_goto_var_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_104 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_IDENT _menhir_cell0_COMMA -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell0_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name, _, _) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_11 name rest in
      _menhir_goto_declarator_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_113 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_45 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_114 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_38 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_115 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_44 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_116 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_42 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_117 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_40 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_118 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_37 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_119 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_39 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_120 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_36 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_121 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_ASSIGN (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState121 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_122 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState123 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | EQ | LTEQ ->
          let (_endpos_name_, _startpos_name_, name) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_30 _endpos_name_ _startpos_name_ name in
          _menhir_goto_lvalue _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_lvalue : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState145 ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState137 ->
          _menhir_run_138 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_146 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_ALWAYS _menhir_cell0_LPAREN _menhir_cell0_IDENT _menhir_cell0_RPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_lvalue (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LTEQ ->
          let _menhir_s = MenhirState147 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_138 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_ALWAYS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_lvalue (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState139 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_129 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_ASSIGN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_lvalue (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState130 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_133 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_46 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_134 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_47 _endpos__1_ _startpos__1_ in
      _menhir_goto_module_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_135 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STAR ->
              let _menhir_stack = MenhirCell1_ALWAYS (_menhir_stack, _menhir_s, _startpos) in
              let _menhir_s = MenhirState137 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | LPAREN ->
              let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | POSEDGE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | IDENT _v ->
                      let _startpos_1 = _menhir_lexbuf.Lexing.lex_start_p in
                      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | RPAREN ->
                          let _menhir_stack = MenhirCell1_ALWAYS (_menhir_stack, _menhir_s, _startpos) in
                          let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos_0) in
                          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v, _startpos_1, _endpos) in
                          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                          let _menhir_stack = MenhirCell0_RPAREN (_menhir_stack, _endpos) in
                          let _menhir_s = MenhirState145 in
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | IDENT _v ->
                              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | _ ->
                              _eRR ())
                      | COMMA ->
                          let _endpos_4 = _menhir_lexbuf.Lexing.lex_curr_p in
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let (_startpos__1_, _endpos__6_) = (_startpos, _endpos_4) in
                          let _v = _menhir_action_21 _endpos__6_ _startpos__1_ in
                          _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | NEGEDGE ->
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_startpos__1_, _endpos__4_) = (_startpos, _endpos) in
                  let _v = _menhir_action_22 _endpos__4_ _startpos__1_ in
                  _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | IDENT _ ->
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_startpos__1_, _endpos__4_) = (_startpos, _endpos) in
                  let _v = _menhir_action_23 _endpos__4_ _startpos__1_ in
                  _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_140 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_ALWAYS, _menhir_box_vmodule) _menhir_cell1_lvalue -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_lvalue (_menhir_stack, _, lv) = _menhir_stack in
          let MenhirCell1_ALWAYS (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (e, _endpos__7_) = (_v, _endpos) in
          let _v = _menhir_action_19 _endpos__7_ _startpos__1_ e lv in
          _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_131 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_ASSIGN, _menhir_box_vmodule) _menhir_cell1_lvalue -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_lvalue (_menhir_stack, _, lv) = _menhir_stack in
          let MenhirCell1_ASSIGN (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (e, _endpos__5_) = (_v, _endpos) in
          let _v = _menhir_action_18 _endpos__5_ _startpos__1_ e lv in
          _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_127 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_IDENT, _menhir_box_vmodule) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, msb) = _menhir_stack in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name, _startpos_name_, _) = _menhir_stack in
          let (_endpos__6_, lsb) = (_endpos, _v) in
          let _v = _menhir_action_32 _endpos__6_ _startpos_name_ lsb msb name in
          _menhir_goto_lvalue _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_124 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name, _startpos_name_, _) = _menhir_stack in
          let (_endpos__4_, idx) = (_endpos, _v) in
          let _v = _menhir_action_31 _endpos__4_ _startpos_name_ idx name in
          _menhir_goto_lvalue _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COLON ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState126 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_098 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_LBRACKET, _menhir_box_vmodule) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, msb) = _menhir_stack in
          let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
          let lsb = _v in
          let _v = _menhir_action_74 lsb msb in
          let x = _v in
          let _v = _menhir_action_53 x in
          _menhir_goto_option_range_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_range_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState169 ->
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState170 ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState161 ->
          _menhir_run_167 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState162 ->
          _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState109 ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState006 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_174 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_INPUT -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_INPUT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_name_, name, r) = (_endpos, _v_0, _v) in
          let _v = _menhir_action_55 _endpos_name_ _startpos__1_ name r in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_port_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_port_decl (_menhir_stack, _menhir_s, _v) in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_COMMA (_menhir_stack, _endpos) in
          let _menhir_s = MenhirState184 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OUTPUT ->
              _menhir_run_161 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INPUT ->
              _menhir_run_169 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INOUT ->
              _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let p = _v in
          let _v = _menhir_action_62 p in
          _menhir_goto_port_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_161 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WIRE ->
          let _menhir_stack = MenhirCell1_OUTPUT (_menhir_stack, _menhir_s, _startpos) in
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell1_WIRE (_menhir_stack, MenhirState161, _startpos_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACKET ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState162
          | IDENT _ ->
              let _v = _menhir_action_52 () in
              _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | SIGNED ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_startpos__1_, _endpos__2_) = (_startpos, _endpos) in
          let _v = _menhir_action_61 _endpos__2_ _startpos__1_ in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | REG ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_startpos__1_, _endpos__2_) = (_startpos, _endpos) in
          let _v = _menhir_action_58 _endpos__2_ _startpos__1_ in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_OUTPUT (_menhir_stack, _menhir_s, _startpos) in
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | IDENT _ ->
          let _menhir_stack = MenhirCell1_OUTPUT (_menhir_stack, _menhir_s, _startpos) in
          let _v = _menhir_action_52 () in
          _menhir_run_167 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_163 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_OUTPUT, _menhir_box_vmodule) _menhir_cell1_WIRE -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_WIRE (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell1_OUTPUT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_name_, name, r) = (_endpos, _v_0, _v) in
          let _v = _menhir_action_56 _endpos_name_ _startpos__1_ name r in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_167 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_OUTPUT -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_OUTPUT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_name_, name, r) = (_endpos, _v_0, _v) in
          let _v = _menhir_action_57 _endpos_name_ _startpos__1_ name r in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_169 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WIRE ->
          let _menhir_stack = MenhirCell1_INPUT (_menhir_stack, _menhir_s, _startpos) in
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell1_WIRE (_menhir_stack, MenhirState169, _startpos_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACKET ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
          | IDENT _ ->
              let _v = _menhir_action_52 () in
              _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | SIGNED ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_startpos__1_, _endpos__2_) = (_startpos, _endpos) in
          let _v = _menhir_action_60 _endpos__2_ _startpos__1_ in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_INPUT (_menhir_stack, _menhir_s, _startpos) in
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | IDENT _ ->
          let _menhir_stack = MenhirCell1_INPUT (_menhir_stack, _menhir_s, _startpos) in
          let _v = _menhir_action_52 () in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_171 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_INPUT, _menhir_box_vmodule) _menhir_cell1_WIRE -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_WIRE (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell1_INPUT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_name_, name, r) = (_endpos, _v_0, _v) in
          let _v = _menhir_action_54 _endpos_name_ _startpos__1_ name r in
          _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_176 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_59 _endpos__1_ _startpos__1_ in
      _menhir_goto_port_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_port_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState184 ->
          _menhir_run_185 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState003 ->
          _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_185 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_port_decl _menhir_cell0_COMMA -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell0_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_port_decl (_menhir_stack, _menhir_s, p) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_63 p rest in
      _menhir_goto_port_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_177 : type  ttv_stack. (ttv_stack _menhir_cell0_MODULE _menhir_cell0_IDENT _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_port_list (_menhir_stack, _menhir_s, _v) in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_RPAREN (_menhir_stack, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_SEMI (_menhir_stack, _endpos_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WIRE ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | WHILE ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | TASK ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | REG ->
              _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | PARAMETER ->
              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | IF ->
              _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | GENERATE ->
              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | FUNCTION ->
              _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | FOR ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | END ->
              _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | CASE ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | BEGIN ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | ASSIGN ->
              _menhir_run_121 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | ALWAYS_FF ->
              _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | ALWAYS_COMB ->
              _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | ALWAYS ->
              _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
          | ENDMODULE ->
              let _v_1 = _menhir_action_26 () in
              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState179
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_101 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_WIRE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_range_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState101
      | _ ->
          _eRR ()
  
  and _menhir_run_096 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_LBRACKET as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState097 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_092 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_LPAREN -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos__3_, e) = (_endpos, _v) in
          let _v = _menhir_action_72 _endpos__3_ _startpos__1_ e in
          _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_089 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_COMMA (_menhir_stack, _endpos) in
          let _menhir_s = MenhirState090 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RBRACE ->
          let e = _v in
          let _v = _menhir_action_16 e in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState090 ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState014 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_091 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_expr _menhir_cell0_COMMA -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell0_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_17 e rest in
      _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_087 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__3_, exprs) = (_endpos, _v) in
      let _v = _menhir_action_73 _endpos__3_ _startpos__1_ exprs in
      _menhir_goto_primary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_083 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_primary_expr, _menhir_box_vmodule) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, msb) = _menhir_stack in
          let MenhirCell1_primary_expr (_menhir_stack, _menhir_s, e, _startpos_e_, _) = _menhir_stack in
          let (_endpos__6_, lsb) = (_endpos, _v) in
          let _v = _menhir_action_65 _endpos__6_ _startpos_e_ e lsb msb in
          _menhir_goto_postfix_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__6_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_080 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_primary_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_primary_expr (_menhir_stack, _menhir_s, e, _startpos_e_, _) = _menhir_stack in
          let (_endpos__4_, idx) = (_endpos, _v) in
          let _v = _menhir_action_64 _endpos__4_ _startpos_e_ e idx in
          _menhir_goto_postfix_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__4_ _startpos_e_ _v _menhir_s _tok
      | COLON ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState082 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TILDE ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SIZED_HEX _v ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_DEC _v ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SIZED_BIN _v ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | PIPE ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DECIMAL _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CARET ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BANG ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AMP ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_061 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LAND ->
          let _menhir_stack = MenhirCell1_land_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_062 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON | COMMA | LOR | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_29 e in
          _menhir_goto_lor_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_073 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_land_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PIPE ->
          let _menhir_stack = MenhirCell1_bitor_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON | COMMA | LAND | LOR | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_land_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_24 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_land_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_068 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | CARET ->
          let _menhir_stack = MenhirCell1_bitxor_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON | COMMA | LAND | LOR | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_07 e in
          _menhir_goto_bitor_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_070 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_bitxor_expr _menhir_cell0_CARET as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | AMP ->
          let _menhir_stack = MenhirCell1_bitand_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer
      | CARET | COLON | COMMA | LAND | LOR | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell0_CARET (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_bitxor_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_08 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_bitxor_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_063 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | NE ->
          let _menhir_stack = MenhirCell1_eq_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_eq_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | LAND | LOR | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_05 e in
          _menhir_goto_bitand_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_065 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_eq_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LTEQ ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | LAND | LOR | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_eq_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_13 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_eq_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_046 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LTEQ ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_rel_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | LAND | LOR | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_14 e in
          _menhir_goto_eq_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_053 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ARSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_rel_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_77 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_rel_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_051 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ARSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_rel_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_75 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_rel_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_048 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_rel_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ARSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let MenhirCell1_rel_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_76 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_rel_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_025 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ARSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT ->
          let _menhir_stack = MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AMP | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_79 e in
          _menhir_goto_rel_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_045 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _l, _startpos__l_, _) = _menhir_stack in
          let (_endpos__r_, _r) = (_endpos, _v) in
          let _v = _menhir_action_82 _endpos__r_ _l _r _startpos__l_ in
          _menhir_goto_shift_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__r_ _startpos__l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_043 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let MenhirCell1_shift_expr (_menhir_stack, _menhir_s, _l, _startpos__l_, _) = _menhir_stack in
          let (_endpos__r_, _r) = (_endpos, _v) in
          let _v = _menhir_action_83 _endpos__r_ _l _r _startpos__l_ in
          _menhir_goto_shift_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__r_ _startpos__l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_041 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let MenhirCell1_shift_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_80 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_shift_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_035 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_shift_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_add_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | NE | PIPE | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let MenhirCell1_shift_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_81 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_shift_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_037 : type  ttv_stack. ((ttv_stack, _menhir_box_vmodule) _menhir_cell1_add_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PERCENT ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | MINUS | NE | PIPE | PLUS | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let MenhirCell1_add_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
          let (_endpos_r_, r) = (_endpos, _v) in
          let _v = _menhir_action_01 _endpos_r_ _startpos_l_ l r in
          _menhir_goto_add_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_028 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PERCENT ->
          let _menhir_stack = MenhirCell1_mul_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ALSHIFT | AMP | ARSHIFT | CARET | COLON | COMMA | EQEQ | GE | GT | LAND | LOR | LSHIFT | LT | LTEQ | MINUS | NE | PIPE | PLUS | QUESTION | RBRACE | RBRACKET | RPAREN | RSHIFT | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_03 e in
          _menhir_goto_add_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_mul_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_mul_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
      let (_endpos_r_, r) = (_endpos, _v) in
      let _v = _menhir_action_49 _endpos_r_ _startpos_l_ l r in
      _menhir_goto_mul_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
  
  and _menhir_run_030 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_mul_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_mul_expr (_menhir_stack, _menhir_s, l, _startpos_l_, _) = _menhir_stack in
      let (_endpos_r_, r) = (_endpos, _v) in
      let _v = _menhir_action_48 _endpos_r_ _startpos_l_ l r in
      _menhir_goto_mul_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_r_ _startpos_l_ _v _menhir_s _tok
  
  and _menhir_run_023 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_vmodule) _menhir_state -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_51 e in
      _menhir_goto_mul_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
  
  and _menhir_run_020 : type  ttv_stack. (ttv_stack, _menhir_box_vmodule) _menhir_cell1_AMP -> _ -> _ -> _ -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_AMP (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_e_, e) = (_endpos, _v) in
      let _v = _menhir_action_89 _endpos_e_ _startpos__1_ e in
      _menhir_goto_unary_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_vmodule =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MODULE ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_MODULE (_menhir_stack, _startpos) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v, _startpos_0, _endpos) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | LPAREN ->
                  let _startpos_1 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos_1) in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | RPAREN ->
                      let _endpos_2 = _menhir_lexbuf.Lexing.lex_curr_p in
                      let _menhir_stack = MenhirCell1_RPAREN (_menhir_stack, MenhirState003, _endpos_2) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | SEMI ->
                          let _endpos_3 = _menhir_lexbuf.Lexing.lex_curr_p in
                          let _menhir_stack = MenhirCell0_SEMI (_menhir_stack, _endpos_3) in
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | WIRE ->
                              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | WHILE ->
                              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | TASK ->
                              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | REG ->
                              _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | PARAMETER ->
                              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | IF ->
                              _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | GENERATE ->
                              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | FUNCTION ->
                              _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | FOR ->
                              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | END ->
                              _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | CASE ->
                              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | BEGIN ->
                              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | ASSIGN ->
                              _menhir_run_121 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | ALWAYS_FF ->
                              _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | ALWAYS_COMB ->
                              _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | ALWAYS ->
                              _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
                          | ENDMODULE ->
                              let _v_4 = _menhir_action_26 () in
                              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState005
                          | _ ->
                              _eRR ())
                      | _ ->
                          _eRR ())
                  | OUTPUT ->
                      _menhir_run_161 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
                  | INPUT ->
                      _menhir_run_169 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
                  | INOUT ->
                      _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let vmodule =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_vmodule v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
