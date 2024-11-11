# Backward Difference Formulas (BDF)

#=
    Backward Difference Formulas (BDF)
        Simple BDF (first-order) is 
            y_{k+1} = y_k + h*f(t_{k+1}, y_{k+1})
        also known as Backward Euler (BE)

        It is an implicit method. Need to solve the equation to find y_{k+1}.

        Advantage of BDF over explicit methods is that BE is stable for any h > 0, that is unconditionally stable, 
        while explicit method, like EM, stable only if h < -2/a for a is in y'(t) = ay; a < 0.
=#

function f(t, y)
    return t/y
end

function construct_equation(t, y, next_y, h)
    return y + h*f(t, y) - next_y
end

function inv_difference(y_1, x_1, y_0, x_0)
    diff = (x_1 - x_0) / (y_1 - y_0)

    return diff
end

function secant_method(f::Function, y, h, init_1, init_2)
    err = 0.01
    
    x_1 = init_1
    x_2 = init_2
    E = 1

    f_k_1 = f(t, y, x_1, h)
    f_k_2 = f(t, y, x_2, h)

    while E > err
        inv_diff = inv_difference(f_k_2, x_2, f_k_1, x_1)
        E= f_k_2 * inv_diff
        x_1 = x_2
        x_2 -= E

        f_k_1 = f_k_2
        f_k_2 = f(t, y, x_2, h)
    end

    return x_2
end

function RK(f::Function, h, y_0, n)
    res = zeros(n)
    t = 0

    res[1] = y_0

    for i in 2:n
        x = secant_method(construct_equation(f, res[i - 1], 1, 2))
        res[i] = y + h*f(t, y)
        t += h
    end

    return res
end

x = RK(f, 0.5, 1, 10)

display(x)