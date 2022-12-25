#!/bin/sh
function print() {
    tput bold
    echo $1
    tput sgr0
}

a="69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057"
n="fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"

print "OCaml"
cd ecdsa-verify-ocaml
dune test
dune build
./_build/install/default/bin/ecdsa_verify "0x$a" "0x$n"
cd ..

print "Haskell"
cd ecdsa-verify-haskell
ghc ecdsa_verify.hs
./ecdsa_verify $a $n
cd ..

print "Javascript"
cd ecdsa-verify-javascript
node test.js
node main.js $a $n
cd ..

print "Julia"
cd ecdsa-verify-julia
julia test.jl
julia main.jl $a $n
cd ..

print "Python3"
cd ecdsa-verify-python3
python3 test.py
python3 main.py $a $n
cd ..

print "Ruby"
cd ecdsa-verify-ruby
ruby test.rb
ruby main.rb $a $n
cd ..

print "Rust"
cd ecdsa-verify-rust
cargo test
cargo build -r
./target/release/ecdsa-verify-rust $a $n
cd ..

print "Go"
cd ecdsa-verify-go
go test -v ecdsaverify
go build
./main $a $n
cd ..

print "C# .NET"
cd ecdsa-verify-csharp
dotnet test ECDSAVerify.Tests
dotnet build ECDSAVerify --sc -c Release
./ECDSAVerify/bin/Release/net7.0/osx-arm64/ECDSAVerify $a $n
cd ..

print "F# .NET"
cd ecdsa-verify-fsharp
dotnet test ECDSAVerify.Tests
dotnet build ECDSAVerify --sc -c Release
./ECDSAVerify/bin/Release/net7.0/osx-arm64/ECDSAVerify $a $n
cd ..

print "Dart"
cd ecdsa-verify-dart
dart test test.dart
dart compile exe -o main main.dart
./main $a $n
cd ..

print "Zig"
cd ecdsa-verify-zig
zig test main.zig
zig build-exe main.zig
./main $a $n
cd ..
