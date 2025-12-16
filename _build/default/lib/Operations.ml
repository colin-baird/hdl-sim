(*
type arithmetic = 
  | Plus
  | Minus
  | Mul
  | Div
  | Mod
  | Pow

type unary = 
  | Plus
  | Minus

type bitwise = 
  | B_And
  | B_Or
  | B_Xor
  | B_Nand
  | B_Nor
  | B_Xnor
  | B_not

type reduction = 
  | R_And
  | R_Nand
  | R_Or
  | R_Nor
  | R_Xor
  | R_Xnor

type logical = 
  | L_Not
  | L_And
  | L_Or

type relational = 
  | Less
  | Leq
  | Greater
  | Geq

type equality = 
  | Equal
  | Nequal

type shift = 
  | Lsl
  | Lsr
  | Asl
  | Asr

type concat = 
  | Concat
  | Replicate
*)
type operator = 
  (* Arithmetic *)
  | Plus | Minus | Mul | Div | Mod | Pow
  (* Bitwise *)
  | Band | Bor | Bxor | Bnand | Bnor | Bxnor | Bnot
  (* Logical *)
  | Lnot | Land | Lor
  (* Comparison *)
  | Less | Leq | Greater | Geq  | Equal | Nequal
  (* Shift <<< and >>> not implemented*)
  | Lsl | Lsr
  | Passthrough
  (* Ternary separate in AST*)
  (* Concat separate in AST, Replicate not implemented*)
  (* Reduction not implemented*)