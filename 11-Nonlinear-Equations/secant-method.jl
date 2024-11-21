# Secant Method

#=
    Secant Method
    
    Drawback of Newton's Method: must evaluate f(x^(k)) and f'(x^(k)) at each iteration. These may be expensive to be evaluated.
        To reduce these evaluations, use the approximation,
            f'(x^(k)) ≈ ( f(x^(k)) - f(x^(k-1)) ) / ( x^(k) - x^(k-1) )
            
        Based on the idea from finite difference, f(x^(k)) and f(x^(k-1)) need to be evalulated anyway so no additional evaluations to get f'(x^(k))

        That is
            x^(0), x^(1) = initial guesses

            for k = 1, 2, . . .
                x^(k+1) = x(k) - f(x^(k)) * ( x^(k) - x^(k-1) ) / ( f(x^(k)) - f(x^(k-1)) )
            end

    Comparing to Newton's method, secant method 
        1. Requires only one new function evaluation per iteration.
        2. But needs two starting guesses.
        3. Converges a bit more slowly (superlinearly)
=#

f(x) = log10(x) - (8 - x^2)

function inv_difference(y_1, x_1, y_0, x_0)
    diff = (x_1 - x_0) / (y_1 - y_0)

    return diff
end

function secant_method(f::Function, init_1, init_2)
    err = 0.0001
    
    x_1 = init_1
    x_2 = init_2
    h = 1

    f_k_1 = f(x_1)
    f_k_2 = f(x_2)

    println("x_0 = ", x_1, " f_0 = ", f_k_1)
    println("x_1 = ", x_2, " f_1 = ", f_k_2)
    
    while abs(h) > err
        inv_diff = inv_difference(f_k_2, x_2, f_k_1, x_1)
        h = f_k_2 * inv_diff
        x_1 = x_2
        x_2 -= h

        f_k_1 = f_k_2
        f_k_2 = f(x_2)
    
        println("x = ", x_2, " f(x) = ", f_k_2)
        println()
    end

    return x_2
end

x = secant_method(f, 5, 4)

println("root x: ", x)
println("f(x = ", x, "): ", f(x))

println(f(5))