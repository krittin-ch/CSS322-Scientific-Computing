#=
Data Fitting

    For an unkown quadratic equation: y = ct^2 + dt + e
    
    With 5 different coordinates: 
        y_1 = ct_1^2 + dt_1 + e
        y_2 = ct_2^2 + dt_2 + e
        y_3 = ct_3^2 + dt_3 + e
        y_4 = ct_4^2 + dt_4 + e
        y_5 = ct_5^2 + dt_5 + e

    Which is the same as solving

        A= [
            t_1^2 t_1 1
            t_2^2 t_2 1
            t_3^2 t_3 1
            t_4^2 t_4 1
            t_5^2 t_5 1
        ]

        x = [c; d; e]

        b = [y_1; y_2; y_3; y_4; y_5]

        That is, solve a linear system: Ax = b

    The system is overdetermined, as more rows than columns. So, in general ,there is no solution.
    That is, no quadratic function that passes through five data points.

    However, we can find x that minimize ||Ax - b||_2 (2-norm) which can be written as Ax ≊ b

Minimizing ||Ax - b||_2

    (||Ax - b||_2)^2 = (Ax - b)^T (Ax - b)
                     = x^T*A^T*A*x - x^T*A^T*b - b^T*A#*x + b^T*b  (b^T Ax is a scalar)
                     = x^T*A^T*A*x - 2b^T*A*x + b^T*b

Lemma 1: Suppose A has rank n. Then A^T A is symmetrix positive definite.
Lemma 2: f(x) = x^T Cx - 2h^T x + d, where X is symmetric positive definite. Then f has a unique minimizer at x* = C^-1 h.

We can conclude that x = (A^T A)^-1 A^T b by using Lemma (1) and (2)


Theorem: x = (A^T A)^- A^T b is the unique solution to the linear least squares problem when A has rank n

Method of Normal Equations
    Solve min_x ||Ax - b||_2 by 
        1. Form products A^T A and A^T b 
        2. Solve A^T ax = A^T b using Cholesky factorization

    (Assuming rank(A) = n, Lemma (1) tells us that A^T A is symmetric positive definite)
=#

function Cholesky_factorization(A::Matrix)
    n = size(A, 1)
    L = deepcopy(A)

    for k in 1:n
        L[k, k] = sqrt(L[k, k])
        L[k, k+1:n] .= 0
        
        for i in k+1:n 
            L[i, k] = L[i, k] / L[k, k]
        end
        
        for j in k+1:n 
            for i in k+1:n 
                L[i, j] -= L[i, k]*L[j, k]
            end
        end
    end

    return L
end

function forward_substitution(L::Matrix, b::Vector)
    n = size(L, 1)
    w = zeros(n)

    for i in 1:n
        w[i] =  b[i] / L[i, i]
        for j in i+1:n 
            b[j] -= L[j, i] * w[i]
        end
    end

    return w
end

function backward_substitution(L_T::Matrix, w::Vector)
    n = size(L_T, 1)
    x = zeros(n)

    for i in n:-1:1
        x[i] = w[i] / L_T[i, i]
        for j in 1:i-1
            w[j] -= L_T[j, i] * x[i]
        end
    end

    return x
end

function normal_equation(A::Matrix, b::Vector)
    L = Cholesky_factorization(transpose(A) * A)
    L_T = collect(transpose(L))

    w = forward_substitution(L, transpose(A) * b)
    x = backward_substitution(L_T, w)

    return x
end

A = Matrix{Float64}([
    1 1;
    3 3;
    5 55
])

b = Vector{Float64}([2; 4; 3])

x = normal_equation(A, b)

display(x)

using LinearAlgebra

y = [x; 1]

display(normalize(y))