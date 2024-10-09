# Taylor-Series Methods

#=
    Basic Methods for first-order derivative
        1. Forward Difference: f'(x) = (f(x + h) - f(x))/h + O(h); error is O(h)
        2. Backward Difference: f'(x) = (f(x) - f(x - h))/h + O(h); error is O(h)
        3. Centered Difference: f'(x) = (f(x + h) - f(x - h))/(2h) + O(h^2); error is O(h^2)
        4. Custom: f'(x) = (f(x + 4h) - 4f(x - 2h) + 3f(x))/(12h) + O(h^2); error is O(h^2)
=#

function forward_difference(func, x, h=0.1)
    return (func(x + h) - f(x)) / h
end

function backward_difference(func, x, h=0.1)
    return (func(x) - f(x - h)) / h
end

function centered_difference(func, x, h=0.1)
    return (func(x + h) - f(x - h)) / (2*h)
end

f(x) = 2*x^4 - 3*x^3

println("First-Order Derivative")
println("h = 0.1")
println("Forward Difference of f(x) = 2x^4 - 3x^3: ", forward_difference(f, 2))
println("Backward Difference of f(x) = 2x^4 - 3x^3: ", backward_difference(f, 2))
println("Centered Difference of f(x) = 2x^4 - 3x^3: ", centered_difference(f, 2))
println()

println("h = 0.00001")
println("Forward Difference of f(x) = 2x^4 - 3x^3: ", forward_difference(f, 2, 0.00001))
println("Backward Difference of f(x) = 2x^4 - 3x^3: ", backward_difference(f, 2, 0.00001))
println("Centered Difference of f(x) = 2x^4 - 3x^3: ", centered_difference(f, 2, 0.00001))
println()

#=
    Basic Method for second-order derivative
        1. Centered Difference: (f(x + h) - 2f(x) + f(x - h))/(h^2)
=#
function second_order_centered_difference(func, x, h=0.1)
    return (func(x + h) - 2*func(x) + func(x - h)) / (h^2)
end

println("Secnod-Order Derivative")
println("Centered Difference of f(x) = 2x^4 - 3x^3: ", second_order_centered_difference(f, 1))
println()
