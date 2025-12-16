(** AstConv: Convert elaborated IR to the AST format.
    
    This module lowers the elaborated IR to the final AST representation,
    performing topological ordering so that definitions appear after
    their dependencies.
*)

(** Conversion error *)
exception Conv_error of string

(** Lower an elaborated module to the AST format.
    
    Performs topological sorting to ensure definitions appear after
    their dependencies in the let-binding chain.
    
    @raise Conv_error if a cycle is detected in the dependency graph *)
val lower : Elab_ir.elaborated_module -> Ast.exp

(** Pretty-print an AST expression for debugging *)
val pp_exp : int -> Ast.exp -> string
