# Solving Least-Squares Problems with SVD

#=
    Solving Least-Squares Problems with SVD

    Find x that minimizes ||Ax - b||_2 where A is a matrix of dimension m × n, m > n, rank(A) = n
    Suppose
        A = UΣV^T is the SVD of A

        A = [U_1 U_2] * [Σ_1; 0] * V^T
          = U_1 * Σ_1 * V^T

    Hence, x = V * Σ_1 * U_1^T * b

    For A of any shape or rank, the least squares solution to Ax ≊ b is 
        x = Σ ((u_i^T * b) / σ_i) * v_i

    where u_i is i-th the column of U, v_i is the i-th column of V
=#

using LinearSolve

A = Matrix{Float64}([
    0 1.6;
    0 0;
    0 -1.2
])

b = Vector{Float64}([-1; 0; 1])

x_0 = A \ b

println("Solution to Linear Least Square Problem x = ")
display(x_0)

U = Matrix{Float64}([
    0.8 0 0.6;
    0 1.0 0;
    -0.6 0 0.8
])

Sigma = Matrix{Float64}([
    2 0;
    0 0;
    0 0
])

V = Matrix{Float64}([
    0 1;
    1 0
])

function solve_linear_equation(U::Matrix, Sigma::Matrix, V::Matrix, b::Vector)
    m, n = size(Sigma)
    x = zeros(n)

    for i = 1:n
        if Sigma[i, i] != 0
            temp = transpose(U[:, i]) * b
            temp *= V[:, i]
            x = temp / Sigma[i, i]
        end
    end

    return x
end

x_1 = solve_linear_equation(U, Sigma, V, b)

println("Solution to Linear Least Square Problem (with SVD) x = ")
display(x_1)
