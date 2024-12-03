# Power Method

#=
    Power Method
        Given A a matrix with dimensions of n × n
        x^(0) := arbitrary nonzero vector.
        
        For k = 0, 1, 2, . . .
            x^(k+1) = Ax^(k)

        Properties of Power Method
            Power method computes A^k * x^(0)

            Theorem 
                If A has a unique eigenvalue with maximum absolute value, 
                then power method converges to (a multiple of) the eigenvector corresponding to that eigenvalue.

            Examples:  
                If A has the following eigenvalues: -10, 5, 5 then power method converges to the eigenvector associated with -10. (-10 is a unique eigenvalue with maximum absolute value)
                If A has the following eigenvalues: -10, 10, 1, -2 then power method does not converge. (-10 and 10 are eigenvalues with maximum absolute value, not unique)

        Normalized Power Method
            For k = 1, 2, . . .
                x̃^(k) = Ax^(k)
                f^(k) = ||x̃^(k)||_2
                x^(k+1) = x̃^(k) / f^(k)
=#

using LinearAlgebra

function power_method(A::Matrix, x::Vector)
    n = 10
    
    for i = 1:n
        new_x = A * x
        x = new_x

        # println("x = ", x)
    end

    return x
end

function normalized_power_method(A::Matrix, x::Vector)
    n = 10
    
    for i = 1:n
        x_bar = A * x
        f = norm(x_bar, 2)
        x = x_bar/f

        println("x = ", x)
    end

    return x
end

A = Matrix{Float64}([
    3 -1;
    -1 3
])

x = Vector{Float64}([1; 0])


x_10 = power_method(A, x)
println("Power Method: ")
println("x_10 (overflow) = ", x_10)

x_n10 = normalized_power_method(A, x)
println("Normalized Power Method: ")
println("x_10 (overflow) = ", x_n10)
