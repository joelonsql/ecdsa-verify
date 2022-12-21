const assert = require('assert');
const ECDSAVerify = require("./ecdsa_verify");

// Test that the modular inverse of a number is correct
let a = BigInt("0x69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057");
let n = BigInt("0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141");
let expectedResult = BigInt("0x321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0");
let result = ECDSAVerify.modularInverse(a, n);
assert.strictEqual(result, expectedResult);

// Test that the function returns null when there is no inverse
a = 4n;
n = 6n;
expectedResult = null;
result = ECDSAVerify.modularInverse(a, n);
assert.strictEqual(result, expectedResult);

// Test that the function returns null when n = 0
n = 0n;
result = ECDSAVerify.modularInverse(a, n);
assert.strictEqual(result, expectedResult);

// Test that the function returns null when n = 1
n = 1n;
result = ECDSAVerify.modularInverse(a, n);
assert.strictEqual(result, expectedResult);
