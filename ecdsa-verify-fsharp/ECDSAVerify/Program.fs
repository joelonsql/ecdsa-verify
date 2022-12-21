open System
open System.Numerics
open System.Globalization
open ECDSAVerify

[<EntryPoint>]
let main (args : string[]) =
    if args.Length <> 2 then
        printfn "Expected two hexadecimal strings as arguments"
    else
        let a = BigInteger.Parse("0" + args.[0], NumberStyles.HexNumber)
        let n = BigInteger.Parse("0" + args.[1], NumberStyles.HexNumber)
        let result = ECDSAVerify.ECDSAVerify.ModularInverse(a, n)
        match result with
        | Some x ->
            printfn "%s" (x.ToString("x"))
        | None -> printfn "No inverse exists for the given values"
    0