include("ecdsa_verify.jl")
using .ECDSAVerify
using Base.GMP

if length(ARGS) != 2
    println("Expected two hexadecimal strings as arguments")
    exit(1)
end

a = GMP.BigInt(parse(GMP.BigInt, ARGS[1], base=16))
n = GMP.BigInt(parse(GMP.BigInt, ARGS[2], base=16))
result = modular_inverse(a, n)
if result == nothing
    println("No inverse exists for the given values")
else
    println(string(result,base=16))
end

