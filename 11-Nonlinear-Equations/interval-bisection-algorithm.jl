# Interval Bisection Algorithm

#=
    Bolzano's Theorem 
        If f is a continuous function on a closed interval [a, b], and f(a) and f(b) differ in sign, then there must be a root within the interval [a, b].

    By Bolzano's theorem, there are 2 cases (m = a + (b - a)/2)
        Case 1: f(m) has different sign from f(a)
            By Bolzano's theorem, there is a root f in [a, m]
        
        Case 2: f(m) has different sign from f(b)
            By Bolzano's theorem, there is a root f in [m, b]

        Repeat until the interval is small enough as required
=#

f(x) = x^2 - 3*x - 4
a = 3
b = 6

function interval_bisection_algorithm(f::Function, a, b)
    err = 0.1

    m = a + (b - a)/2

    if err > abs(f(m))
        return m
    end

    if sign(f(m)) > sign(f(a))
        interval_bisection_algorithm(f, a, m)
    else
        interval_bisection_algorithm(f, m, b)
    end
end

x = interval_bisection_algorithm(f, a, b)

println("root x: ", x)
println("f(x = ", x, "): ", f(x))