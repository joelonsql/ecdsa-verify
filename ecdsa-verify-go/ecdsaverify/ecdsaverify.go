package ecdsaverify

import (
	"fmt"
	"math/big"
)

func ModularInverse(a, n *big.Int) (*big.Int, error) {
	if n.Cmp(big.NewInt(0)) == 0 || n.Cmp(big.NewInt(1)) == 0 {
		return nil, fmt.Errorf("inverse does not exist")
	}
	t := big.NewInt(0)
	newT := big.NewInt(1)
	r := new(big.Int).Set(n)
	newR := new(big.Int).Set(a)
	for newR.Cmp(big.NewInt(0)) == 1 {
		quotient := new(big.Int).Div(r, newR)
		t, newT = newT, new(big.Int).Sub(t, new(big.Int).Mul(quotient, newT))
		r, newR = newR, new(big.Int).Sub(r, new(big.Int).Mul(quotient, newR))
	}
	if r.Cmp(big.NewInt(1)) == 1 {
		return nil, fmt.Errorf("inverse does not exist")
	}
	if t.Cmp(big.NewInt(0)) == -1 {
		t = t.Add(t, n)
	}
	return t, nil
}
