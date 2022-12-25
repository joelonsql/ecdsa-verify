open Big_int

let modular_inverse a n =
  let one_big_int = big_int_of_int 1 in
  if eq_big_int n zero_big_int || eq_big_int n one_big_int then None
  else
    let rec loop t newt r newr =
      if eq_big_int newr zero_big_int then
        if gt_big_int r one_big_int then None
        else Some (if lt_big_int t zero_big_int then add_big_int t n else t)
      else
        let quotient = div_big_int r newr in
        loop newt (sub_big_int t (mult_big_int quotient newt)) newr (sub_big_int r (mult_big_int quotient newr))
    in
    let (t, newt) = (zero_big_int, one_big_int) in
    let (r, newr) = (n, a) in
    loop t newt r newr

let%test_module "modular inverse" = (module struct
  let a = big_int_of_string "0x69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057"
  let n = big_int_of_string "0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
  let expected_result = big_int_of_string "0x321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0"
  let four_big_int = big_int_of_int 4
  let six_big_int = big_int_of_int 6
  let one_big_int = big_int_of_int 1
  let%test "correct modular inverse" =
    match modular_inverse a n with
    | Some x -> eq_big_int x expected_result
    | None -> false
  let%test "no modular inverse" = modular_inverse four_big_int six_big_int = None
  let%test "no modular inverse when n=0" = modular_inverse four_big_int zero_big_int = None
  let%test "no modular inverse when n=1" = modular_inverse four_big_int one_big_int = None
end)
