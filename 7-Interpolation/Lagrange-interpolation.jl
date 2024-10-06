# Lagrange Interpolation

#=
    Lagrange Interpolation 

    Difine Lagrange basis functions (a.k.a fundamental polynomials) as
        l_j(t) = [ Π_{k=1, k ≠ j}^{n} (t - t_k) ] / [ Π_{k=1, k ≠ j}^{n} (t_j - t_k) ] for j = 1, . . ., n 

    l_j(t) is a polynomial of degree n-1 
    but l_j(t_j) = 1 and l_j(t_i) = 0 for i ≠ j

    Therefore, p_{n-1}(t) = Σ_{j=1}^{n} x_j * l_j(t)

    So, 
        p_{n-1}(t_i) = Σ_{j=1}^{n} x_j * l_j(t_i) = x_i = y_i --> In other words, x_i = y_i
        
        That is, p_{n-1}(t) = Σ_{j=1}^{n} x_j * l_j(t) = Σ_{j=1}^{n} y_j * l_j(t)
=#

using Plots

points = Matrix{Float64}([
    -5 -12;
    -4 9;
    -3 -5;
    -2 7;
    0 -1;
    1 4;
    2 -2;
    3 10;
    4 -3;
    5 11
])

t = points[:, 1]
y = points[:, 2]

function Lagrange_interpolation(t_all::Vector, t_j::Float64, t::Float64)
    if t_j == t
        return 1 
    elseif t in t_all 
        return 0
    else
        n = 1
        m = 1
        for t_k in t_all
            if t_k != t_j 
                n *= t - t_k
                m *= t_j - t_k
            end
        end
        return n/m
    end
end

function extract_interpolated_function(t_all::Vector, y::Vector, range::Vector)
    n = size(range, 1)
    m = size(t_all, 1)
    res = zeros(n)

    for i in 1:n
        for j in 1:m 
            res[i] += y[j] * Lagrange_interpolation(t_all, t_all[j], range[i])
        end
    end

    return res
end

range = collect(-5:0.1:5)
pred = extract_interpolated_function(t, y, range)

scatter(t, y, label=nothing)
plot!(range, pred, label=nothing)

path = "7-Interpolation/"

savefig(path * "output_Lagrange.png")