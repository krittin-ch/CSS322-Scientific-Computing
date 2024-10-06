# Polynomial Interpolation

#=
    Polynomial Interpolation

    Look for polynomial 'f' that interpolates the data
        1. Simplest and most common interpolation 
        2. Continuous and differentiable
        3. Easy to evaluate
        4. Easy to compute its derivatives and antiderivatives
=#

#=
    Monomial Basis

    To interpolate n data points, we choose to use a polynomial of degree n-1

    Polynomial in monomial basis: p_{n-1}(t) = x_1 + x_2*t + x_3*t^2 + . . . + x_n*t^{n-1}

    x_i's are coefficients to be determined
    
    Often written as p_{n-1}(t) = Σ_{j=1}^{n} x_j*ϕ_j(t)
    where ϕ_j(t) = t^{j-1} are the monomial basis functions    
=#

#=
    To find x_i's 
    Data points: (t_1, y_1), (t_2, y_2), . . ., (t_n, y_n)

    Require p_{n-1}(t) to satisfy p_{n-1}(t) = y_i for all i 

    Recall:
        p_{n-1}(t_1) = x_1 + x_2*t_1 + x_3*t_1^2 + . . . + x_n*t_1^{n-1} = y_1
        p_{n-1}(t_2) = x_1 + x_2*t_2 + x_3*t_2^2 + . . . + x_n*t_2^{n-1} = y_2
                                                                         .
                                                                         .
                                                                         .
        p_{n-1}(t_n) = x_1 + x_2*t_n + x_3*t_n^2 + . . . + x_n*t_n^{n-1} = y_n

    In matrix form:

        A = [
            1 t_1 t_1^2 . . . t_1^{n-1}
            1 t_1 t_1^2 . . . t_1^{n-1}
            .           .        .
            .             .      .
            .               .    .
            1 t_1 t_1^2 . . . t_1^{n-1}
        ]

        x = [x_1; x_2; . . .; x_n]
        y = [y_1; y_2; . . .; y_n]

        Tx = y

        Matrix A is called Vandermonde matrix

        The Vandermonde matrix is nonsingular matrix if the t_i's are all distinct
=#

using LinearAlgebra
using Plots

function swapRow(A::Matrix, currRow, pivRow)
    A[[currRow, pivRow], :] = A[[pivRow, currRow], :]
end

function LU_factorization(A::Matrix)
    n = size(A, 1)
    L = zeros(n, n)
    U = deepcopy(A)
    P = Matrix{Float64}(I, n, n)

    for i in 1:n 
        piv = argmax(abs.(U[i:n, i])) + (i - 1)

        if i != n && piv != i
            swapRow(U, i, piv)
            swapRow(L, i, piv)
            swapRow(P, i, piv)
        end

        for j in i+1:n
            factor = U[j, i] / U[i, i]
            L[j, i] += factor 
            U[j, :] -= factor*U[i, :]
        end

        L[i, i] = 1
    end

    return L, U, P    
end

function forward_substitution(L::Matrix, b_hat::Vector)
    n = size(L, 1)
    w = zeros(n)
    
    for i in 1:n 
        w[i] = b_hat[i] / L[i, i]
        
        for j in i+1:n 
            b_hat[j] -= L[j, i]*w[i]
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
            w[j] -= U[j, i]*x[i]
        end
    end
    
    return x
end

function solve_linear_equation(A::Matrix, b::Vector)
    L, U, P = LU_factorization(A)
    b_hat = P*b

    w = forward_substitution(L, b_hat)
    x = backward_substitution(U, w)

    return x
end

function construct_Vandermonde_matrix(v::Vector)
    n = size(v, 1)
    A = zeros(n, n)

    for i = 1:n
        A[:, i] = v.^(i - 1)
    end

    return A
end

function output_polynomial(v::Vector, x::Vector)
    n = size(v, 1)
    A = zeros(n, n)

    for i = 1:n
        A[:, i] = v.^(i - 1)
    end

    return A*x
end

p = -2:0.01:2
num = 10
random_indices = rand(1:length(p), num)
v = p[random_indices]
y = v.^4

random_indices = rand(1:length(p), num)
v_test = p[random_indices]

A = construct_Vandermonde_matrix(v)

x = solve_linear_equation(A, y)

y_test = output_polynomial(v_test, x)

scatter(v, y, label="Training Data", legend=:topright)
scatter!(v_test, y_test, label="Test Data")
plot!(p, p.^4, label=nothing)

path = "7-Interpolation/"

savefig(path * "output_polynomial.png")


points = Matrix{Float64}([
    -5 -12;
    -4 9;
    -3 -5;
    -2 7;
    0 -1;
    1 4;
    2 -2;
    3 10;
    4 -3;
    5 11
])

t = points[:, 1]
y = points[:, 2]

A = construct_Vandermonde_matrix(t)
x = solve_linear_equation(A, y)

function extract_interpolated_function(range::Vector, x::Vector)
    n = size(range, 1)
    m = size(x, 1)
    res = zeros(n)

    for i in m:-1:2
        res .+= x[i]
        res .*= range
    end

    res .+= x[1]

    return res
end

range = collect(-5:0.1:5)
pred = extract_interpolated_function(range, x)

scatter(t, y, label=nothing)
plot!(range, pred, label=nothing)

savefig(path * "output_monobial_basis.png")
