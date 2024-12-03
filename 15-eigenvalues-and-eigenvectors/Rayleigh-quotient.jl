# Rayleid Quotient

#=
    Rayleid Quotient

        The power method gives us an eigenvector. But what is the eigenvalue for this eigenvector?

        Find the eigenvalue λ by solving
            min_λ ||Ax^(k) - λx^(k)||_2 

        Therefore, by the method od normal equations,
            λ = ( (x^(k))^T * A * x^(k) ) / ( (x^(k))^T * x^(k) )

        The right-hand-side of this equation is called the Rayleid quotient.
        The denominator may be omitted if x^(k) is normalize as in the above algorithm.
=#

using LinearAlgebra

function power_method(A::Matrix, x::Vector)
    err = 1

    while abs(err) > 0.001
        x_bar = A * x 
        f = norm(x_bar, 2)
        new_x = x_bar / f

        err = norm(x - new_x, 2)
        
        x = new_x
    end

    return x
end

function Rayleid_quotient(A::Matrix, x::Vector)
    num = transpose(x) * A * x
    den = transpose(x) * x

    return num / den
end

A = Matrix{Float64}([
    3 -1;
    -1 3
])

x = Vector{Float64}([1; 0])

eigen_vec = power_method(A, x)
println("Eigenvectors = ", eigen_vec)

eigen_val = Rayleid_quotient(A, eigen_vec)
println("Eigenvalues = ", eigen_val)