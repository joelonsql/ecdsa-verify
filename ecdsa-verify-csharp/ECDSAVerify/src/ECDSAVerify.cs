using System;
using System.Linq;
using System.Numerics;

namespace ECDSAVerify
{
    public static class ECDSAVerify
    {
        public static BigInteger? ModularInverse(BigInteger a, BigInteger n)
        {
            if (n == BigInteger.Zero || n == BigInteger.One)
            {
                return null;
            }

            BigInteger t = BigInteger.Zero;
            BigInteger newt = BigInteger.One;
            BigInteger r = n;
            BigInteger newr = a;
            while (newr != BigInteger.Zero)
            {
                BigInteger quotient = r / newr;
                (t, newt) = (newt, t - quotient * newt);
                (r, newr) = (newr, r - quotient * newr);
            }

            if (r > BigInteger.One)
            {
                return null;
            }

            if (t < BigInteger.Zero)
            {
                t = t + n;
            }

            return t;
        }
    }
}