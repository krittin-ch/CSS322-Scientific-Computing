# Printing 
println("This is printing")

x = 43
println("x = ", x)
type_x = typeof(x)
println("type of x = ", type_x)
println()

# This is 1 line comment

#=
This is a
multi-line comment

use "#= =#"
=#

# Syntax for Basic Math
sum = 3 + 7
difference = 10 - 3
product = 20 * 5
quotient = 100 / 10 # return as float
power = 10 ^ 2
modulus = 101 % 2

println("Mathematic Operations")
println("sum = ", sum)
println("difference = ", difference)
println("product = ", product)
println("quotient = ", quotient)
println("power = ", power)
println("modulus = ", modulus)
println()

# Exercises
# 1.1 Look up docs for the convert function

# x = convert(Float64, x)
x = convert(Char, x)

type_x = typeof(x)

println("new type of x = ", type_x)
println()

# 1.2 Assign 365 to a variable named days. Convert days to a float and assign it to variable days_float
days = 365

days_float = convert(Float32, days)

println("type of days = ", typeof(days))
println("new type of days_float = ", typeof(days_float))

