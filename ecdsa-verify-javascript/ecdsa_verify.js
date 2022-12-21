function modularInverse(a, n) {
    if (n == 0n || n == 1n) {
        return null;
    }
    let t = 0n;
    let newt = 1n;
    let r = n;
    let newr = a;

    while (newr != 0n) {
        const quotient = r / newr;
        [t, newt] = [newt, t - quotient * newt];
        [r, newr] = [newr, r - quotient * newr];
    }
    if (r > 1n) {
        return null;
    }
    if (t < 0n) {
        t += n;
    }
    return t;
}

module.exports = {
    modularInverse: modularInverse
}
