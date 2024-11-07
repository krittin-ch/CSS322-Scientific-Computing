# Broyden–Fletcher–Goldfarb–Shanno Method

#=
    Broyden–Fletcher–Goldfarb–Shanno (BFGS) Method
        Similar to Broyden's method, BFGS updates the approximation of the Hessian matrix each iteration

        x^(0) = initial guess 
        B^(0) = initial guess 

        for k = 0, 1, 2, . . .
            Solve B^(k)*h^(k) = -∇f(x^(k)) for h^(k)
            x^(k+1) = x^(k) + h^(k)
            y^(k) = ∇(x^(k+1)) - ∇f(x^(k))
            B^(k+1) = B^(k) + ( y^(k)*(y^(k))^T ) / ( (y^(k))^T * h^(k) ) - ( B^(k)*h^(k)*(h^(k))^T*B^(k) ) / ( (h^(k))^T*B^(k)*h^(k) )
        end
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

function BFGS_1_loop(sys::Function, B::Matrix, v::Vector)
    G = gradient(sys, v)

    p = LinearProblem(B, G)
    h = -solve(p).u

    next_v = v + h
    next_G = gradient(sys, next_v)

    y = next_G - G

    next_B = B 
    + (y * transpose(y)) / (transpose(y) * h) 
    - (B*h*transpose(h)*B) / (transpose(h)*B*h)

    return next_B, next_v, h
end

function optimization(sys::Function, v::Vector)
    n = size(v, 1)
    
    err = 0.001
    h = 1
    B = Hessian(sys, v)
    # B = Matrix{Float64}(I, n, n)
    
    while sum(abs.(h)) > err
        println(v)
        B, v, h = BFGS_1_loop(sys, B, v)
    end

    return v
end

display(optimization(sys, [5., 1]))