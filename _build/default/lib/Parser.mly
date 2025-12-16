%{
(* Parser for a small Verilog subset *)
open Ptree

let mk_loc startpos endpos = { start_pos = startpos; end_pos = endpos }

let parse_error_at startpos endpos msg =
  let loc = mk_loc startpos endpos in
  raise (Parse_error (msg, loc))
%}

(* Tokens *)
%token <string> IDENT
%token <string> DECIMAL
%token <int * string> SIZED_BIN
%token <int * string> SIZED_DEC
%token <int * string> SIZED_HEX

%token MODULE ENDMODULE
%token INPUT OUTPUT WIRE REG
%token ASSIGN ALWAYS

(* Rejected keywords - produce nice error messages *)
%token BEGIN END
%token POSEDGE NEGEDGE
%token ALWAYS_FF ALWAYS_COMB
%token INOUT SIGNED
%token IF ELSE CASE ENDCASE FOR WHILE
%token FUNCTION ENDFUNCTION TASK ENDTASK
%token GENERATE ENDGENERATE PARAMETER

(* Punctuation *)
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE
%token COMMA SEMI COLON AT
%token EQ

(* Operators *)
%token STAR PLUS MINUS SLASH PERCENT
%token BANG TILDE QUESTION
%token LSHIFT RSHIFT ALSHIFT ARSHIFT
%token LT LTEQ GT GE
%token EQEQ NE
%token LAND LOR
%token AMP PIPE CARET

%token EOF

(* Precedence - lowest to highest *)
%right QUESTION COLON
%left LOR
%left LAND
%left PIPE
%left CARET
%left AMP
%left EQEQ NE
%left LT LTEQ GT GE
%left LSHIFT RSHIFT
%left PLUS MINUS
%left STAR SLASH PERCENT
%right BANG TILDE

%start <Ptree.vmodule> vmodule

%%

vmodule:
  | MODULE name=IDENT LPAREN ports=port_list RPAREN SEMI
    body=module_body
    ENDMODULE EOF
    {
      let (decls, items) = body in
      { mod_name = name;
        mod_ports = ports;
        mod_decls = decls;
        mod_items = items;
        mod_loc = mk_loc $startpos $endpos }
    }
  | MODULE name=IDENT LPAREN RPAREN SEMI
    body=module_body
    ENDMODULE EOF
    {
      let (decls, items) = body in
      { mod_name = name;
        mod_ports = [];
        mod_decls = decls;
        mod_items = items;
        mod_loc = mk_loc $startpos $endpos }
    }
;

port_list:
  | p=port_decl { [p] }
  | p=port_decl COMMA rest=port_list { p :: rest }
;

port_decl:
  (* input wire [range] name *)
  | INPUT WIRE r=option(range) name=IDENT
    { { port_dir = DirInput;
        port_name = name;
        port_range = r;
        port_wire_explicit = true;
        port_loc = mk_loc $startpos $endpos } }
  (* input [range] name *)
  | INPUT r=option(range) name=IDENT
    { { port_dir = DirInput;
        port_name = name;
        port_range = r;
        port_wire_explicit = false;
        port_loc = mk_loc $startpos $endpos } }
  (* output wire [range] name *)
  | OUTPUT WIRE r=option(range) name=IDENT
    { { port_dir = DirOutput;
        port_name = name;
        port_range = r;
        port_wire_explicit = true;
        port_loc = mk_loc $startpos $endpos } }
  (* output [range] name - implicitly wire *)
  | OUTPUT r=option(range) name=IDENT
    { { port_dir = DirOutput;
        port_name = name;
        port_range = r;
        port_wire_explicit = false;
        port_loc = mk_loc $startpos $endpos } }
  (* output reg - REJECTED *)
  | OUTPUT REG
    { parse_error_at $startpos $endpos "output reg is not allowed; outputs must be wires" }
  (* inout - REJECTED *)
  | INOUT
    { parse_error_at $startpos $endpos "inout ports are not supported" }
  (* signed - REJECTED *)
  | INPUT SIGNED
    { parse_error_at $startpos $endpos "signed is not supported" }
  | OUTPUT SIGNED
    { parse_error_at $startpos $endpos "signed is not supported" }
;

range:
  | LBRACKET msb=expr COLON lsb=expr RBRACKET { (msb, lsb) }
;

module_body:
  | items=list(module_item)
    {
      let decls = List.concat_map (function
        | `Decls ds -> ds
        | `Item _ -> []) items in
      let stmts = List.filter_map (function
        | `Item i -> Some i
        | `Decls _ -> None) items in
      (decls, stmts)
    }
