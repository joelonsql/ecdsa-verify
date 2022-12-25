require "./spec_helper"

describe "modular_inverse" do
  it "returns the correct modular inverse" do
    a = BigInt.new("69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057", base: 16)
    n = BigInt.new("fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141", base: 16)
    expected_result = BigInt.new("321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0", base: 16)
    result = modular_inverse(a, n)
    result.should eq expected_result
  end

  it "returns nil when there is no inverse" do
    a = BigInt.new(4)
    n = BigInt.new(6)
    expected_result = nil
    result = modular_inverse(a, n)
    result.should eq expected_result
  end

  it "returns nil when n=0" do
    a = BigInt.new(4)
    n = BigInt.new(0)
    expected_result = nil
    result = modular_inverse(a, n)
    result.should eq expected_result
  end

  it "returns nil when n=1" do
    a = BigInt.new(4)
    n = BigInt.new(1)
    expected_result = nil
    result = modular_inverse(a, n)
    result.should eq expected_result
  end
end
