#!/usr/bin/env python3
#
# The ECDSA code in this file has been extracted from the ecdsa-python [1]
# Python3 project developed by Stark Bank S.A. [2]
#
# [1] https://github.com/starkbank/ecdsa-python
# [2] https://starkbank.com/
#

def modular_inverse(a, n):
    if n == 0 or n == 1:
        return None
    t, newt = 0, 1
    r, newr = n, a
    while newr != 0:
        quotient = r // newr
        t, newt = newt, t - quotient * newt
        r, newr = newr, r - quotient * newr
    if r > 1:
        return None
    if t < 0:
        t += n
    return t
