# Woodbury Formula

#=
    Similar to Sherman-Morrison formula, the Woodbury formula is invented to solve modified linear system with rank-k modification

    (A - U*V^T)x = b for U and V are n × k matrices     
    
    Hence, rank-k modification

    (A - U*V^T)^-1 = A^-1 + A^-1 * U * (I_k - V^T * A^-1 * U)^-1 * V^T * A^-1

    x = (A - U*V^T)^-1 * b = A^-1 * b + A^-1 * U * (I_k - V^T * A^-1 * U)^-1 * V^T * A^-1 * b

    Hence, Ay = b and AZ = U can be solved

    x = (A - U * V^T)^-1 * b = y + Z * (I_k - V^T * Z)^-1 * V^T * y

    And, (I_k - v^T * Z)^-1 * v^T can be solved by (I_k - v^T * Z) * C = V^T

    Therefore, x = y + Z * C * y
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



function solve_linear_equation_matrix(L::Matrix, U::Matrix, P::Matrix, b::Matrix)
    n, k = size(b)
    res = zeros(n, k)
    
    for i in 1:k
        x = solve_linear_equation(L, U, P, b[:, i])
        res[:, i] = x
    end
    
    return res
end

# Problem
u = Matrix{Float64}([
    0 2;
    0 0;
    3 0;
])

v = Matrix{Float64}([
    0 1;
    1 0;
    0 0;
])

print("U * V^T : ")
display(u * transpose(v))

A = Matrix{Float64}([
    1 2 2;
    4 1 1;
    4 6 4;
])

print("A - U*V^T : ")
display(A - u * transpose(v))

b = Vector{Float64}([3; 6; 10])

# Decompose A into P^T L U 
L, U, P, _ = LU_factorization(A)

# Solve Ay = b for y
y = solve_linear_equation(L, U, P, b)

# Solve AZ = U for Z (n × k)
Z = solve_linear_equation_matrix(L, U, P, u)

# Solve (I_k - V^T * Z) * C = V^T for C
# Given J = (I_k - v^T * Z)
k = size(v, 2)
v_T = collect(transpose(v))
J = Matrix{Float64}(I, k, k) - v_T * Z

L_j, U_j, P_j, _ = LU_factorization(J)
C = solve_linear_equation_matrix(L_j, U_j, P_j, v_T)

# Solve x
# for x = y + Z * C * y
x = y + Z * C * y

print("(A - U*V^T)x = b : ")
display(x)