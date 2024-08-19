# Functions

# Declaring Function

function sayHi(name)    
    println("Hi $name, it's great to see you!")
end

# sayHi("Krittin")

function f(x)
    x^2
end

x = 3
y = f(x)

# println("The square value of $x is $y")

# Single Line Function Declaring

sayHi2(name) = println("Hello " * name * "!")

# sayHi2("John")

f2(x) = x^2

x = 4
y = f2(x)

# println("The square value of $x is $y")

# Anonymous Function

sayHi3 = name -> println("Hallo $name")

# sayHi3("Austin")

f3 = x -> x^2

x = 5
y = f3(x)

# println("The square value of $x is $y")

# Duck-Typing

# If it quacks like a duck, it's a duck.
# Julia functions will just work on whatever inputs make sense.

# sayHi(123)

A = rand(3, 3)

# println("Matrix A :")
# display(A)

B = f(A)    # This matrix multiplication of A and A

# println("Matrix B :")
# display(B)

C = rand(3)

# println("Vector C :")
# display(C)

# D = f(C)    # C^2 = C * C that is the matrix (3, 1) * (3, 1), which can never be done

# Mutating and Non-Mutating Functions

#=
    Mutating     : Affect the original inputs
    Non-Mutating : Do not affct the original inputs
=#
v = [3, 5, 2]

# println("Original Vector : ")
# display(v)

o1 = sort(v)

# println("Sorted Vector : ")
# display(o1)

# println("Original Vector : ")
# display(v)

sort!(v)

# println("Original Vector with sort!() : ")
# display(v)

# Broadcasting

#=
    By placing `.` between any function name and its argument list,
    we tell that function to broadcast over the element of the input objects
=#

A = [i + 3 * j for j in 0:2, i in 1:3]

# println("Original Matrix : ")
# display(A)

B = f(A)

# println("The matrix multiplication result of A * A : ")
# display(B)

C = f.(A)

# println("The Hadamard (element-wise) product of A * A")
# display(C)


A = [1, 2, 3]

println("Original Vector : ")
display(A)

C = f.(A)

println("The Hadamard (element-wise) product of A * A")
display(C)
