defmodule EcdsaVerify.CLI do
  import EcdsaVerify
  @moduledoc """
  A command-line interface for the EcdsaVerify module.
  """
  @doc """
  Processes command-line arguments and prints the modular inverse of the first
  argument modulo the second argument, or a message indicating that no such
  inverse exists.
  """
  def main(args) do
    case args do
      [a_hex, n_hex] ->
        a = String.to_integer(a_hex, 16)
        n = String.to_integer(n_hex, 16)
        result = modular_inverse(a, n)
        case result do
          nil ->
            IO.puts("No modular inverse exists")
            1
          _ ->
            IO.puts(String.downcase(Integer.to_string(result, 16)))
            0
        end
      _ ->
        IO.puts("Expected two hexadecimal strings as arguments")
        1
    end
  end
end
