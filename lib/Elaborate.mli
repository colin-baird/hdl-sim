(** Elaborate: Main elaboration pass for Verilog parse tree. *)

open Ptree
open Elab_ir

(** Elaborate a parsed module into the IR.
    
    Performs:
    - Symbol resolution and duplicate detection
    - Width inference and checking
    - Lvalue validation
    - Separation of combinational and sequential logic
    - Dependency graph construction
    - Combinational cycle detection
    
    @param m The parsed Verilog module
    @return The elaborated module IR
    @raise Elab_error on semantic errors *)
val elaborate : vmodule -> elaborated_module
