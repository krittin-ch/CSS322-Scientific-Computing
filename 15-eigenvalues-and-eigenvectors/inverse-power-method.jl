# Inverse Power Method

#=
    Inverse Power Method

    If A is a matrix with dimensions of n × n, then A and A^-1 have the same eigenectors, 
    and the eigenvalues of A^-1 are recipocals of the eigenvalues of A
    (i.e. if λ is an eigenvalue of A, then 1/λ is an eigenvalue of A^-1).

    Inverse Power Method
        x^(0) := arbitrary nonzero vector

        For k = 1, 2, . . .
            x^(k+1) = A^-1 * x^(k) (plus normalization and use A = P^TLU (GEPP) factorization)

        This takes 2(n^3)/3 + O(n^2) arithmetic operations to start, then 2(n^2) + O(n) per iteration.
=#

using LinearAlgebra

function swap_rows(A::Matrix, i::Int, j::Int)
    A[[i, j], :] =A[[j, i], :]
end

function LU_factorization(A::Matrix)
    n = size(A, 1)
    L = zeros(n, n)
    U = deepcopy(A)
    P = Matrix{Float64}(I, n, n)

    for i = 1:n
        idx = argmax(abs.(U[i:n, i])) + i - 1

        if idx != i && i != n
            swap_rows(P, i, idx)
            swap_rows(L, i, idx)
            swap_rows(U, i, idx)
        end

        for j = i+1:n
            factor = U[j, i] / U[i, i]
            U[j, :] -= factor * U[i, :]
            L[j, i] = factor
        end
    end

    L += I(n)

    return P, L, U
end

function forward_substitution(L::Matrix, b::Vector)
    n = size(L, 1)
    w = zeros(n)

    for i = 1:n
        w[i] = b[i] / L[i, i]
        for j = i+1:n
            b[j] -= w[i] * L[j, i]
        end
    end

    return w
end

function backward_substitution(U::Matrix, w::Vector)
    n = size(U, 1)
    x = zeros(n)

    for i = n:-1:1
        x[i] = w[i] / U[i, i]
        for j = 1:i-1
            w[j] -= x[i] * U[j, i]
        end
    end

    return x
end

function solve_linear_equation(P::Matrix, L::Matrix, U::Matrix, b::Vector)
    b_hat = P * b

    w = forward_substitution(L, b_hat)
    x = backward_substitution(U, w)

    return x
end

function inverse_power_method(A::Matrix, x::Vector)
    P, L, U = LU_factorization(A)

    n = 10

    for i = 1:n
        x_bar = solve_linear_equation(P, L, U, x)
        f = norm(x_bar, 2)
        x = x_bar / f
    end

    return x
end

A = Matrix{Float64}([
    3 -1;
    -1 3
])

x = Vector{Float64}([1; 0])

x_10 = inverse_power_method(A, x)

println("Inverse Power Method: ")
println("x_10 = ", x_10)