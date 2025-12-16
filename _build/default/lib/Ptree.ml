(** Ptree: Parse tree types for a small Verilog subset.
    
    This module defines the AST produced by the lexer+parser.
    No elaboration, width checking, or name resolution is performed here.
*)

(** Location information for error reporting *)
type loc = {
  start_pos: Lexing.position;
  end_pos: Lexing.position;
}

(** Create a location from two positions *)
let mk_loc start_pos end_pos = { start_pos; end_pos }

(** Dummy location for synthesized nodes *)
let dummy_loc = {
  start_pos = Lexing.dummy_pos;
  end_pos = Lexing.dummy_pos;
}

(** Base for numeric literals *)
type num_base =
  | BinBase   (** 'b or 'B *)
  | DecBase   (** 'd or 'D or unsized decimal *)
  | HexBase   (** 'h or 'H *)

(** Numeric literal representation *)
type num_literal = {
  width: int option;     (** None for unsized decimals like 42 *)
  base: num_base;
  digits: string;        (** Validated digit string (no x/z) *)
  lit_loc: loc;
}

(** Unary operators *)
type unop =
  | UNot    (** ! logical not *)
  | UBitNot (** ~ bitwise not *)

(** Binary operators *)
type binop =
  (* Arithmetic *)
  | BAdd | BSub | BMul | BDiv | BMod
  (* Shifts (logical only) *)
  | BShl | BShr
  (* Relational *)
  | BLt | BLe | BGt | BGe
  (* Equality *)
  | BEq | BNe
  (* Bitwise *)
  | BAnd | BOr | BXor
  (* Logical *)
  | BLAnd | BLOr

(** Expressions *)
type expr =
  | EId of string * loc                          (** Identifier *)
  | ENum of num_literal                          (** Numeric literal *)
  | EUnop of unop * expr * loc                   (** Unary operation *)
  | EBinop of binop * expr * expr * loc          (** Binary operation *)
  | ETernary of expr * expr * expr * loc         (** cond ? then : else *)
  | EConcat of expr list * loc                   (** {e1, e2, ...} *)
  | EIndex of expr * expr * loc                  (** e[i] bit select *)
  | ESlice of expr * expr * expr * loc           (** e[msb:lsb] part select *)
  | EParen of expr * loc                         (** (e) parenthesized *)

(** Lvalues for assignments *)
type lvalue =
  | LVId of string * loc                         (** x *)
  | LVIndex of string * expr * loc               (** x[i] *)
  | LVSlice of string * expr * expr * loc        (** x[msb:lsb] *)

(** Range specification [msb:lsb] *)
type range = expr * expr

(** Port direction *)
type direction =
  | DirInput
  | DirOutput

(** ANSI port declaration in module header *)
type port_decl = {
  port_dir: direction;
  port_name: string;
  port_range: range option;       (** Optional packed range *)
  port_wire_explicit: bool;       (** True if 'wire' keyword was explicit *)
  port_loc: loc;
}

(** Variable type for internal declarations *)
type var_kind =
  | VarWire
  | VarReg

(** Internal declaration (wire or reg) *)
type var_decl = {
  var_kind: var_kind;
  var_name: string;
  var_range: range option;
  var_loc: loc;
}

(** Module items *)
type item =
  | ItemAssign of lvalue * expr * loc            (** assign lv = e; *)
  | ItemAlwaysComb of lvalue * expr * loc        (** always @* lv = e; *)
  | ItemAlwaysFF of string * lvalue * expr * loc (** always @(posedge clk) lv <= e; *)

(** Top-level module *)
type vmodule = {
  mod_name: string;
  mod_ports: port_decl list;
  mod_decls: var_decl list;
  mod_items: item list;
  mod_loc: loc;
}

(** Parse error exception *)
exception Parse_error of string * loc

(** Raise a parse error with message and location *)
let parse_error msg loc =
  raise (Parse_error (msg, loc))

(** Format a location for error messages *)
let string_of_loc loc =
  let p = loc.start_pos in
  Printf.sprintf "%s:%d:%d"
    p.Lexing.pos_fname
    p.Lexing.pos_lnum
    (p.Lexing.pos_cnum - p.Lexing.pos_bol + 1)
