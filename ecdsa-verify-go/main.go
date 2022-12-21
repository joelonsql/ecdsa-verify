package main

import (
	"fmt"
	"math/big"
	"os"
	"ecdsaverify"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Expected two hexadecimal strings as arguments")
		return
	}
	a, _ := new(big.Int).SetString(os.Args[1], 16)
	n, _ := new(big.Int).SetString(os.Args[2], 16)
	result, err := ecdsaverify.ModularInverse(a, n)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("%x\n", result)
}