;

module_item:
  | d=var_decl { `Decls d }
  | i=item { `Item i }
  (* Rejected constructs *)
  | BEGIN
    { parse_error_at $startpos $endpos "begin/end blocks are not supported" }
  | END
    { parse_error_at $startpos $endpos "begin/end blocks are not supported" }
  | IF
    { parse_error_at $startpos $endpos "if statements are not supported" }
  | CASE
    { parse_error_at $startpos $endpos "case statements are not supported" }
  | FOR
    { parse_error_at $startpos $endpos "for loops are not supported" }
  | WHILE
    { parse_error_at $startpos $endpos "while loops are not supported" }
  | FUNCTION
    { parse_error_at $startpos $endpos "functions are not supported" }
  | TASK
    { parse_error_at $startpos $endpos "tasks are not supported" }
  | GENERATE
    { parse_error_at $startpos $endpos "generate blocks are not supported" }
  | PARAMETER
    { parse_error_at $startpos $endpos "parameters are not supported" }
  | ALWAYS_FF
    { parse_error_at $startpos $endpos "always_ff is not supported" }
  | ALWAYS_COMB
    { parse_error_at $startpos $endpos "always_comb keyword is not supported; use always @*" }
;

var_decl:
  | WIRE r=option(range) names=declarator_list SEMI
    {
      List.map (fun name ->
        { var_kind = VarWire;
          var_name = name;
          var_range = r;
          var_loc = mk_loc $startpos $endpos }) names
    }
  | REG r=option(range) names=declarator_list SEMI
    {
      List.map (fun name ->
        { var_kind = VarReg;
          var_name = name;
          var_range = r;
          var_loc = mk_loc $startpos $endpos }) names
    }
;

declarator_list:
  | name=IDENT { [name] }
  | name=IDENT COMMA rest=declarator_list { name :: rest }
;

item:
  | ASSIGN lv=lvalue EQ e=expr SEMI
    { ItemAssign (lv, e, mk_loc $startpos $endpos) }
  | ALWAYS AT STAR lv=lvalue EQ e=expr SEMI
    { ItemAlwaysComb (lv, e, mk_loc $startpos $endpos) }
  | ALWAYS AT LPAREN POSEDGE clk=IDENT RPAREN lv=lvalue LTEQ e=expr SEMI
    { ItemAlwaysFF (clk, lv, e, mk_loc $startpos $endpos) }
  (* Reject always with other explicit sensitivity lists *)
  | ALWAYS AT LPAREN POSEDGE IDENT COMMA
    { parse_error_at $startpos $endpos "only single posedge signals are supported" }
  | ALWAYS AT LPAREN NEGEDGE
    { parse_error_at $startpos $endpos "negedge is not supported" }
  | ALWAYS AT LPAREN IDENT
    { parse_error_at $startpos $endpos "explicit sensitivity lists without posedge are not supported; use always @*" }
;

lvalue:
  | name=IDENT
    { LVId (name, mk_loc $startpos $endpos) }
  | name=IDENT LBRACKET idx=expr RBRACKET
    { LVIndex (name, idx, mk_loc $startpos $endpos) }
  | name=IDENT LBRACKET msb=expr COLON lsb=expr RBRACKET
    { LVSlice (name, msb, lsb, mk_loc $startpos $endpos) }
;

expr:
  | e=ternary_expr { e }
;

ternary_expr:
  | cond=lor_expr QUESTION then_e=ternary_expr COLON else_e=ternary_expr
    { ETernary (cond, then_e, else_e, mk_loc $startpos $endpos) }
  | e=lor_expr { e }
;

lor_expr:
  | l=lor_expr LOR r=land_expr
    { EBinop (BLOr, l, r, mk_loc $startpos $endpos) }
  | e=land_expr { e }
;

land_expr:
  | l=land_expr LAND r=bitor_expr
    { EBinop (BLAnd, l, r, mk_loc $startpos $endpos) }
  | e=bitor_expr { e }
;

bitor_expr:
  | l=bitor_expr PIPE r=bitxor_expr
    { EBinop (BOr, l, r, mk_loc $startpos $endpos) }
  | e=bitxor_expr { e }
;

bitxor_expr:
  | l=bitxor_expr CARET r=bitand_expr
    { EBinop (BXor, l, r, mk_loc $startpos $endpos) }
  | e=bitand_expr { e }
;

bitand_expr:
  | l=bitand_expr AMP r=eq_expr
    { EBinop (BAnd, l, r, mk_loc $startpos $endpos) }
  | e=eq_expr { e }
