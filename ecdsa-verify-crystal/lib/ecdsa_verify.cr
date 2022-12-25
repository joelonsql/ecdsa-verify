require "big"

module EcdsaVerify

  def modular_inverse(a : BigInt, n : BigInt) : BigInt?
    return nil if n == 0 || n == 1

    t, newt = BigInt.new(0), BigInt.new(1)
    r, newr = n.clone, a.clone
    while newr != 0
      quotient, _ = r.unsafe_floored_divmod(newr)
      t, newt = newt, t - quotient * newt
      r, newr = newr, r - quotient * newr
    end

    return nil if r > 1
    t += n if t < 0

    return t
  end

end