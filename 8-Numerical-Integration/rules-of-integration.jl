# Rules of integration

#=
    Midpoint Rule 
        Given polynomial p_{n-1}(t).
        
        Q_n(f) = ∫_{a}^{b} p_{n-1}(x) dx 

        If 
            f = x^0, Q_n(f=x^0) = b - a
            f = x^1, Q_n(f=x^1) = (b^2 - a^2) / 2
            f = x^2, Q_n(f=x^2) = (b^3 - a^3) / 3
                        .
                        .
                        .
            f = x^{n-1}, Q_n(f=x^{n-1}) = (b^n - a^n) / n

        With these equations, we can construct

        A = [
            1            1      . . .    1
            x_1         x_2     . . .   x_n
             .           .               .
             .                .          .
             .                     .     .
            x_1^{n-1} x_2^{n-1} . . . x_n^{n-1}
        ]

        w = [w_1; w_2; . . .; w_n]

        q = [
                b - a
            (b^2 - a^2) / 2 
                  .
                  .
                  .
            (b^2 - a^2) / 2 
        ]

        Hence, A*w = q  (moment equations)

        This equation is known as the method of undetermined coefficients
=#

using LinearSolve


# Trapezoid Rule 
a = 0
b = 1

A_1 = Matrix{Float64}([
    1 1;
    a b
])

q_1 = Vector{Float64}([
    b - a;
    (b^2 - a^2) / 2
])

prob_1 = LinearProblem(A_1, q_1)
w_1 = solve(prob_1).u

#=
    For polynomial with n-1 = 1

    Q_2(f) = ∫_{a}^{b} p_{1}(x) dx 
           = w_1 * f(x_1) + w_2 * f(x_2)
           = w_1 * x_1 + w_2 * x_2          as f(x) = x
    Q_2(f) = ((b - a) / 2) * (f(a) + f(b))

    THis is known as the trapezoid rule
=#

# 1-Point Quadrature Rule
A_2 = 1
q_2 = b - a

w_2 = q_2 / A_2

#=
    For polynmial with n-1 = 0

    Q_1(f) = w_1 * x_1 = (b - a) * f(a) as w_1 = b - a and x_1 = a (f(x) = x for x is any integer)
=#

# 2-Point Quadrature Rule
A_3 = Matrix{Float64}([
    1 1;
    (a+b)/3 2/3*(a+b)
])

q_3 = Vector{Float64}([b-a; (b^2 - a^2)/2])
prob_3 = LinearProblem(A_3, q_3)
w_3 = solve(prob_3).u