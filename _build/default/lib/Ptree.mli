(** Ptree: Parse tree types for a small Verilog subset. *)

(** Location information for error reporting *)
type loc = {
  start_pos: Lexing.position;
  end_pos: Lexing.position;
}

val mk_loc : Lexing.position -> Lexing.position -> loc
val dummy_loc : loc

(** Base for numeric literals *)
type num_base =
  | BinBase
  | DecBase
  | HexBase

(** Numeric literal representation *)
type num_literal = {
  width: int option;
  base: num_base;
  digits: string;
  lit_loc: loc;
}

(** Unary operators *)
type unop =
  | UNot
  | UBitNot

(** Binary operators *)
type binop =
  | BAdd | BSub | BMul | BDiv | BMod
  | BShl | BShr
  | BLt | BLe | BGt | BGe
  | BEq | BNe
  | BAnd | BOr | BXor
  | BLAnd | BLOr

(** Expressions *)
type expr =
  | EId of string * loc
  | ENum of num_literal
  | EUnop of unop * expr * loc
  | EBinop of binop * expr * expr * loc
  | ETernary of expr * expr * expr * loc
  | EConcat of expr list * loc
  | EIndex of expr * expr * loc
  | ESlice of expr * expr * expr * loc
  | EParen of expr * loc

(** Lvalues for assignments *)
type lvalue =
  | LVId of string * loc
  | LVIndex of string * expr * loc
  | LVSlice of string * expr * expr * loc

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
  port_range: range option;
  port_wire_explicit: bool;
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
  | ItemAssign of lvalue * expr * loc
  | ItemAlwaysComb of lvalue * expr * loc
  | ItemAlwaysFF of string * lvalue * expr * loc

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

val parse_error : string -> loc -> 'a
val string_of_loc : loc -> string
