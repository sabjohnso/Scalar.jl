### file: Scalar/test/runtests.jl

## Copyright (c) 2015 Samuel B. Johnson

## Author: Samuel B. Johnson <sabjohnso@yahoo.com>

## This file is lincesed under a two license system. For commercial use
## that is not compatible with the GPLv3, please contact the author.
## Otherwise, continue reading below.

## This file is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3, or (at your option)
## any later version.

## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

### Code:
"
module Scalar
-------------
A module exporting an abstract type AbstractScalar and a number
of methods overloaded for that abstract type.  The methods are
a subset of the methods overloaded for Number that could be 
associated with arrays or iterator. Specifically, the following 
methods are overloaded: size, eltype, ndims, length, endof, getindex, 
    first, last, start, next, done, isempty, map, filter.
"
module Scalar


import Base.size, Base.eltype, Base.ndims, Base.length, Base.endof,
       Base.getindex, Base.first, Base.last,
       Base.start, Base.next, Base.done, Base.isempty, Base.map, Base.filter

export AbstractScalar, isScalar,
       size, eltype, ndims, length, endof, getindex, first, last,
       start, next, done, isempty, map, filter



"
AbstractScalar
------
An abstract type intended for efficient derivation
of scalar iterator operations as done for Numer.
"
abstract AbstractScalar



#
# ... Type Predicate
#
isScalar{T}( ::Type{T} ) = T <: AbstractScalar
isScalar{T}( ::T ) = isScalar( T )

#
# ... Array operations
#

size{ T <: AbstractScalar }( x::T ) = ()
size{ T <: AbstractScalar }( x::T, d ) = convert( Int, d ) < 1 ? throw( BoundsError()) : 1
eltype{ T <: AbstractScalar }( ::Type{T} ) = T
eltype{ T <: AbstractScalar }( ::T ) = eltype( T )
ndims{ T <: AbstractScalar }( ::Type{T} ) = 0
ndims{ T <: AbstractScalar }( ::T ) = 0
length{ T <: AbstractScalar }( ::T ) = 1
endof{ T <: AbstractScalar }( ::T ) = 1
getindex{ T <: AbstractScalar }( x::T, j::Integer ) = j == 1 ? x : throw( BoundsError())
getindex{ T <: AbstractScalar }( x::T, js::Integer ... ) = all([ j == 1 for j in js ]) ? x : throw( BoundsError())
getindex{ T <: AbstractScalar }( x::T, js::Real ... ) = getindex( x, to_indexes( js ... ) ... )
first{ T <: AbstractScalar }( x::T ) = x
last{ T <: AbstractScalar }( x::T ) = x

#
# ... Iterator operations
#

start{T <: AbstractScalar }( ::T ) = false
next{T <: AbstractScalar }( x::T, state ) = (x, true)
done{T <: AbstractScalar }( ::T, state ) = state
isempty{ T <: AbstractScalar }( ::T ) = false
map{ T <: AbstractScalar }( f, x::T ) = f( x )
filter{ T <: AbstractScalar }( p, x::T ) = p( x ) ? x : nothing
filter{ T <: AbstractScalar }( re::Regex, x::T ) = ismatch( re, x ) ? x : nothing



end # module
