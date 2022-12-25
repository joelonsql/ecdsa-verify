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
        var tmp = t;
        t = newt;
        newt = tmp - quotient * newt;
        tmp = r;
        r = newr;
        newr = tmp - quotient * newr;
    }
    if (r > BigInt.one) {
        return null;
    }
    if (t < BigInt.zero) {
        t += n;
    }
    return t;
}
