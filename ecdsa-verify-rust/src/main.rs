extern crate num_bigint;
extern crate num_traits;
use num_bigint::BigInt;
use num_traits::identities::{One, Zero};

fn modular_inverse(a: &BigInt, n: &BigInt) -> Option<BigInt> {
    if n == &BigInt::zero() || n == &BigInt::one() {
        return None;
    }
    let (mut t, mut newt) = (BigInt::zero(), BigInt::one());
    let (mut r, mut newr) = (n.clone(), a.clone());
    while newr != BigInt::zero() {
        let quotient = r.clone() / newr.clone();
        (t, newt) = (newt.clone(), t - &quotient * newt);
        (r, newr) = (newr.clone(), r - &quotient * newr);
    }
    if r > BigInt::one() {
        return None;
    }
    if t < BigInt::zero() {
        t = t + n;
    }
    Some(t)
}

fn main() {
    use std::env;

    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        println!("Expected two hexadecimal strings as arguments");
        return;
    }

    let a = BigInt::parse_bytes(&args[1].as_bytes(), 16).unwrap();
    let n = BigInt::parse_bytes(&args[2].as_bytes(), 16).unwrap();

    let result = modular_inverse(&a, &n);
    match result {
        Some(x) => println!("{:x}", x),
        None => println!("No inverse exists for the given values")
    }
}

#[cfg(test)]
mod tests {
    use crate::modular_inverse;
    extern crate num_bigint;
    use num_bigint::BigInt;
    use num_traits::identities::{One, Zero};
    
    #[test]
    fn test_modular_inverse() {
        // Test that the modular inverse of a number is correct
        let a = BigInt::parse_bytes(b"69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", 16).unwrap();
        let n = BigInt::parse_bytes(b"fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", 16).unwrap();
        let expected_result = BigInt::parse_bytes(b"321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", 16);
        let result = modular_inverse(&a, &n);
        assert_eq!(result, expected_result);
    }

    #[test]
    fn test_modular_no_inverse() {
        // Test that the function returns None when there is no inverse
        let a = BigInt::from(4);
        let mut n = BigInt::from(6);
        let expected_result = None;
        let mut result = modular_inverse(&a, &n);
        assert_eq!(result, expected_result);
        // Test that the function returns None when n=0
        n = BigInt::zero();
        result = modular_inverse(&a, &n);
        assert_eq!(result, expected_result);
        // Test that the function returns None when n=1
        n = BigInt::one();
        result = modular_inverse(&a, &n);
        assert_eq!(result, expected_result);
    }
}
