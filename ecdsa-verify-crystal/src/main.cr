require "big"
require "ecdsa_verify"

include EcdsaVerify

if ARGV.size != 2
  puts "Expected two hexadecimal strings as arguments"
  exit 1
end

a = BigInt.new(ARGV[0], base: 16)
n = BigInt.new(ARGV[1], base: 16)

result = modular_inverse(a, n)
if result
  puts result.to_s(base: 16)
else
  puts "No inverse exists for the given values"
end
