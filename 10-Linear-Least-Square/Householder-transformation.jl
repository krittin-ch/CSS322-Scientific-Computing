# Householder Transformation

#=
    Let v is a nonzero vector of size m 
        H = I - 2*((v * v^T) / (v^T * v))
    is called a Householder transform/reflection/matrix 

    Theorem: H is symmetric and orthogonal

    Given a vector a (the first column of matrix A), we want a Householder transform such that
        Ha = αe_1 = [α; 0; 0; . . .; 0]
    for some scalar α. (α e_1 is going to be the first column of R)

    Ha = αe_1 is satisfied by taking v := a - αe_1 and setting α = ±||a||_2

    So, if a = [a_1; a_2; . . .; a_m], v := [a_1 - α; a_2; . . .; a_m]
    Therefore, we should choose the sign of α to avoid cancellation in the formula for v

    That is, α has the opposite sign from a_1
        α = -sign(a_1) ||a||_2


    QR factorization

    Given A is an m-by-n matrix, write A as A = [a B] where a is a vector of size m and B is a matrix of dimension m × n-1

    By choosing H as in the previous slide (call it H_1 and the corresponding values v_1 and α_1 now), we have 
        H_1 A = H_1 [a B]
              = [H_1*a H_1*B]
              = [[α_1; 0; 0; . . .; 0] H_1*B]
              = [α_1 w^T
                  0  A_2]
        where w^T is a row vector of size n-1, 0 is a column vector of size m-1, and A_2 is all of H*B_1 but the first row

        We can recursively do the same thing on the submatrix A_2 to find QR factorization

        We will get 
            H_n * H_{n-1} * . . . * H_1 * A = R
                                          A = H_1 * H_2 * . . . * H_n * R

            That is Q = H_1 * H_2 * . . . * H_n
=#

using LinearAlgebra
using LinearSolve

A = Matrix{Float64}([
    1 5 3;
    2 -1 3;
    -2 2 1;
    2 0 3
])

b = Vector{Float64}([2; 0; 1; 0])

function Householder_multiplication(v, u)
    return u - 2 * (transpose(v) * u) / (transpose(v) * v) * v
end

function Householder_transformation(A, b)
    m, n = size(A)
    a = A[:, 1]

    alpha = a[1] > 0 ? -norm(a, 2) : norm(a, 2)

    e_1 = zeros(size(a))
    e_1[1] = 1

    v = a - alpha * e_1

    A[:, 1] .= 0
    A[1, 1] = alpha
    
    for i in 2:n
        A[:, i] = Householder_multiplication(v, A[:, i])
    end

    b = Householder_multiplication(v, b)

    return A, b
end

function QR_factorization(A, b)
    m, n = size(A)

    A, b = Householder_transformation(A, b)

    if m >= 2 && n >=2 
        A[2:end, 2:end], b[2:end] = QR_factorization(A[2:end, 2:end], b[2:end])
    end

    return A, b
end

m, n = size(A)

R, c = QR_factorization(A, b)
R = R[1:n, :]
c = c[1:n]

# Backward Substitution
# R_1 * x = c

prob = LinearProblem(R, c)
x = solve(prob).u 

display(x)