# Gaussian Elimination with Partial Pivoting (GEPP)

#=
    GEPP allows for the extraction of LU factorization 
    by swapping the current row with the row containing 
    the highest value before performing Gaussian Elimination.
=#
using LinearAlgebra

function swap_row(pivot::Int, curr::Int, mat::Matrix) 
    pivotRow = mat[pivot, :]
    mat[pivot, :] = mat[curr, :]
    mat[curr, :] = pivotRow
end

function LU_factorization(A::Matrix)
    U = deepcopy(A)
    L = zeros(size(A))
    P = Matrix{Float64}(I, size(A))
    n = size(A, 1)
    v = zeros(n)

    for i in 1:n
        idx = argmax(abs.(U[i:n, i])) + (i - 1)

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

    L += Matrix{Float64}(I, size(A))

    for i in 1:n
        idx = argmax(P[i, :])
        v[i] += idx
    end

    return L, U, P, v
end

A = Matrix{Float64}([
        -1 1 3;
        2 0 1;
        -3 -1 2
    ])

b = Vector([-1.; 0.; -2.])

L, U, P, v = LU_factorization(A)

println("Original Matrix : ")
display(A)

println("Lower Triangular Matrix : ")
display(L)

println("Upper Triangular Matrix : ")
display(U)

println("Permutation Matrix : ")
display(P)

println("Permutation Vector : ")
display(v)

#=
    Solving Ax = b with GEPP

        1. Factor A = transpose(P) * L * U by GEPP
        2. Set b^ = P * b
        3. Solve L * w = b^ for w (forward substitution)
        4. Solve U * x = w for x (backward substitution)

    Verify :
        b^ = P * b
        transpose(P) * b^ = transpose(P) * P * b
        transpose(P) * b^ = b

        Ax = (transpose(P)LU)x = transpose(P)L(Ux) = transpose(P)(Lw) = transpose(Pp)b^
=#

# Factor A = transpose(P) * L * U by GEPP
# L, U, P, _ = LUFactorization(A)

# Set b^ = P * b
b_hat = P * b

println("Vector b_hat : ")
display(b_hat)

# Solve L * w = b^
    function solve_linear_equation_LTM(L::Matrix, b_hat::Vector)
    n = size(L, 1)

    res = zeros(n)

    for i in 1:n
        res[i] += b_hat[i] / L[i, i]

        for j in i+1:n
            b_hat[j] -= L[j, i] * res[i]    
        end
    end

    return res
end

w = solve_linear_equation_LTM(L, b_hat)

println("Vector w : ")
display(w)

# Solve U * x = w for x (backward substitution)
function solve_linear_equation_UTM(U::Matrix, w::Vector)
    n = size(U, 1)

    res = zeros(n)

    for i in n:-1:1
        res[i] += w[i] / U[i, i]

        for j in 1:i-1
            w[j] -= U[j, i] * res[i]   
        end
    end

    return res
end

x = solve_linear_equation_UTM(U, w)

println("Vector x : ")
display(x)
