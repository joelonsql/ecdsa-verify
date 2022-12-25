open Printf
open Big_int

let () =
  let args = Sys.argv in
  if Array.length args <> 3 then
    (printf "Expected two hexadecimal strings as arguments\n"; exit 0)
  else
    let a_hex = args.(1) in
    let n_hex = args.(2) in
    let a = big_int_of_string a_hex in
    let n = big_int_of_string n_hex in
    match Ecdsa_verify.modular_inverse a n with
    | Some x -> printf "%s\n" (BatBig_int.to_string_in_hexa x)
    | None -> printf "No inverse exists for the given values\n"
