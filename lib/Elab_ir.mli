(** Elab_ir: Elaborated intermediate representation types. *)

(** Elaboration error exception *)
exception Elab_error of string * Ptree.loc

val elab_error : string -> Ptree.loc -> 'a
val format_elab_error : string -> Ptree.loc -> string

(** Variable identifier *)
type variable = string

(** Symbol kinds *)
type sym_kind =
  | SymInput
  | SymOutput
  | SymWire
  | SymReg

(** Symbol table entry *)
type symbol = {
  sym_name: variable;
  sym_kind: sym_kind;
  sym_width: int;
  sym_loc: Ptree.loc;
}

(** Width-annotated elaborated expressions *)
type eexpr =
  | EEVar of variable * int
  | EEConst of int * int
  | EEUnop of Ptree.unop * eexpr * int
  | EEBinop of Ptree.binop * eexpr * eexpr * int
  | EETernary of eexpr * eexpr * eexpr * int
  | EEConcat of eexpr list * int
  | EEIndex of eexpr * eexpr * int
  | EESlice of eexpr * int * int * int

val eexpr_width : eexpr -> int

(** Elaborated lvalue *)
type elvalue =
  | ELVar of variable * int
  | ELIndex of variable * eexpr * int
  | ELSlice of variable * int * int * int

val elvalue_var : elvalue -> variable

(** Definition kinds *)
type def_kind =
  | DefInput
  | DefNet
  | DefReg

(** A definition in the elaborated IR *)
type defn = {
  def_name: variable;
  def_width: int;
  def_rhs: eexpr option;
  def_kind: def_kind;
  def_loc: Ptree.loc;
}

(** Elaborated module *)
type elaborated_module = {
  elab_name: string;
  elab_inputs: defn list;
  elab_nets: defn list;
  elab_regs: defn list;
  elab_outputs: variable list;
}

(** Symbol table *)
module SymbolTable : Map.S with type key = string
type symtab = symbol SymbolTable.t

(** Driver tracking *)
module DriverMap : Map.S with type key = string
type drivers = Ptree.loc DriverMap.t
