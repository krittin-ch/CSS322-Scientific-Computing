# Newton-Cotes Quadrature

#=
    Newton-Cotes Quadrature

    Names for interpolatory quadrature rules with  equally-spaced nodes:
        An n-point open Newton-Cotes rule has nodes 
            x_i = a + i*(b - a)/(n + 1) for i = 1, . . ., n

        An n-point closed Newton-Cotes rule has nodes 
            x_i = a + (i - 1)*(b - a)/(n - 1) for i = 1, . . ., n

    Examples of Newton-Cotes quadrature rules 
        1. The midpoint rule: 1-point open Newton-Cotes
            M(f) = (b - a)f((a + b)/2)
        
        2. The trapezoid rule: 2-point closed Newton-Cotes 
            T(f) = (b - a)/2 * (f(a) + f(b))
            
        3. Simpson's rule: 3-point closed Newton-Cotes
            S(f) = (b - a)/6 * (f(a) + 4*f((a + b)/2) + f(b))
=#

function midpoint_rule(a, b, func)
    return (b - a)*func((a + b)/2)
end

function trapezoid_rule(a, b, func)
    return ((b - a)/2) * (func(a) + func(b))
end

function Simpson_rule(a, b, func)
    return ((b - a)/6) * (func(a) + 4*func((a + b)/2) + func(b))
end

# M_k(f) = Σ_{j=1}^{k} (x_j - x_{j-1}) * f((x_{j-1} + x_j)/2) 
function composite_midpoint_rule(a, b, func)
    res = 0
    k = 100
    step = (b - a)/k
    for x in a:step:b-step
        res += step*(func(x + step/2))
    end

    return res
end

# T_k(f) = Σ_{j=1}^{k} ((x_j - x_{j-1})/2) * (f(x_{j-1}) + f(x_j)) 
function composite_trapezoid_rule(a, b, func)
    res = 0
    k = 100
    step = (b - a)/k
    for x in a:step:b-step
        res += step/2 * (func(x) + func(x + step))
    end

    return res
end

a = 0
b = 1
f(x) = exp(-x^2)

println("Midpoint Rule (a = 0, b = 1) of f(x) = exp(-x^2): ", midpoint_rule(a, b, f))
println("Trapezoid Rule (a = 0, b = 1) of f(x) = exp(-x^2): ", trapezoid_rule(a, b, f))
println("Simpson's Rule (a = 0, b = 1) of f(x) = exp(-x^2): ", Simpson_rule(a, b, f))
println("Composite Midpoint Rule (a = 0, b = 1) of f(x) = exp(-x^2): ", composite_midpoint_rule(a, b, f))
println("Composite Trapezoid Rule (a = 0, b = 1) of f(x) = exp(-x^2): ", composite_trapezoid_rule(a, b, f))