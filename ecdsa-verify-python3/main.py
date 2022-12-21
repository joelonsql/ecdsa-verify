import sys
from ecdsa_verify import *

def main():
    if len(sys.argv) != 3:
        print("Expected two hexadecimal strings as arguments")
        return
    a = int(sys.argv[1], 16)
    n = int(sys.argv[2], 16)
    result = modular_inverse(a, n)
    if result != None:
        print(hex(result))
    else:
        print("No inverse exists for the given values")

if __name__ == "__main__":
    main()
