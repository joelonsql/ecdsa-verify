require_relative 'ecdsa_verify'

if ARGV.length != 2
    puts "Expected two hexadecimal strings as arguments"
    exit 1
end

a = ARGV[0].to_i(16)
n = ARGV[1].to_i(16)

result = modular_inverse(a, n)
if result == nil
    puts "No inverse exists for the given values"
else
    puts result.to_s(16)
end