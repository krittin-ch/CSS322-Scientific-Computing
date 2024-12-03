# Inverse of SVD

#=
    Inverse of SVD 
        If σ_1, σ_2, . . ., σ_n are singular values of a matrix A whose dimension is n × n and A is invertible, then ||A^-1||_2 = 1/σ_n

            A = UΣV^T
            
            A^-1 = V * Σ^-1 * U^T

            Σ = diagonal(σ_1, σ_2, . . ., σ_n)
            So, Σ^-1 = diagonal(1/σ_1, 1/σ_2, . . ., 1/σ_n)

        But A^-1 = V * Σ^-1 * U^T is not an SVD of A^-1 because the diagonal entries of Σ^-1 are not in the correct order

        Consider the following permutation matrix
            P = [
                0 . . . . 1
                .       . .
                .     .   .
                .   .     .
                1 . . . . 0
            ]

        Note that
            P * Σ^-1 * P = diagonal(1/σ_n, 1/σ_{n-1}, . . ., 1/σ_1)
            has the diagonal entries in nonincreasing order from top-left to bottom-right.

        So, P * Σ^-1 * P can be the "Σ" of the SVD A^-1
        
        Note: P * P = I, VP is orthogonal, and PU^T is orthogonal.

        Therefore
            A^-1 = V * Σ^-1 * U^T = (VP)(P * Σ^-1 * P)(PU^T) is the SVD of A^-1

        Therefore, ||A^-1||_2 = 1/σ_n as 1/σ_n is the largest value of A^-1

        So, the condition number (in 2-norm)
            cond_2(A) = σ_1/σ_n

        Using singular values, we can define condition number for rectangular matrices A with dimensions of m × n as 
            cond_2(A) = σ_1/σ_{min}(m, n)
=#

using LinearAlgebra

A = Matrix{Float64}([
    1 0 2;
    -1 1 -1;
    2 1 0
])

U = Matrix{Float64}([
    0.70189 0.3672 0.6103;
    -0.4755 -0.3965 0.7853;
    0.5303 -0.8414 -0.1037
])

Sigma = Matrix{Float64}([
    2.9223 0 0;
    0 1.9121 0;
    0 0 0.8946
])

V = Matrix{Float64}([
    0.7657 -0.4807 -0.4273;
    0.0188 -0.6474 0.7619;
    0.6429 0.5914 0.4867
])

function create_permutation_matrix(n::Int)
     return I(n)[end:-1:1, :]
end

function create_inverse_SVD(U::Matrix, Sigma::Matrix, V::Matrix)
    m, n = size(Sigma)

    P = create_permutation_matrix(n)
    new_U = V * P
    new_Sigma = P * inv(Sigma) * P
    new_V = P * transpose(U)

    return new_U, new_Sigma, new_V
end

new_U, new_Sigma, new_V = create_inverse_SVD(U, Sigma, V)

println("new U (VP) = ")
display(new_U)

println("new Sigma (P Σ^-1 P) = ")
display(new_Sigma)

println("new V (P U^T) = ")
display(new_V)

println("A^-1 (VP)(P Σ^-1 P)(P Σ^-1 P) = ")
display(new_U * new_Sigma * new_V)

println("Exact A^-1 = ")
display(inv(A))