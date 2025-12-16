open Operations

type variable = string
type vector = bool list
type width = int

(* Equality and Inequality for variables *)
let var_eq x y = (String.compare x y = 0)
let var_neq x y = not (String.compare x y = 0)


(* AST needs to model continuous and synchronous assignment, and it needs inputs and outputs 
   I then need to build the funcitonality of converting an AST into a graph that can be topo sorted
   I think I should store register values in a map outside of the AST and then these will all be initialized as nodes at the top of the topo sorted graph. On each cycle I need to recursively traverse the DAG and compute each value 
   Maybe registers get turned into two types of nodes in the ast, input side for whome evaluation is latching a new value, and output side that is a source for other logic. 
*)

(* All Vars need to be bound to a const or an expression *)
type exp = 
  | Input of variable * width * exp (* def variable with width, next statement is exp *)
  | Net_let of variable * width * exp * exp (* def variable with exp1, next statement is exp2*)
  | Reg_let of variable * width * exp * exp (* def variable with exp1, next statement is exp2*)
  | Const of vector
  | Var of variable
  | Binop of operator * exp * exp
  | Unop of operator * exp
  | Ternary of exp * exp * exp (* if exp1 then exp2 else exp3*)
  | Concat of exp list (*{list[i], list[i+1],...}*)
  | Index of exp * exp (* a[i] *)
  | Slice of exp * vector * vector (* a[msb:lsb]*)

type node = Graph.node
type env = (variable * node) list

(*****************************)
(* Manipulating environments *)
(*****************************)
 
(* empty environment *)
let empty_env : env = []

(* lookup_env env x == Some v 
 *   where (x,v) is the most recently added pair (x,v) containing x
 * lookup_env env x == None 
 *   if x does not appear in env *)
let rec lookup_env (env:env) (x:variable) : node option =
  match env with 
    | [] -> None
    | (var,v)::tl -> if var_eq var x then Some v else lookup_env tl x

(* update env x v returns a new env containing the pair (x,v) 
 * The exact operation (replacing, overriding, etc.) is up to 
 * you, but clearly your other functions (notably lookup_env) 
 * must know the semantics of update_env
*)
let update_env (env:env) (x:variable) (v:node) : env = 
  let rec replace (env:env) (x:variable) (v:node) (new_env:env) (found:bool) : env = 
    match env with
      | [] -> if found then new_env else (x,v)::new_env
      | (var,value)::tl -> 
        if var_eq var x then 
          replace tl x v ((x,v)::new_env) true
        else 
          replace tl x v ((var,value)::new_env) found
  in
  replace env x v [] false
