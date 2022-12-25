defmodule EcdsaVerify do
  @doc """
  Calculates the modular inverse of `a` modulo `n`, or `nil` if no such inverse exists.
  """
  @spec modular_inverse(a :: integer, n :: integer) :: nil | integer
  def modular_inverse(a, n) do
    case n do
      0 -> nil
      1 -> nil
      _ ->
        loop = fn t, newt, r, newr, recur ->
          case newr do
            0 ->
              case r > 1 do
                true -> nil
                false ->
                  case t < 0 do
                    true -> t + n
                    false -> t
                  end
              end
            _ ->
              quotient = Integer.floor_div(r, newr)
              recur.(newt, t - quotient * newt, newr, r - quotient * newr, recur)
          end
        end

        t = 0
        newt = 1
        r = n
        newr = a
        loop.(t, newt, r, newr, loop)
    end
  end
end
