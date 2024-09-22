# Cholesky Factorization

#=
    Solving linear system: Ax = b 

    If the matrix A is symmetrix positive definite, its LU factorization can be arranged as U = L^T

    Hence, any symmetrix positive definite matrixx A can be factored as 
        A = L L^T  where L is lower triangular (not necessarily unit lower triangular)

    Cholesky factorization can be computed from GE, but there is more efficint way

    A = [
        a_11 a_21
        a_12 a_22
    ]

    L = [
        l_11 0
        l_12 l_22
    ]

    L*L^T = [
        l_11^2      l_11*l_12
        l_11*l_21   l_21^2+l_22^2 
    ]

    Then
        l_11^2 = a_11           --> l_11 = ±√a_11
        l_11*l_21 = a_21        --> l_21 = a_21 / l_11
        l_21^2 + l_22^2 = a_22  --> l_22 = ±√(a_22 - l_21^2)

    By conventional, we always choose the positive values for the diagonak entries of L 
    The same idea can be extended to a more general n-by-n matrix
=#

using LinearAlgebra

function LU_factorization(A::Matrix)
    n = size(A, 1)
    L = zeros(n, n)
    U = deepcopy(A)

    for i in 1:n
        for j in i+1:n 
            factor = U[j, i] / U[i, i]
            L[j, i] = factor 
            U[j, :] -= factor * U[i, :]
        end
    end

    L += Matrix{Float64}(I, n, n)

    return L, U
end


A = Matrix{Float64}([
    9 -15;
    -15 26
])

L, U = LU_factorization(A)

println("LU Factorization Method")

println("Lower Triangular Matrix:")
display(L)

println("Upper Triangular Matrix:")
display(U)

println("A = LU:")
display(L*U)

function Cholesky_factorization(A::Matrix)
    n = size(A, 1)
    L = deepcopy(A)

    for k in 1:n
        L[k, k] = sqrt(L[k, k])
        L[k,k+1:n] = zeros(n-k)

        for i in k+1:n
            L[i, k] /= L[k, k]
        end

        for j in k+1:n
            for i in k+1:n 
                L[i, j] -= L[i, k] * L[j, k]
            end
        end
    end

    return L    
end

function Cholesky_factorization_2(A::Matrix)
    n = size(A, 1)
    L = zeros(n, n)  

    for k in 1:n
        L[k, k] = sqrt(A[k, k] - sum(L[k, 1:k-1].^2))

        for i in k+1:n
            L[i, k] = (A[i, k] - sum(L[i, 1:k-1] .* L[k, 1:k-1])) / L[k, k] 
        end
    end

    return L    
end

println("Cholesky Factorization Method")
L = Cholesky_factorization(A)


println("Lower Triangular Matrix:")
display(L)

println("A = L * L^T:")
display(L * transpose(L))


function forward_substitution(L::Matrix, b::Vector)
    n = size(L, 1)
    w = zeros(n)
    
    for i in 1:n 
        w[i] = b[i] / L[i, i]

        for j in i+1:n 
            b[j] -= L[j, i] * w[i]
        end
    end

    return w
end

function backward_substitution(U::Matrix, w::Vector)
    n = size(U, 1)
    x = zeros(n)

    for i in n:-1:1
        x[i] = w[i] / U[i, i]
        for j in 1:i-1
            w[j] -= U[j, i] * x[i]
        end
    end

    return x 
end 

function solve_linear_equation(A::Matrix, b::Vector)
    L = Cholesky_factorization(A)
    w = forward_substitution(L, b)
    x = backward_substitution(collect(transpose(L)), w)

    return x
end

b = Vector{Float64}([1; 0])

x = solve_linear_equation(A, b)

println("The Solution to the Linear System:")
display(x)