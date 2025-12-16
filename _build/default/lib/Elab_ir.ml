(** Elab_ir: Elaborated intermediate representation types.
    
    This module defines the IR produced by elaboration, suitable for
    dependency analysis and lowering to a cycle-based simulator.
*)

open Ptree

(** Elaboration error exception *)
exception Elab_error of string * loc

(** Raise an elaboration error with message and location *)
let elab_error msg loc =
  raise (Elab_error (msg, loc))

(** Format an elaboration error for display *)
let format_elab_error msg loc =
  Printf.sprintf "%s: %s" (string_of_loc loc) msg

(** Variable identifier *)
type variable = string

(** Symbol kinds *)
type sym_kind =
  | SymInput    (** Input port (wire) *)
  | SymOutput   (** Output port (wire) *)
  | SymWire     (** Internal wire *)
  | SymReg      (** Register *)

(** Symbol table entry *)
type symbol = {
  sym_name: variable;
  sym_kind: sym_kind;
  sym_width: int;           (** Resolved width, must be > 0 *)
  sym_loc: loc;             (** Declaration location *)
}

(** Width-annotated elaborated expressions *)
type eexpr =
  | EEVar of variable * int                           (** Variable reference with width *)
  | EEConst of int * int                              (** Constant value and width *)
  | EEUnop of unop * eexpr * int                      (** Unary op with result width *)
  | EEBinop of binop * eexpr * eexpr * int            (** Binary op with result width *)
  | EETernary of eexpr * eexpr * eexpr * int          (** Ternary with result width *)
  | EEConcat of eexpr list * int                      (** Concat with total width *)
  | EEIndex of eexpr * eexpr * int                    (** Bit select (width = 1) *)
  | EESlice of eexpr * int * int * int                (** Part select with const bounds and width *)

(** Get width of an elaborated expression *)
let eexpr_width = function
  | EEVar (_, w) -> w
  | EEConst (_, w) -> w
  | EEUnop (_, _, w) -> w
  | EEBinop (_, _, _, w) -> w
  | EETernary (_, _, _, w) -> w
  | EEConcat (_, w) -> w
  | EEIndex (_, _, w) -> w
  | EESlice (_, _, _, w) -> w

(** Elaborated lvalue *)
type elvalue =
  | ELVar of variable * int                           (** Full variable *)
  | ELIndex of variable * eexpr * int                 (** Bit select *)
  | ELSlice of variable * int * int * int             (** Part select with const bounds *)

(** Get the target variable of an lvalue *)
let elvalue_var = function
  | ELVar (v, _) -> v
  | ELIndex (v, _, _) -> v
  | ELSlice (v, _, _, _) -> v

(** Definition kinds in the elaborated IR *)
type def_kind =
  | DefInput    (** Input port - no RHS, source only *)
  | DefNet      (** Combinational net - has RHS *)
  | DefReg      (** Register - has RHS (next-state expression) *)

(** A definition in the elaborated IR *)
type defn = {
  def_name: variable;
  def_width: int;
  def_rhs: eexpr option;    (** None for inputs *)
  def_kind: def_kind;
  def_loc: loc;             (** Source location *)
}

(** Elaborated module *)
type elaborated_module = {
  elab_name: string;
  elab_inputs: defn list;       (** Input definitions *)
  elab_nets: defn list;         (** Combinational net definitions *)
  elab_regs: defn list;         (** Register definitions with next-state RHS *)
  elab_outputs: variable list;  (** Output variable names *)
}

(** Symbol table *)
module SymbolTable = Map.Make(String)
type symtab = symbol SymbolTable.t

(** Driver tracking: maps variable name to assignment location *)
module DriverMap = Map.Make(String)
type drivers = loc DriverMap.t
