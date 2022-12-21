import 'ecdsa_verify.dart';
import 'package:test/test.dart';
import 'dart:math';

void main(List<String> args) {
    if (args.length != 2) {
        print("Expected two hexadecimal strings as arguments");
        return;
    }

    BigInt a = BigInt.parse(args[0], radix: 16);
    BigInt n = BigInt.parse(args[1], radix: 16);

    BigInt? result = modularInverse(a, n);
    if (result == null) {
        print("No inverse exists for the given values");
    } else {
        print(result.toRadixString(16));
    }
}

