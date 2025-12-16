open Graph
open EvalEnv

(* VCD file generation module *)

let vec_to_vcd_string (v: vector) : string =
  let bits = List.rev v |> List.map (fun b -> if b then '1' else '0') in
  String.init (List.length bits) (List.nth bits)

let generate_vcd_header (out: out_channel) (named_nodes: (string * node) list) (timescale: string) : unit =
  Printf.fprintf out "$timescale %s $end\n" timescale;
  Printf.fprintf out "$scope module top $end\n";
  (* Add clock signal *)
  Printf.fprintf out "$var wire 1 clk clk $end\n";

  (* Identify register output IDs to distinguish them from circuit inputs *)
  let reg_output_ids = List.fold_left (fun acc (_, node) ->
    match node.reg_next with
    | Some id -> id :: acc
    | None -> acc
  ) [] named_nodes in

  List.iter (fun (name, node) ->
    let is_real_input = node.is_src && not (List.mem node.output reg_output_ids) in
    let signal_type = if node.is_reg then "reg" else "wire" in
    let signal_name = 
      if is_real_input then name ^ "_input"
      else name
    in
    Printf.fprintf out "$var %s %d %s %s $end\n" signal_type node.width name signal_name
  ) named_nodes;
  Printf.fprintf out "$upscope $end\n";
  Printf.fprintf out "$enddefinitions $end\n";
  Printf.fprintf out "$dumpvars\n";
  (* Initialize clock to 0 *)
  Printf.fprintf out "0clk\n";
  List.iter (fun (name, node) ->
    let init_val = String.make node.width '0' in
    if node.width = 1 then
      Printf.fprintf out "%s%s\n" init_val name
    else
      Printf.fprintf out "b%s %s\n" init_val name
  ) named_nodes;
  Printf.fprintf out "$end\n"

let write_vcd_cycle (out: out_channel) (cycle: int) (named_nodes: (string * node) list) (state: wires) : unit =
  (* Each cycle represents a clock period with rising and falling edges *)
  let time_base = cycle * 2 in
  
  (* Rising edge - clock goes high, values update *)
  Printf.fprintf out "#%d\n" time_base;
  Printf.fprintf out "1clk\n";
  List.iter (fun (name, node) ->
    match Graph_m.find_opt node.output state with
    | Some v ->
        let vcd_val = vec_to_vcd_string v in
        if node.width = 1 then
          Printf.fprintf out "%s%s\n" vcd_val name
        else
          Printf.fprintf out "b%s %s\n" vcd_val name
    | None -> ()
  ) named_nodes;
  
  (* Falling edge - clock goes low, values remain stable *)
  Printf.fprintf out "#%d\n" (time_base + 1);
  Printf.fprintf out "0clk\n"

(* Helper to get named nodes from a compiled circuit *)
let get_named_nodes (sorted_nodes: node list) : (string * node) list =
  List.filter_map (fun node ->
    match node.name with
    | Some name -> Some (name, node)
    | None -> None
  ) sorted_nodes

(* Run simulation with VCD output *)
let run_with_vcd (circuit: Ast.exp) (num_cycles: int) (vcd_filename: string) 
    (get_inputs: int -> (string * vector) list) 
    ?(console_output=true) () : unit =
  
  (* Compile circuit to get named nodes *)
  let sorted_nodes = compile_circuit circuit in
  let named_nodes = get_named_nodes sorted_nodes in
  
  (* Identify register output IDs *)
  let reg_output_ids = List.fold_left (fun acc (_, node) ->
    match node.reg_next with
    | Some id -> id :: acc
    | None -> acc
  ) [] named_nodes in

  if console_output then begin
    Printf.printf "Circuit compiled with %d named signals:\n" (List.length named_nodes);
    List.iter (fun (name, node) -> 
      let is_real_input = node.is_src && not (List.mem node.output reg_output_ids) in
      let signal_type = if node.is_reg then "reg" else if is_real_input then "input" else "wire" in
      Printf.printf "  %s [%s, width=%d]\n" name signal_type node.width
    ) named_nodes;
    Printf.printf "\n"
  end;
  
  (* Open VCD file *)
  let vcd_file = open_out vcd_filename in
  generate_vcd_header vcd_file named_nodes "1ns";
  
  (* Output processor: write to VCD *)
  let process_output cycle state =
    write_vcd_cycle vcd_file cycle named_nodes state;
    if console_output then begin
      Printf.printf "Cycle %2d: " cycle;
      List.iter (fun (name, node) ->
        match Graph_m.find_opt node.output state with
        | Some v -> Printf.printf "%s=%d " name (vec_to_int v)
        | None -> Printf.printf "%s=? " name
      ) named_nodes;
      Printf.printf "\n"
    end
  in
  
  run_simulation circuit num_cycles get_inputs process_output;
  
  close_out vcd_file;
  Printf.printf "\nVCD file written to %s\n" vcd_filename
