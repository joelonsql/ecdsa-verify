def modular_inverse(a, n)
    return nil if n == 0 || n == 1

    t, newt = 0, 1
    r, newr = n.clone, a.clone
    while newr != 0
        quotient = r / newr
        t, newt = newt, t - quotient * newt
        r, newr = newr, r - quotient * newr
    end

    return nil if r > 1
    t += n if t < 0

    t
end
