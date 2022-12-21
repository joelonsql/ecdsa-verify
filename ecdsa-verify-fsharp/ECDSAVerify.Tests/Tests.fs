module Tests

open System
open System.Numerics
open System.Globalization
open Xunit
open ECDSAVerify

[<Fact>]
let ``test modular inverse``() =
    // Test that the modular inverse of a number is correct
    let a = BigInteger.Parse("0" + "69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", NumberStyles.HexNumber)
    let n = BigInteger.Parse("0" + "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", NumberStyles.HexNumber)
    let expectedResult = BigInteger.Parse("0" + "321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", NumberStyles.HexNumber)
    let result = ECDSAVerify.ModularInverse(a, n)
    Assert.Equal(Some(expectedResult), result)

[<Fact>]
let ``test modular no inverse``() =
    // Test that the function returns None when there is no inverse
    let a = 4
    let n = 6
    let expectedResult = None
    let result = ECDSAVerify.ModularInverse(a, n)
    Assert.Equal(expectedResult, result)
    // Test that the function returns None when n=0
    let n = BigInteger.Zero
    let result = ECDSAVerify.ModularInverse(a, n)
    Assert.Equal(expectedResult, result)
    // Test that the function returns None when n=1
    let n = BigInteger.One
    let result = ECDSAVerify.ModularInverse(a, n)
    Assert.Equal(expectedResult, result)