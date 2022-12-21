#!/bin/sh
cd $HOME
curl -O https://julialang-s3.julialang.org/bin/linux/aarch64/1.8/julia-1.8.3-linux-aarch64.tar.gz
tar xzf julia-1.8.3-linux-aarch64.tar.gz
export PATH=~/julia-1.8.3/bin:$PATH
