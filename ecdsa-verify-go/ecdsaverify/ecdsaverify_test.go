package ecdsaverify

import (
	"math/big"
    "testing"
)

func TestModularInverse(t *testing.T) {
    // Test that the modular inverse of a number is correct
    a, _ := new(big.Int).SetString("69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", 16)
    n, _ := new(big.Int).SetString("fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", 16)
    expectedResult, _ := new(big.Int).SetString("321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", 16)
    result, err := ModularInverse(a, n)
    if err != nil {
        t.Errorf("Unexpected error: %v", err)
    }
    if result.Cmp(expectedResult) != 0 {
        t.Errorf("Wrong result. Expected %x, got %x", expectedResult, result)
    }
}

func TestModularNoInverse(t *testing.T) {
    // Test that the function returns an error when there is no inverse
    a := big.NewInt(4)
    n := big.NewInt(6)
    if _, err := ModularInverse(a, n); err == nil {
        t.Errorf("Expected error but got none")
    }
    // Test that the function returns an error when n=0
    n = big.NewInt(0)
    if _, err := ModularInverse(a, n); err == nil {
        t.Errorf("Expected error but got none")
    }
    // Test that the function returns an error when n=1
    n = big.NewInt(1)
    if _, err := ModularInverse(a, n); err == nil {
        t.Errorf("Expected error but got none")
    }
}
