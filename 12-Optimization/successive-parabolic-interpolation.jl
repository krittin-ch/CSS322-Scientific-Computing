# Successive Parabolic Interpolation

#= 
    Successive Parabolic Interpolation  
        1. Initially, evaluate f at three points
        2. Find the quadratic interpolant that fits the three points
        3. The minimum of the parabola interpolant (assuming it has one) is taken as a new approximate minimum of the function

        At a given iteration, we have three points, say u, v, and w, with corresponding function values f_u, f_v, and f_w, 
        where v is the best approximate minimum of the function so far.

        The minimum of the parabola interpolating the three points is given by
            v* = 1/2 * ( (f_w - f_v)*(v^2 - u^2) + (f_u - f_v)*(w^2 - v^2) ) / ( (f_w - f_v)*(v - u) + (f_u - f_v)*(w - v) )
            u* = w
            w* = v
=# 

f(x) = 0.5 - x*exp(-x^2)

function new_mid_point(f::Function, u, v, w)
    return 1/2 * ( (f(w) - f(v))*(v^2 - u^2) + (f(u) - f(v))*(w^2 - v^2) ) / ( (f(w) - f(v))*(v - u) + (f(u) - f(v))*(w - v) ) 
end

function successive_parabolic_interpolation(f::Function, u, v, w)
    err = 0.01
    h = 1

    while abs(h) > err
        prev = f(v)
        x = new_mid_point(f, u, v, w)
        u = w
        w = v
        v = x
        curr = f(v)
        # h = curr - prev
        h -= 0.1
        println(v)
    end

    return v
end

x = successive_parabolic_interpolation(f, 0, 0.6, 1.2)

println(x)