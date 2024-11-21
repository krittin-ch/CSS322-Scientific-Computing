# Newton's Method

#=
    Newton's Method
        The first two terms of Taylor series give 
            f(x + h) ≈ f(x) + f'(x)*h

        Suppose we know a point x^(k) that is close to a root.
        We want to find h such that f(x^(k) + h) = 0 
        
        Using the approximation, let us instead find h such that 
            f(x^(k)) = f'(x^(k))*h = 0

        That is h = -f(x^(k)) / f'(x^(k))

        We need to repeat the process 

            x^(0) = initial guess 

            for k = 0, 1, 2, . . .
                x^(k + 1) = x^(k) - f(x^(k)) / f'(x^(k))
            end

        
    Proporties of Newton's Method
        If the initial point x^(0) is close enough to a simple root, Newton's method converges quadratically.
            If too far, it may converge more slowly or may not converge at all.

        Newton's method generally does not converge to a singlar root (i.e. a root x* where f'(x*) = 0)
        or if it does, it does so very slowly (linear convergence at best).
=#

f(x) = log(x) - (8 - x^2)

function forward_difference(f::Function, x)
    h = 0.001
    diff = (f(x + h) - f(x)) / h

    return diff
end


function Newton_method(f::Function, init_guess)
    err = 0.01

    x = init_guess
    h = 1

    println("x_0 = ", x, "f_0 = ", f(x))

    while h > err
        h = f(x) / forward_difference(f, x)
        x -= h
        println("x = ", x, " f(x) = ", f(x))
        println()
    end

    return x
end

x = Newton_method(f, 5)

println("root x: ", x)
println("f(x = ", x, "): ", f(x))