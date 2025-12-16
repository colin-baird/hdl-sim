(** Parse: Wrapper for lexer and parser. *)

open Ptree

(** Parse a Verilog module from a string.
    @param filename Optional filename for error messages (default: "<string>")
    @param input The Verilog source code
    @return The parsed module
    @raise Parse_error on syntax errors *)
val parse_string : ?filename:string -> string -> vmodule

(** Parse a Verilog module from a file.
    @param filename Path to the Verilog file
    @return The parsed module
    @raise Parse_error on syntax errors *)
val parse_file : string -> vmodule

(** Format a parse error for display.
    @param msg The error message
    @param loc The error location
    @return A formatted error string *)
val format_error : string -> loc -> string
