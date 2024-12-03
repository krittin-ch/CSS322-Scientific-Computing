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

function construct_equation(f::Function, t, y, next_y, h)
    return y + h*f(t, next_y) - next_y
end

function forward_difference(f::Function, x)
    h = 0.001
    diff = (f(x + h) - f(x)) / h

    return diff
end

function Newton_method(f::Function, t, y, init_next_y, h)
    err = 0.001

    x = init_next_y
    E = 1

    while abs(E) > err
        eq_value = construct_equation(f, t, y, x, h)
        derivative = forward_difference(x_val -> construct_equation(f, t, y, x_val, h), x)
        E = eq_value / derivative
        x -= E
    end

    return x 
end


function RK(f::Function, h, y_0, n)
    res = zeros(n)
    t = 0

    res[1] = y_0

    for i in 2:n
        t += h
        new_y = Newton_method(f, t, res[i-1], 1, h)
        res[i] = new_y
    end

    return res
end

x = RK(f::Function, 0.5, 1, 10)

display(x)

