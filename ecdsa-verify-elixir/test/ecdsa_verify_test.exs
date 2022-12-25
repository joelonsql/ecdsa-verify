defmodule EcdsaVerifyTest do
  use ExUnit.Case
  doctest EcdsaVerify
  import EcdsaVerify

  test "modular_inverse returns the correct modular inverse" do
    a = String.to_integer("69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", 16)
    n = String.to_integer("fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", 16)
    expected_result = String.to_integer("321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", 16)
    result = modular_inverse(a, n)
    assert result == expected_result
  end

  test "modular_inverse returns nil when there is no inverse" do
    a = 4
    n = 6
    expected_result = nil
    result = modular_inverse(a, n)
    assert result == expected_result
  end

  test "modular_inverse returns nil when n=0" do
    a = 4
    n = 0
    expected_result = nil
    result = modular_inverse(a, n)
    assert result == expected_result
  end

  test "modular_inverse returns nil when n=1" do
    a = 4
    n = 1
    expected_result = nil
    result = modular_inverse(a, n)
    assert result == expected_result
  end
end
