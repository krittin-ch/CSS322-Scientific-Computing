# Newton Interpolation

#=
    Newton Interpolation can be written as a polynomial with degree n-1 as 
        p_{n-1}(t) = Σ_{j=1}^{n} x_j * π_j(t)
    
        where π_j(t) = Π_{k=1}^{j-1} (t - t_k)

    π_j(t) is known as the Newton basis function 

    That is
        π_1(t) = 1
        π_2(t) = (t - t_1)
        π_3(t) = (t - t_1)(t - t_2)
               .
               .
               .
        π_n(t) = (t - t_1)(t - t_2) . . . (t - t_{n-1}) 

    Since we require p_{n-1}(t_i) = y_i, 
        y_1 = x_1 
        y_2 = x_1 + x_2 * (t_2 - t_1)
        y_3 = x_1 + x_2 * (t_3 - t_1) + x_3 * (t_3 - t_1) * (t_3 - t_2)

    Hence, 

        A = [
            1        0                   0                    . . .          0
            1   (t_2 - t_1)              0                    . . .          0        
            1   (t_3 - t_1)   (t_3 - t_1)(t_3 - t_2)          . . .          0
            .                            .                                   .
            .                              .                                 .
            .                                .                               .
            1   (t_n - t_1)   (t_n - t_1)(t_n - t_2)   . . .   (t_n - t_1) . . . (t_n - t_n-1)
        ]

        x = [x_1; x_2; x_3; . . .; x_n]

        y = [y_1; y_2; y_3; . . .; y_n]
        
        A * x = y

    As Matrix `A` is a lower-triangular matrix, this system can be solved for `x` using forward substitution
=#

using Plots
using LinearAlgebra

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

function construct_Newton_interpolatin_matrix(t::Vector)
    n = size(t, 1)
    N = LowerTriangular(ones(n, n))

    for i in 2:n
        for j in i:n 
            N[j, i:j] *= t[j] - t[i - 1]
        end
    end

    return collect(N)
end

function forward_substitution(L::Matrix,  b::Vector)
    n = size(b, 1)
    res = zeros(n)
    y = deepcopy(b)

    for i in 1:n
        res[i] = y[i] / L[i, i]

        for j in i+1:n 
            y[j] -= res[i] * L[j, i]
        end
    end

    return res
end

function extract_interpolated_function(t::Vector, range::Vector, x::Vector)
    n = size(t, 1)
    m = size(range, 1)
    res = zeros(m)
    
    for i in 1:m 
        k = deepcopy(x)
        for j in 1:n-1
            k[j+1:n] *= range[i] - t[j]
        end
        res[i] += sum(k)
    end

    return res
end

N = construct_Newton_interpolatin_matrix(t)
x = forward_substitution(N, y)

range = collect(-5:0.1:5)
pred = extract_interpolated_function(t, range, x)

scatter(t, y, label=nothing)
plot!(range, pred, label=nothing)

path = "7-Interpolation/"

savefig(path * "output_Newton.png")