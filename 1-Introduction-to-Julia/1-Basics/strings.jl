#=
    " "   is for single line string
    """ """ is for multi-line string
=#

# String Data Type
# String can be one or more characters long
s1 = "I am string"
s2 = """
I am also 
a string. 
"Yay!!!"
"""

println("s1 = ", s1)
println("s2 = ", s2)

println("type of s1 = ", typeof(s1))
println("type of s2 = ", typeof(s2))
println()
 
# Char Data Type
# Char is a single character
s3 = 'a'

println("s3 = ", s3)
println("type of s1 = ", typeof(s3))
println()

# String Interpolation
name = "Krittin"
num_fingers = 10
num_toes = 10

println("Hello, my name is $name.")
println("I have $num_fingers fingers and $num_toes toes. That is $(num_fingers + num_toes) digits in all!!!")
println()

# String Concatenation
s4 = "There are "
s5 = 10
s6 = " cats over there."

s7 = string(s4, s5, s6)
println(s7)

# Do not support mix data types
# s8 = s4 * s5 * s6
# println(s8)

s9 = s4 * "10" * s6
println(s9)

s10 = "$s4 10 $s6"
println(s10)