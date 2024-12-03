# Inverse Shifted Power Method 

#=
    Inverse Shifted Power Method

        Given A a matrix with dimensions of n × n,

        x^(0) := arbitrary nonzero vector
        
        For k = 1, 2, . . . 
            x^(k+1) = (A - σI)^-1 * x^(k) (plus normalization)

        σ is a scalar that is chosen in advance.

    Theorem
        Suppose (A - σI) is invertible.
        Then A and (A - σI)^-1 have the same eigenvectors.
        λ is an eigenvalue of A if and only if 1/(λ - σ) is an eigenvalue of (A - σI)^-1.

    Theorem 
        If A has a uniqu eigenvalue that is closet to σ,
        then inverse shifted power method converges to (a multiple of) the eigenvector corresponding to that eigenvalue.

        Examples:  
            If A has the following eigenvalues: -10, -10, 1, 1, 6 and we use σ = 5, then inverse shifted power method converges to the eigenvector associated with 6. (6 is a unique eigenvalue that is closet to σ = 5)
            If A has the following eigenvalues: -20, 1, 5, 7 and we use σ = 6, then inverse shifted power method does not converge. (5 and 7 differ from σ = 5 by 1, not unique)
=#

using LinearAlgebra

A = Matrix{Float64}([
    1 0 0;
    0 4 0;
    0 0 6
])

sigma = 3.5

mod_A = A - sigma * I(size(A, 1))

# println("A - σI: ")
# display(mod_A)

x = Vector{Float64}([1; 1; 1])

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

function inverse_shifted_power_method(A::Matrix, sigma, x::Vector)
    mod_A = A - sigma*I(size(A, 1))
    P, L, U = LU_factorization(mod_A)

    n = 10

    for i = 1:n
        x_bar = solve_linear_equation(P, L, U, x)
        f = norm(x_bar, 2)
        x = x_bar / f
    end

    return x
end

eigen_vec = inverse_shifted_power_method(A, sigma, x)

println("Eigenvector: ")
display(eigen_vec)