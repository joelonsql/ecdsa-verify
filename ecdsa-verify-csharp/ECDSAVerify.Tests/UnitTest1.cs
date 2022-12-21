using System.Numerics;

namespace ECDSAVerify.Tests
{
    public class ECDSAVerifyTests
    {
        [Fact]
        public void TestModularInverse()
        {
            // Test that the modular inverse of a number is correct
            BigInteger a = BigInteger.Parse("0" + "69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", System.Globalization.NumberStyles.HexNumber);
            BigInteger n = BigInteger.Parse("0" + "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", System.Globalization.NumberStyles.HexNumber);
            BigInteger expectedResult = BigInteger.Parse("0" + "321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", System.Globalization.NumberStyles.HexNumber);
            BigInteger? result = ECDSAVerify.ModularInverse(a, n);
            Assert.Equal(expectedResult, result);
        }

        [Fact]
        public void TestModularNoInverse()
        {
            // Test that the function returns None when there is no inverse
            BigInteger a = 4;
            BigInteger n = 6;
            BigInteger? expectedResult = null;
            BigInteger? result = ECDSAVerify.ModularInverse(a, n);
            Assert.Equal(expectedResult, result);

            // Test that the function returns None when n=0
            n = BigInteger.Zero;
            expectedResult = null;
            result = ECDSAVerify.ModularInverse(a, n);
            Assert.Equal(expectedResult, result);

            // Test that the function returns None when n=1
            n = BigInteger.One;
            expectedResult = null;
            result = ECDSAVerify.ModularInverse(a, n);
            Assert.Equal(expectedResult, result);
        }
    }
}

