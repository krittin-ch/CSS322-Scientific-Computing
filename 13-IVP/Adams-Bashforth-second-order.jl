# Adams-Bashforth Second Order (AB2)

#=
    Adams-Bashforth Second Order (AB2)
        y_{k+1} = y_k + 3h/2*f(t_k, y_k) - h/2*f(t_{k-1}, y_{k-1}) approximated from Taylor series
=#

function f(t, y)
    return t/y
end

function AB2(f::Function, h, y_0, n)
    res = zeros(n)
    t = 0

    res[1] = y_0
    res[2] = res[1] + 3*h/2 * f(t, res[1])

    t += h

    for i in 3:n
        res[i] = res[i - 1] + (3*h/2) * f(t, res[i - 1]) - (h/2) * f(t-h, res[i - 2])
        t += h
    end

    return res
end

x = AB2(f, 0.5, 1, 10)

display(x)