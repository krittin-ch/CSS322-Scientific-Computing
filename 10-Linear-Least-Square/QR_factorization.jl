# QR factorization

#=
    Given A is an m-by-n matrix, a QR factorization of A is
    A = QR for Q is an m-by-m orthogonal matrix and R is an m-by-n upper triangular matrix
            R = [R_1; 0] where R_1 is an n-by-n upper triangular matrix and 0 is an (m-n)-by-n zero matrix 

    To minimize ||Ax - b||_2 = ||QRx - b||_2 
    Let c = Q^T b. That is b = Qc 
        ||Ax - b||_2 = ||QRx - Qc||_2 
                     = ||Q(Rx - c)||_2 
                     = ||Rx - c||_2     (since ||Qx||_2 = ||x||_2)
                     = ||[R_1; 0]x - [c_1; c_2]||_2 
        where c = [c_1; c_2], c_1 is a vector of size n, and c_2 is a vector of size m-n 

        ||Ax - b||_2 = √(||R_1*x - c_1||_2^2 + ||c_2||_2^2)

        But as c_2 is a constant, the x that minimizes ||Ax - b||_2 is the one that minimizes ||R_1*x - c_1||_2

        If R_1 is nonsigular, then R_1*x = c_1 has a solution, which satisfies R_1*x - c_1 = 0, that is ||R_1*x - c_1||_2 = 0

    Theorem: Any matrix A of dimension m×n can be factored A = QR
    where Q is an m-by-m orthogonal matrix and R is an m-by-n upper triangular matrix.

    Theorem: If an m-by-n matrix A has rank n and A = QR is the QR factorization of A, R has rank n and R_1 is nonsigular

    Three main algorithms to solve QR factorization:
        1. Householder Transformation
        2. Givens Rotations
        3. Gram-Schmidt Algorithm
=#

import Pkg; Pkg.add("LinearSolve")
using LinearSolve

A = Matrix{Float64}([
    1 2;
    0 -2.4;
    0 1.8
])

m, n = size(A)

b = Vector{Float64}([-1; 0; 1])

# Assume Q and R are already factorized

Q = Matrix{Float64}([
    1 0 0;
    0 .8 .6;
    0 -.6 .8
])

R = Matrix{Float64}([
    1 2;
    0 -3;
    0 0
])

# Let c = Q^T * b
c = transpose(Q) * b
c_1 = c[1:n]    # since A is 3-by-2

# Solve R_1 * x = c_1 
R_1 = R[1:n]
prob_1 = LinearProblem(R_1, c_1)
x_1 = solve(prob_1).u

display(x_1)
