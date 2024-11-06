# Unconstrained Optimization in Higher Dimension 

#=
    Unconstrained Optimization in Higher Dimension 
        1. If x* is a local minimizer of f, then ∇f(x*) = 0 and ∇^2(f(x*)) is symmetric positive semidefinite.
        This is called the necessary condtion of local minimizer

        2. If x* is a point such that ∇f(x*) = 0 and ∇^2(f(x*)) is symmetric positive semidefinite, then x is a local minimizer of f.
        This is called the sufficient condtion of local minimizer
    
    Newton's Method 
        Taylor series 
            f(x + h) ≈ f(x) + (∇f(x))^T * h + 1/2*h^T*(∇^2(f(x)))*h

        So, 
            x^(k+1) = x^(k) - (∇^2(f(x^(k))))^-1 * ∇f(x^(k))
=#

using LinearAlgebra
using LinearSolve

function sys(v::Vector)
    x_1 = v[1]
    x_2 = v[2]
    # return x_1^2 + 3*x_1*x_2 + x_2^2 - x_1*exp(x_2)
    return 0.5*x_1^2 + 2.5*x_2^2
end

function gradient(sys::Function, v::Vector)
    h = 0.0001
    res = zeros(size(v)) 
    f_v = sys(v)    
    
    for i in 1:size(v, 1)
        temp = deepcopy(v)
        temp[i] += h
        res[i] = sys(temp) - f_v
    end

    res ./= h

    return res
end

function gradient_2D(sys::Function, v::Vector)
    h = 0.0001
    res = zeros(size(v)) 
    f_v = sys(v)    
    
    for i in 1:size(v, 1)
        temp_1 = deepcopy(v)
        temp_2 = deepcopy(v)

        temp_1[i] += h
        temp_2[i] -= h
        
        res[i] = sys(temp_1) - 2*f_v + sys(temp_2)
    end

    res ./= h^2

    return res
end

function second_diff_2D(sys::Function, v::Vector)
    h = 0.0001
    n = size(v, 1)
    len = Int(n*(n-1)/2)
    res = zeros(len)

    for i in 1:n-1
        for j in i+1:n
            temp_1 = deepcopy(v)
            temp_2 = deepcopy(v)
            temp_3 = deepcopy(v)
            temp_4 = deepcopy(v)

            temp_1[i] += h
            temp_1[j] += h
            
            temp_2[i] += h
            temp_2[j] -= h
            
            temp_3[i] -= h
            temp_3[j] += h
            
            temp_4[i] -= h
            temp_4[j] -= h

            diff = sys(temp_1) - sys(temp_2) - sys(temp_3) + sys(temp_4)

            idx = (i - 1)*(n - 1) + (j - 1)

            res[idx] = diff
        end
    end

    return res
end

function Hessian(sys::Function, v)
    n = size(v, 1)
    mat = zeros(n, n)

    sec_diff_2D = second_diff_2D(sys, v)
    grad_2D = gradient_2D(sys, v)

    mat[CartesianIndex.(1:n, 1:n)] .= grad_2D

    # Place lower triangular elements (LTM)
    k = 1
    for i in 2:n
        for j in 1:i-1
            mat[i, j] = sec_diff_2D[k]
            k += 1
        end
    end

    # Place upper triangular elements (UTM)
    k = 1
    for i in 1:n-1
        for j in i+1:n
            mat[i, j] = sec_diff_2D[k]
            k += 1
        end
    end

    return mat
end

function Newton_method_1_loop(sys::Function, v::Vector)
    H = Hessian(sys, v)
    G = gradient(sys, v)

    p = LinearProblem(H, G)
    h = -solve(p).u

    return h
end

function optimization(sys::Function, v::Vector, h)
    err = 0.001

    println(v)

    if sum(abs.(h)) < err
        return v
    end

    next_h = Newton_method_1_loop(sys, v)
    next_v = v + next_h
    optimization(sys, next_v, next_h)
end

display(optimization(sys, [5., 1], [1., 2.]))