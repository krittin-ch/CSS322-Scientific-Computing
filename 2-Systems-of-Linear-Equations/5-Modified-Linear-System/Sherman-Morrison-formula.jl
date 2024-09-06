# Sherman-Morrison Formula

#=
    To solve equation (A - u * v^T) * x = b, i.e. x = (A - u * v^T))^-1 * b

    Regarding Sherman-Morrison formula, 

        (A - u * v^T)^-1 = A^-1 + A^-1 * u * (1 - v^T * A^-1 * u)^-1 * v^T * A^-1

    Then x = (A - u * v^T)^-1 * b = A^-1 * b + A^-1 * u * (1 - v^T * A^-1 * u)^-1 * v^T * A^-1 * b

    Hence, Ay = b and Az = u can be solved

    x = (A - u * v^T)^-1 * b = y + z * (1 - v^T * z)^-1 * v^T * y

    Therefore, x = y + z * (1 - v^T * z)^-1 * v^T * y = y + z * ((v^T * y) / (1 - v^T z))
=#

using LinearAlgebra

# Row Swapping
function swap_row(pivot::Int, curr::Int, mat::Matrix) 
    pivotRow = mat[pivot, :]
    mat[pivot, :] = mat[curr, :]
    mat[curr, :] = pivotRow
end

# LU Factorization
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
            L[j, i] = factor
            U[j, :] -= factor * U[i, :]
        end
    end

    L += Matrix{Float64}(I, n, n)

    for i in 1:n
        idx = argmax(P[i, :])
        v[i] += idx
    end

    return L, U, P, v

end

# Solve L * w = b^  (Using Version II - Concerrent)
function solve_linear_equation_LTM(L::Matrix, b_hat::Vector)
    n = size(L, 1)
    res = zeros(n)

    for i in 1:n 

        res[i] = b_hat[i] / L[i, i]
        
        for j in i+1:n 
            b_hat[j] -= L[j, i] * res[i]
        end
    end

    return res
end

# Solve U * x = w   (Version I - Without Concerrent)
function solve_linear_equation_UTM(U::Matrix, w::Vector)
    n = size(U, 1)
    res = zeros(n)

    for i in n:-1:1

        for j in i+1:n
            w[i] -= U[i, j] * res[j]
        end

        res[i] = w[i] / U[i, i]
    
    end

    return res
end

function solve_linear_equation(L::Matrix, U::Matrix, P::Matrix, b::Vector)
    b_hat = P*b

    w = solve_linear_equation_LTM(L, b_hat)
    x = solve_linear_equation_UTM(U, w)
    
    return x
end

# Problem
u = Vector{Float64}([0; 0; 1])
v = Vector{Float64}([0; 2; 0])

# print("u * v^T : ")
# display(u * transpose(v))

A = Matrix{Float64}([
    1 2 2;
    4 4 2;
    4 6 4;
])

b = Vector{Float64}([3; 6; 10])

# Decompose A into P^T L U 
L, U, P, _ = LU_factorization(A)

# Solve Ay = b for y
y = solve_linear_equation(L, U, P, b)

# Solve Az = u for z
z = solve_linear_equation(L, U, P, u)

# Solve x
# for x = (A - u * v^T)^-1 * b = y + z * (1 - v^T * z)^-1 * v^T * y

x = y + z * (1 - transpose(v) * z)^-1 * transpose(v) * y

print("(A - u*v^T)x = b : ")
display(x)