;

eq_expr:
  | l=eq_expr EQEQ r=rel_expr
    { EBinop (BEq, l, r, mk_loc $startpos $endpos) }
  | l=eq_expr NE r=rel_expr
    { EBinop (BNe, l, r, mk_loc $startpos $endpos) }
  | e=rel_expr { e }
;

rel_expr:
  | l=rel_expr LT r=shift_expr
    { EBinop (BLt, l, r, mk_loc $startpos $endpos) }
  | l=rel_expr LTEQ r=shift_expr
    { EBinop (BLe, l, r, mk_loc $startpos $endpos) }
  | l=rel_expr GT r=shift_expr
    { EBinop (BGt, l, r, mk_loc $startpos $endpos) }
  | l=rel_expr GE r=shift_expr
    { EBinop (BGe, l, r, mk_loc $startpos $endpos) }
  | e=shift_expr { e }
;

shift_expr:
  | l=shift_expr LSHIFT r=add_expr
    { EBinop (BShl, l, r, mk_loc $startpos $endpos) }
  | l=shift_expr RSHIFT r=add_expr
    { EBinop (BShr, l, r, mk_loc $startpos $endpos) }
  | _l=shift_expr ALSHIFT _r=add_expr
    { parse_error_at $startpos $endpos "arithmetic left shift <<< is not supported" }
  | _l=shift_expr ARSHIFT _r=add_expr
    { parse_error_at $startpos $endpos "arithmetic right shift >>> is not supported" }
  | e=add_expr { e }
;

add_expr:
  | l=add_expr PLUS r=mul_expr
    { EBinop (BAdd, l, r, mk_loc $startpos $endpos) }
  | l=add_expr MINUS r=mul_expr
    { EBinop (BSub, l, r, mk_loc $startpos $endpos) }
  | e=mul_expr { e }
;

mul_expr:
  | l=mul_expr STAR r=unary_expr
    { EBinop (BMul, l, r, mk_loc $startpos $endpos) }
  | l=mul_expr SLASH r=unary_expr
    { EBinop (BDiv, l, r, mk_loc $startpos $endpos) }
  | l=mul_expr PERCENT r=unary_expr
    { EBinop (BMod, l, r, mk_loc $startpos $endpos) }
  | e=unary_expr { e }
;

unary_expr:
  | BANG e=unary_expr
    { EUnop (UNot, e, mk_loc $startpos $endpos) }
  | TILDE e=unary_expr
    { EUnop (UBitNot, e, mk_loc $startpos $endpos) }
  (* Reject reduction operators *)
  | AMP e=unary_expr
    { let _ = e in parse_error_at $startpos $endpos "reduction AND (&) is not supported as unary operator" }
  | PIPE e=unary_expr
    { let _ = e in parse_error_at $startpos $endpos "reduction OR (|) is not supported as unary operator" }
  | CARET e=unary_expr
    { let _ = e in parse_error_at $startpos $endpos "reduction XOR (^) is not supported as unary operator" }
  | e=postfix_expr { e }
;

postfix_expr:
  | e=primary_expr LBRACKET idx=expr RBRACKET
    {
      (* Check if there's a colon for slice *)
      EIndex (e, idx, mk_loc $startpos $endpos)
    }
  | e=primary_expr LBRACKET msb=expr COLON lsb=expr RBRACKET
    { ESlice (e, msb, lsb, mk_loc $startpos $endpos) }
  | e=primary_expr { e }
;

primary_expr:
  | name=IDENT
    { EId (name, mk_loc $startpos $endpos) }
  | n=DECIMAL
    { ENum { width = None; base = DecBase; digits = n; lit_loc = mk_loc $startpos $endpos } }
  | lit=SIZED_BIN
    { let (w, d) = lit in
      ENum { width = Some w; base = BinBase; digits = d; lit_loc = mk_loc $startpos $endpos } }
  | lit=SIZED_DEC
    { let (w, d) = lit in
      ENum { width = Some w; base = DecBase; digits = d; lit_loc = mk_loc $startpos $endpos } }
  | lit=SIZED_HEX
    { let (w, d) = lit in
      ENum { width = Some w; base = HexBase; digits = d; lit_loc = mk_loc $startpos $endpos } }
  | LPAREN e=expr RPAREN
    { EParen (e, mk_loc $startpos $endpos) }
  | LBRACE exprs=expr_list RBRACE
    { EConcat (exprs, mk_loc $startpos $endpos) }
;

expr_list:
  | e=expr { [e] }
  | e=expr COMMA rest=expr_list { e :: rest }
;
