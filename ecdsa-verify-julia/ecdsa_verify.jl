module ECDSAVerify
    export modular_inverse
    using Base.GMP
    function modular_inverse(a::GMP.BigInt, n::GMP.BigInt)
        if n == GMP.BigInt(0) || n == GMP.BigInt(1)
            return nothing
        end
        t = GMP.BigInt(0)
        newt = GMP.BigInt(1)
        r = deepcopy(n)
        newr = deepcopy(a)
        while newr != GMP.BigInt(0)
            quotient = r ÷ newr
            t, newt = newt, t - quotient * newt
            r, newr = newr, r - quotient * newr
        end
        if r > GMP.BigInt(1)
            return nothing
        end
        if t < GMP.BigInt(0)
            t = t + n
        end
        return t
    end
end
