# Broyden's Method

#=
    Broyden's Method
        One of the simplest and most effective secant updating methods

        x^(0) = initial guess
        B^(0) = initial Jacobian approximation

        for k = 0, 1, . . .
            Solve B^(k)*h(k) = -f(x^(k)) for h^(k) // Compute Newton-like step
            x^(k+1) = x(k) + h^(k)
            y^(k) = f(x^(k+1)) - f(x^(k))
            B^(k+1) = B^(k) + ( ( y^(k) - B^(k)*h^(k) ) * ( h^(k) )^T ) / ( (h^(k))^T * h^(k) )
        end

        The idea is we want B^(k+1) (which is the approximation of ∇f(x^(k+1))) to satisfy the secant equation 
            B^(k+1) * (x^(k+1) - x^(k)) = f(x^(k+1)) - f(x^(k))
=#

using LinearAlgebra

function sys_nonlinear(x_1, x_2, x_3)
    vec = Vector{Float64}([
        x_1 + x_2^2 + 2*x_3;
        x_1*x_3 - 3*x_2;
        2*x_2*x_3^2 + 1
    ])

    return vec
end

function create_Jacobian(x_1, x_2, x_3)
    h = 0.001

    n = sys_nonlinear(x_1, x_2, x_3)

    d_1 = sys_nonlinear(x_1+h, x_2, x_3) - n
    d_2 = sys_nonlinear(x_1, x_2+h, x_3) - n
    d_3 = sys_nonlinear(x_1, x_2, x_3+h) - n

    J = [d_1 d_2 d_3] ./ h

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

function Broyden_method_1_loop(x_1, x_2, x_3, J)
    curr = sys_nonlinear(x_1, x_2, x_3)

    A = - transpose(J) * J
    b = transpose(J) * curr

    h = solve_linear_equation(A, b)

    return h
end

function update_Jacobian(J::Matrix, y::Vector, h::Vector)
    a = transpose(h) * h
    b = (y - J*h) * transpose(h)

    return J + b./a
end

function solve_nonlinear_equation(x_1, x_2, x_3)
    err = 0.01
    h = 1

    y_k = 0
    # J = create_Jacobian(x_1, x_2, x_3)

    J = Matrix{Float64}(I, 3, 3)

    k = 0

    while k != 5
        h = Broyden_method_1_loop(x_1, x_2, x_3, J)

        println("J = ")
        display(J)

        println("x_1 = ", x_1)
        println("x_2 = ", x_2)
        println("x_3 = ", x_3)

        println()

        curr = sys_nonlinear(x_1, x_2, x_3)
        x_1 += h[1]
        x_2 += h[2]
        x_3 += h[3]
        
        next = sys_nonlinear(x_1, x_2, x_3)
        y_k = next - curr

        J = update_Jacobian(J, y_k, h)

        k += 1
    end

    return x_1, x_2, x_3
end

x_1, x_2, x_3 = solve_nonlinear_equation(1, -2, 1)

println("x_1 = ", x_1)
println("x_2 = ", x_2)
println("x_3 = ", x_3)

println(sys_nonlinear(1, -2, 1))