# Tridiagonal Linear System 

#=
    A = [
        b_1 c_1  0  . . . 0
        a_2 b_2 c_2 . . . 0
        0
    ]
=#

using LinearAlgebra

A = Matrix{Float64}([
    3 5 0 0 0 0 0 0;
    -2 8 1 0 0 0 0 0;
    0 -4 -1 -5 0 0 0 0;
    0 0 1 1 3 0 0 0;
    0 0 0 4 2 9 0 0;
    0 0 0 0 1 -3 2 0;
    0 0 0 0 0 -3 -5 -8;
    0 0 0 0 0 0 1 3
])

function LU_tridiagonal_factorization(A::Matrix)
    n = size(A, 1)
    L = Matrix{Float64}(I, n, n)
    U = zeros(n, n)

    U[1, 1] = A[1, 1]

    for i in 2:n
        L[i, i-1] = A[i, i-1] / U[i-1, i-1]
        U[i, i] = A[i, i] - L[i, i-1] * U[i-1, i] 
    end

    return L, U
end

L, U = LU_tridiagonal_factorization(A)

display(L * U)