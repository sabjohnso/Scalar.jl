# Scalar

### Scalar Type Tools

[![Build Status](https://travis-ci.org/sabjohnso/Scalar.jl.svg?branch=master)](https://travis-ci.org/sabjohnso/Scalar.jl)
[![codecov.io](http://codecov.io/github/sabjohnso/Scalar.jl/converage.svg?branch=master)](http://codecov.io/github/sabjohnso/Scalar.jl?branch=master)

`Scalar` is a [Julia](http://julialang.org) package to facilitate the generation of scalar types.  Primarily,Scalar defines an abstract type, `AbstractScalar`, and a number of methods overloaded for that for its subtypes.  The list of overloaded methods includes the following: `size`, `eltype`, `ndims`, `length`, `endof`, `getindex`, `first`, `last`, `start`, `next`, `done`, `isempty`, `map`, `filter`.  These methods are a subset of the methods defined for the abstract type `Number`, where those methods that imply a numerical nature of the subtypes are excluded.  Additionally, the method `filter` is included here, where it was not specifically defined for `Number`. 


Dual licensing (GPLv3, alternate commercial) - See LICENSE.md


**Installation**: `julia> Pkg.clone( "https://github.com/sabjohnso/Scalar.jl" )`

### Getting Started

To define a new scalar type:

```julia
type MyScalar <: AbstractScalar
end

using Base.Test
a = MyScalar()
@test length( a ) == 1
@test size( a ) == ()
@test map( identity, a ) == a
@test filter( x->isa( x, MyScalar ), a ) == a
@test filter( x->! isa( x, MyScalar ) == nothing
```




