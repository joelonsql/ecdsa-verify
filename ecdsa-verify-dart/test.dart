import 'ecdsa_verify.dart';
import 'package:test/test.dart';
import 'dart:math';

void main() {
    group('Modular Inverse Tests', () {
        test('Test that the modular inverse of a number is correct', () {
            BigInt a = BigInt.parse('69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057', radix: 16);
            BigInt n = BigInt.parse('fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141', radix: 16);
            BigInt expectedResult = BigInt.parse('321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0', radix: 16);
            expect(modularInverse(a, n), expectedResult);
        });

        test('Test that the function returns null when there is no inverse', () {
            BigInt a = BigInt.from(4);
            BigInt n = BigInt.from(6);
            expect(modularInverse(a, n), isNull);
            n = BigInt.zero;
            expect(modularInverse(a, n), isNull);
            n = BigInt.one;
            expect(modularInverse(a, n), isNull);
        });
    });
}

