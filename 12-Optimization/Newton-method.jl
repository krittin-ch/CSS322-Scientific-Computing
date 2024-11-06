# Newton's Method for One-Dimensional Optimization

#= 
    Newton's Method for One-Dimensional Optimization  
        The first three terms of Taylor series give 
            f(x + h) ≈ f(x) + f'(x)*h + 1/2*f''(x)*h^2

        if f(x^(k) + h) is minimized
        using the approximation, find h such that
            
            f(x^(k)) + f'(x^(k))*h + 1/2*f''(x^(k))*h^2 = g(h)
        is minimized

        The minimum of g(h) (if exists) is the point where
            g'(h) = f'(x^(k)) + f''(x^k)*h = 0
        That is, h = - f'(x^(k)) / f''(x^(k))

        So, x^(k) + h = x^(k) - f'(x^(k)) / f''(x^(k)) is a new approximation to the minimizer of f 

        x^(0) = initial guess 
        for k = 0, 1, 2, . . .
            x^(k + 1) = x^(k) - f'(x^(k)) / f''(x^(k))
        end

=# 

f(x) = 0.5 - x*exp(-x^2)

function diff_1(f::Function, x)
    h = 0.0001
    return (f(x + h) - f(x)) / h
end

function diff_2(f::Function, x)
    h = 0.0001
    return ( f(x + h) - 2*f(x) + f(x - h) ) / (h^2)   
end

function successive_parabolic_interpolation(f::Function, x, h)
    err = 0.001

    if err > abs(h)
        return x
    end

    d_1 = diff_1(f, x)
    d_2 = diff_2(f, x)

    h = - d_1 / d_2
    x += h
    println(x)

    successive_parabolic_interpolation(f, x, h)
end

x = successive_parabolic_interpolation(f, 1, 1)

println(x)