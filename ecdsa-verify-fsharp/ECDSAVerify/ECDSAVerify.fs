namespace ECDSAVerify

open System
open System.Numerics

type ECDSAVerify = 
    static member ModularInverse(a: BigInteger, n: BigInteger) = 
        if n = BigInteger.Zero || n = BigInteger.One then
            None
        else
            let rec loop t newt r newr =
                if newr = BigInteger.Zero then
                    if r > BigInteger.One then
                        None
                    else
                        if t < BigInteger.Zero then
                            Some (t + n)
                        else
                            Some t
                else
                    let quotient = r / newr
                    loop newt (t - quotient * newt) newr (r - quotient * newr)
            loop BigInteger.Zero BigInteger.One n a
