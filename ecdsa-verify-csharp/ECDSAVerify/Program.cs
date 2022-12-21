using System;
using System.Linq;
using System.Numerics;
using ECDSAVerify;

namespace ECDSAVerify
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine("Expected two hexadecimal strings as arguments");
                return;
            }

            BigInteger a = BigInteger.Parse("0" + args[0], System.Globalization.NumberStyles.HexNumber);
            BigInteger n = BigInteger.Parse("0" + args[1], System.Globalization.NumberStyles.HexNumber);

            BigInteger? result = ECDSAVerify.ModularInverse(a, n);
            if (result.HasValue)
            {
                Console.WriteLine(result.Value.ToString("x"));
            }
            else
            {
                Console.WriteLine("No inverse exists for the given values");
            }
        }
    }
}