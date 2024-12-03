# System of First Order Differenctial Equation 

#=
    System of First Order Differenctial Equation 

        y'(t) = [ dy_1(t)/dt; dy_2(t)/dt; . . .; dy_n(t)/dt ]
              = [ f_1(t, y); f_2(t, y); . . .; f_n(t, y) ]
              = f(t, y)
=#

h = 0.2

y_0 = Vector{Float64}([-2; 1])

function ode(t, y_1, y_2)
    sys_ode = Vector{Float64}([
        t*y_2 - y_1;
        2*y_1^2*y_2 + t^2
    ])

    #=
        y'' = t + y + y'

        u_1 = y
        u_2  y'

        u_1' = u_2
        u_2' = t + u_1 + u_2

        [u_1'; u_2'] = [u_2; t + u_1 + u_2]

        Solve like normal ode
    =#
    

    # sys_ode = Vector{Float64}([
    #     y_2;
    #     t + y_1 + y_2;
    # ])

    return sys_ode
end

function EM(f::Function, h, y_0, n)
    res = zeros(n, 2)
    t = 0

    res[1, :] = y_0

    for i = 2:n
        res[i, :] = res[i-1, :] + h*f(t, res[i-1, 1], res[i-1, 2])
        t += h
    end

    return res
end

x = EM(ode, h, y_0, 10)

display(x)