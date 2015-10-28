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
using Scalar
using FactCheck

#
# ... A type to test inheritance from AbstractScalar
#

immutable DummyScalar <: AbstractScalar
end

isDummyScalar( ::Any ) = false
isDummyScalar( ::DummyScalar ) = true
isntDummyScalar( x ) = ! isDummyScalar( x )



#
# ... A type to test the filter method invoked with a regular expression
#

type StringWrapper{ S  <: AbstractString } <: AbstractScalar
    s::S
end

import Base.ismatch
ismatch{ S }( re::Regex, s::StringWrapper{S} ) = ismatch( re, s.s )



facts( "AbstractScalar" ) do

    a = DummyScalar()

    @fact size( a ) --> ()
    @fact size( a, 1 ) --> 1
    @fact size( a, 2 ) --> 1
    @fact ndims( a ) --> 0
    @fact length( a ) --> 1
    @fact endof( a ) --> 1
    @fact a[ 1 ] --> a
    @fact a[ 1, 1, 1, 1, 1 ] --> a
    @fact first( a ) --> a
    @fact last( a ) --> a

    as = Array{DummyScalar,1}()
    for item in a
        push!( as, a )
    end
    @fact length( as ) --> 1
    @fact as[ 1 ] --> a

    @fact start( a ) --> false
    @fact next( a, start( a )) --> ( a, true )
    @fact done( a, next( a, start( a ))) --> ( a, true )
    @fact isempty( a ) --> false
    
    @fact map( identity, a ) --> a

    @fact filter( isDummyScalar, a ) --> a
    @fact filter( isntDummyScalar, a ) --> nothing
    
    b = StringWrapper( "FooBar" )
    
    @fact typeof( b ) <: StringWrapper --> true
    @fact filter( r"Foo", b ) --> b
    @fact filter( r"Baz", b ) --> nothing


    
end
