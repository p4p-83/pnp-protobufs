#!/bin/bash

set -e

cd "$(dirname "$0")"

rm -f ./*.ts
rm -f ./*.jl

npm ci
protoc --ts_out=. pnp.proto

julia -e 'using Pkg; Pkg.add("ProtoBuf"); using ProtoBuf; protojl("pnp.proto", ".", "../../")'

# unroll nested folders
mv ../pnp.jl .
sed -i '' 's|v1/||' pnp.jl
