# Euler's Method

#=
    Euler's Method
        Given dy/dt = f(t, y); y(0) = y_0

        Taylor series:
            y(t + h) = y(t) + y'(t)*h + y''(t)*h^2/2 + . . .
                     = y(t) + f(t, y)*h + y''(t)*h^2/2 + . . .
        
        By ignoring the second-order and higher terms from the Taylor series, we get the Euler's method (EM):
            y_{k+1} = y_k + h_k*(f(t_k, y_k)),

            where y_k denote our approximation of y(t_k)

            Call h_k = t_{k+1} - t_k the step size. Use (0, y(0)) (given by the initial condition) as the first point.
=#

function f(t, y)
    return t/y
end

function EM(f::Function, h, y_0, n)
    res = zeros(n)
    t = 0

    res[1] = y_0

    for i in 2:n
        res[i] = res[i - 1] + h*f(t, res[i - 1])
        t += h
        i += 1
    end

    return res
end

x = EM(f, 0.5, 1, 10)

display(x)