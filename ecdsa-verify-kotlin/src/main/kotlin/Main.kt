import java.math.BigInteger
import java.math.BigInteger.ZERO
import java.math.BigInteger.ONE

fun modularInverse(a: BigInteger, n: BigInteger): BigInteger? {

    if (n == ZERO || n == ONE) {
        return null
    }

    var (t, newt) = Pair(ZERO, ONE)
    var (r, newr) = Pair(n, a)

    while (newr != ZERO) {
        val quotient = r / newr
        var tmp = t
        t = newt
        newt = tmp - quotient * newt
        tmp = r
        r = newr
        newr = tmp - quotient * newr
    }

    if (r > ONE) {
        return null
    }

    if (t < ZERO) {
        t = t + n
    }

    return t

}

fun main(args: Array<String>) {

    test()

    if (args.size != 2) {
        print("Expected two hexadecimal strings as arguments")
        return
    }

    val a = BigInteger(args[0], 16)
    val n = BigInteger(args[1], 16)

    val result = modularInverse(a, n);
    if (result != null) {
        print(result.toString(16))
    } else {
        print("No inverse exists for the given values")
    }

}

fun test() {

    // Test that the modular inverse of a number is correct
    var a = BigInteger("69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", 16)
    var n = BigInteger("fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", 16)
    var expectedResult: BigInteger? = BigInteger("321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", 16)
    var result: BigInteger? = modularInverse(a, n)
    assert(result == expectedResult)

    // Test that the function returns None when there is no inverse
    a = BigInteger.valueOf(4)
    n = BigInteger.valueOf(6)
    expectedResult = null
    result = modularInverse(a, n)
    assert(result == expectedResult)

    // Test that the function returns None when n=0
    n = ZERO
    result = modularInverse(a, n)
    assert(result == expectedResult)

    // Test that the function returns None when n=1
    n = ONE
    result = modularInverse(a, n)
    assert(result == expectedResult)

}