require_relative 'ecdsa_verify'

def assert_equal(actual, expected)
    if actual != expected
        raise ArgumentError, "assert failed, actual #{actual} not equal to expected #{expected}"
    end
end

def tests
    # Test that the modular inverse of a number is correct
    a = 0x69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057
    n = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
    expected_result = 0x321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0
    result = modular_inverse(a, n)
    assert_equal(result, expected_result)

    # Test that the function returns nil when there is no inverse
    a = 4
    n = 6
    expected_result = nil
    result = modular_inverse(a, n)
    assert_equal(result, expected_result)

    # Test that the function returns nil when n=0
    n = 0
    expected_result = nil
    result = modular_inverse(a, n)
    assert_equal(result, expected_result)

    # Test that the function returns nil when n=1
    n = 1
    expected_result = nil
    result = modular_inverse(a, n)
    assert_equal(result, expected_result)
end

tests
