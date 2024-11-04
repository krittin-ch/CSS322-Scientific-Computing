# Systems of Nonlinear Equations

#=
    Systems of Nonlinear Equations

        f(x) = [f_1; f_2; . . .; f_m] such that f_i = f_i(x_1, x_2, . . ., x_n)

        Jacobian of f(x) = ∇f(x) = [
                                        ∂f_1/∂x_1   ∂f_1/∂x_1 . . .  ∂f_1/∂x_n
                                        ∂f_2/∂x_1   ∂f_2/∂x_2 . . .  ∂f_2/∂x_n
                                            .                 .          .
                                            .                   .        .
                                            .                     .      .
                                        ∂f_m/∂x_1   ∂f_m/∂x_2 . . .  ∂f_m/∂x_n
                                    ]

        For example,
            f(x) = [x_1^2*x_2; x_1 + 3*x_1*x_2]
            
            ∇f(x) = [
                        2*x_1*x_2   x_1^2
                        1 + 3*x_2   3*x_1
                    ]


    Newton's Method for System of Nonlinear Equations
        f(x + h) ≈ f(x) + ∇f(x)h

        We want to find h such that f(x^(k) + h) = 0
        That is, f(x^(k)) + ∇f(x^(k))h = 0
                                     h = -( ∇f(x^(k)) )^-1 * f(x^(k))

        If ∇f(x) is not a square matrix,
            h = -( ∇f(x^(k))^T * ∇f(x^(k)) )^-1 * ∇f(x^(k))^T * f(x^(k))

            for A = -( ∇f(x^(k))^T * ∇f(x^(k)) )^-1, b = ∇f(x^(k))^T * f(x^(k))
=#

using LinearAlgebra

function sys_nonlinear(x_1, x_2)
    vec = Vector{Float64}([
        x_1^2*x_2-1;
        x_1+3*x_1*x_2-4;
    ])

    return vec
end


function create_Jacobian(x_1, x_2)
    h = 0.001

    n = sys_nonlinear(x_1, x_2)

    d_1 = sys_nonlinear(x_1+h, x_2) - n
    d_2 = sys_nonlinear(x_1, x_2+h) - n

    J = [d_1 d_2] ./ h

    return J
end

function swap_row(A::Matrix, i, j)
    A[[i, j], :] = A[[j, i], :]
end

function LU_factorization(A::Matrix)
    n = size(A, 1)
    L = zeros(n, n)
    U = deepcopy(A)
    P = Matrix{Float64}(I, n, n)

    for i in 1:n
        idx = argmax(abs.(U[i:n, i])) + i - 1

        if idx != i
            swap_row(U, i, idx)
            swap_row(L, i, idx)
            swap_row(P, i, idx)
        end

        for j in i+1:n
            factor = U[j, i] / U[i, i]
            L[j, i] = factor
            U[j, :] -= factor * U[i, :]
        end
    end

    L += Matrix{Float64}(I, n, n)

    return P, L, U
end

function forward_substitution(L::Matrix, b::Vector)
    n = size(L, 1)
    w = zeros(n)

    for i in 1:n
        w[i] = b[i] / L[i, i]

        for j in i+1:n 
            b[j] -= w[i] * L[j, i]
        end
    end

    return b
end

function backward_substitution(U::Matrix, w::Vector)
    n = size(U, 1)
    x = zeros(n)

    for i in n:-1:1
        x[i] = w[i] / U[i, i]

        for j in 1:i-1
            w[j] -= x[i] * U[j, i]
        end
    end

    return x
end

function solve_linear_equation(A::Matrix, b::Vector)
    P, L, U = LU_factorization(A)

    b_hat = P * b

    w = forward_substitution(L, b_hat)
    x = backward_substitution(U, w)

    return x
end

function Newton_method_1_loop(x_1, x_2)
    curr = sys_nonlinear(x_1, x_2)
    J = create_Jacobian(x_1, x_2)

    A = - transpose(J) * J
    b = transpose(J) * curr

    h = solve_linear_equation(A, b)

    return h
end

function solve_nonlinear_equation(x_1, x_2)
    err = 0.01
    h = 1

    while abs.(sum(h)) > err
        h = Newton_method_1_loop(x_1, x_2)

        x_1 += h[1]
        x_2 += h[2]
    end

    return x_1, x_2
end

x_1, x_2 = solve_nonlinear_equation(2, 0)

println("x_1 = ", x_1)
println("x_2 = ", x_2)