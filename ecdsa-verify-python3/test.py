#!/usr/bin/env python3
import unittest

from ecdsa_verify import *

class TestECDSAVerify(unittest.TestCase):

    def test_modular_inverse(self):
        # Test that the modular inverse of a number is correct
        a = int("69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", 16)
        n = int("fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", 16)
        expected_result = int("321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", 16)
        result = modular_inverse(a, n)
        self.assertEqual(result, expected_result)

    def test_modular_no_inverse(self):
        # Test that the function returns None when there is no inverse
        a = 4
        n = 6
        expected_result = None
        result = modular_inverse(a, n)
        self.assertEqual(result, expected_result)
        # Test that the function returns None when n=0
        n = 0
        result = modular_inverse(a, n)
        self.assertEqual(result, expected_result)
        # Test that the function returns None when n=1
        n = 1
        result = modular_inverse(a, n)
        self.assertEqual(result, expected_result)

if __name__ == '__main__':
    unittest.main()