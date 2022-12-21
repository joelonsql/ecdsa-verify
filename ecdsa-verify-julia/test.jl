include("ecdsa_verify.jl")
using Test
using .ECDSAVerify
using Base.GMP

function test_modular_inverse()
    # Test that the modular inverse of a number is correct
    a = parse(GMP.BigInt, "69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", base=16)
    n = parse(GMP.BigInt, "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", base=16)
    expected_result = parse(GMP.BigInt, "321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", base=16)
    result = modular_inverse(a, n)
    @test result == expected_result
end

function test_modular_no_inverse()
    # Test that the function returns nothing when there is no inverse
    a = GMP.BigInt(4)
    n = GMP.BigInt(6)
    result = modular_inverse(a, n)
    @test result == nothing
    # Test that the function returns nothing when n=0
    n = GMP.BigInt(0)
    result = modular_inverse(a, n)
    @test result == nothing
    # Test that the function returns nothing when n=1
    n = GMP.BigInt(1)
    result = modular_inverse(a, n)
    @test result == nothing
end

# Run tests
@testset "ecdsa_verify tests" begin
    test_modular_inverse()
    test_modular_no_inverse()
end
