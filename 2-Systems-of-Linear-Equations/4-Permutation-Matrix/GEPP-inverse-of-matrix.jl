# Computing inverses with GEPP

#=
    Gaussian-Jordan Elimination (GJE)
    
    The reason why GJE is not aplied to solve linear equation 
    because of the inaccurate solution from floating-point arithmetic 
    and the 50% more operation counts requirement.

    Howver, GJE is mathematically elegant is useful in proving many theorems.
    GJE is also useful in parallel computing.
=#

using LinearAlgebra

function swap_row(pivot::Int, curr::Int, mat::Matrix) 
    mat[[pivot, curr],:] = mat[[curr, pivot], :]
end

function LU_factorization(A::Matrix) 
    n = size(A, 1)
    L = zeros(n, n)
    U = deepcopy(A)
    P = Matrix{Float64}(I, n, n)
    v = zeros(n)

    for i in 1:n
        idx = argmax(abs.(U[i:n, i]))

        if idx != i && i != n
            swap_row(idx, i, L)
            swap_row(idx, i, U)
            swap_row(idx, i, P)
        end

        for j in i+1:n
            factor = U[j, i] / U[i, i]
            L[j, i] += factor
            U[j, :] -= factor * U[i, :]
        end
    end

    L += Matrix{Float64}(I, n, n)

    for i in 1:n
        v[i] = argmax(P[i, :])
    end

    return L, U, P, v
end

function forward_substitution(L::Matrix, e::Vector)
    ltm = deepcopy(L)
    n = size(ltm, 1)

    res = zeros(n)

    for i in 1:n

        res[i] += e[i] / ltm[i, i]

        for j in i+1:n
            e[j] -= ltm[j, i] * res[i]
        end
    end

    return res
end

function backward_substitution(U::Matrix, w::Vector)
    utm = deepcopy(U)
    n = size(utm, 1)

    res = zeros(n)

    for i in n:-1:1

        res[i] += w[i] / utm[i, i]

        for j in 1:i-1
            w[j] -= utm[j, i] * res[i]
        end
    end

    return res
end

function inverse_matrix(A::Matrix)
    L, U, P, _ = LU_factorization(A)

    A_inv = Matrix{Float64}(I, size(A)) # The final result in each loop is A_inv = P
    res = zeros(size(A))

    for i in 1:size(A_inv, 1)
        l = deepcopy(L)
        u = deepcopy(U)
        A_inv[:, i] = P * A_inv[:, i]
        w = forward_substitution(l, A_inv[:, i]) 
        A_inv[:, i] = backward_substitution(u, w)  
    end

    return A_inv
end

A = Matrix{Float64}([
    1 2 2;
    4 4 2;
    4 6 4
])

A_inv = inverse_matrix(A)

println("Orignial Matrix : ")
display(A)

println("Inverse of Matrix : ")
display(A_inv)