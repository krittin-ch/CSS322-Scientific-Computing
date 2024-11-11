# Runge-Kutta Methods (RK)

#=
    Runge-Kutta Methods (RK) or Heun's Method
        y_{k+1} = y_k + h/2 * (s_1 + s_2)

        for s_1 = f(t_k, y_k)
            s_2 = f(t_k + h, y_k + h*s_1)
=#

function f(t, y)
    return t/y
end

function RK(f::Function, h, y_0, n)
    res = zeros(n)
    t = 0

    res[1] = y_0

    for i in 2:n
        s_1 = f(t, res[i - 1])
        s_2 = f(t + h, res[i - 1] + h*s_1)
        res[i] = res[i - 1] + (h/2)*(s_1 + s_2)
        t += h
    end

    return res
end

x = RK(f, 0.5, 1, 10)

display(x)