# Solving Linear Equation

A = Matrix([
    1 2 1;
    3 4 1;
    -3 4 6;
])

b = Vector([3; 2; 5])

x = A \ b

println("Linear Eqaution Result : ")
display(x)


B = rand(3, 3)
C = rand(3, 3) .* 1im

B = ComplexF64.(B)

B .+= C

println("Original Matrix : ")
display(B)

println("Normal Transpose : ")
display(transpose(B)) 

println("Conjugate Transpose : ")
display(adjoint(B)) # or `B'`
