#=
    Multiple Dispatch makes software :
        1. Fast
        2. Extensive
        3. Programmable
        4. Fun to play with
=#

# methods(+)  # Show methods for generic function `+`

#=
    `@which` macro is used to learn which method we are using  when we call `+`

    julia> @which 3 + 3
    +(x::T, y::T) where T<:Union{Int128, Int16, Int32, Int64, Int8, UInt128, UInt16, UInt32, UInt64, UInt8}
        @ Base int.jl:87

    julia> @which 3.0 + 3.0
    +(x::T, y::T) where T<:Union{Float16, Float32, Float64}
            @ Base float.jl:409
        
             
    julia> @which 3.0 + 3
    +(x::Number, y::Number)
        @ Base promotion.jl:422
=#


#=
    `+` can be extended by defining methods for it

    import Base:+
=#

import Base:+

a = "hello "

b = "world"

# c = a + b # create error

#=
    julia> @which "hello" + "world!"
    ERROR: no unique matching method found for the specified argument types
    Stacktrace:
     [1] error(s::String)
        @ Base .\error.jl:35
     [2] _which(tt::Type; method_table::Nothing, world::UInt64, raise::Bool)
        @ Base .\reflection.jl:1702
     [3] _which
        @ .\reflection.jl:1688 [inlined]
     [4] which(tt::Any)
        @ Base .\reflection.jl:1728
     [5] which(f::Any, t::Any)
        @ Base .\reflection.jl:1719
     [6] top-level scope
        @ REPL[6]:1
=#

# Add a method for `+` that takes two strings as inputs and concatenates them

#=
    julia> +(x::String, y::String) = x * y
    + (generic function with 190 methods)

    julia> @which "hello" + "world!"
    +(x::String, y::String)
        @ Main REPL[8]:1
=#

+(x::String, y::String) = string(x, y)

c = a + b

println(c)

# More Examples
foo(x, y) = println("duk-typed foo")
foo(x::Int, y::Float64) = println("foo with an integer and a float")
foo(x::Float64, y::Float64) = println("foo with two floats")
foo(x::Int, y::Int) = println("foo with two integers")

foo(123, "Hi")
foo(1, 1.0)
foo(1.0, 1.0)
foo(1, 1)