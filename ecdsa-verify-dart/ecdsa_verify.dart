export 'ecdsa_verify.dart';

import 'dart:math';

BigInt? modularInverse(BigInt a, BigInt n) {
    if (n == BigInt.zero || n == BigInt.one) {
        return null;
    }
    BigInt t = BigInt.zero;
    BigInt newt = BigInt.one;
    BigInt r = n;
    BigInt newr = a;
    while (newr != BigInt.zero) {
        BigInt quotient = r ~/ newr;
        var tmp1 = t;
        t = newt;
        newt = tmp1 - quotient * newt;
        var tmp2 = r;
        r = newr;
        newr = tmp2 - quotient * newr;
    }
    if (r > BigInt.one) {
        return null;
    }
    if (t < BigInt.zero) {
        t += n;
    }
    return t;
}
