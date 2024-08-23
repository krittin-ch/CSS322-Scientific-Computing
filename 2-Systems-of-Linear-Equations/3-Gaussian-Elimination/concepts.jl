#=
    Gaussian Elimination (GE) Concepts :
        Gaussian Elimination processes the input square matrix and returns as the trianglur matrix

        A = Matrix([
            1 2 1;
            -3 1 1;
            1 0 3
        ])

        then the returned matrix is
        
        A = Matrix([
            1 2 1;
            0 7 4;
            0 0 22/7
        ])

        Eliminate a_ik by

        (Row i) -= (a_ik/a_kk) * (Row k)

        a_kk is called `pivot`
        (a_ik/a_kk) is called `multiplier`
=#

A = Matrix([
    1 2 1;
    -3 1 1;
    1 0 3
])

b = Vector([-1; 0; 1])

A_size = size(A)
b_size = size(b)

function Gaussian_elimination_UTM(mat, b)
    mat_size = size(mat)

    mat = convert(Matrix{Float64}, mat)
    b = convert(Vector{Float64}, b)

    for k in 1:mat_size[1]          # column to eliminate

        if mat[k, k] == 0
            error("Zero pivot element encountered")
        end

        for i in k+1:mat_size[2]    # row to eliminate
            factor = mat[i, k] / mat[k, k]
            mat[i, :] -= factor * mat[k, :]
            b[i] -= factor * b[k]
        end
    end

    return mat, b
end

function Gaussian_elimination_LTM(mat, b)
    mat_size = size(mat)

    mat = convert(Matrix{Float64}, mat)
    b = convert(Vector{Float64}, b)

    for k in mat_size[1]:-1:1

        if mat[k, k] == 0
            error("Zero pivot element encountered")
        end

        for i in k-1:-1:1
            factor = mat[i, k] / mat[k, k]
            mat[i, :] -= factor * mat[k, :]
            b[i] -= factor * b[k]
        end
    end

    return mat, b
end

# utm or upper_triangular_matrix
# using concerrent for-loop
using Base.Threads

function solve_linear_equation_UTM(utm, b)
    utm_size = size(utm)
    res = zeros(Float64, utm_size[1], 1)
    b = convert(Vector{Float64}, b)

    @threads for j in utm_size[1]:-1:1
        if utm[j, j] == 0
            println("The provided matrix is singular")
        end
        
        res[j] = b[j] / utm[j, j]

        @sync for i in 1:j-1
            @spawn b[i] -= utm[i, j] *  res[j]
        end
    end

    return res
end

function solve_linear_equation_LTM(ltm, b)
    ltm_size = size(ltm)
    res = zeros(Float64, ltm_size[1], 1)
    b = convert(Vector{Float64}, b)

    @threads for j in 1:ltm_size[1]
        if ltm[j, j] == 0
            println("The provided matrix is singluar")
            break
        end

        res[j] = b[j] / ltm[j, j]

        @sync for i in j+1:ltm_size[1] 
            @spawn b[i] -= ltm[i, j] * res[j]
        end
    end

    return res
end

println("The upper triangular matrix of matrix A : ")
U, b_u = Gaussian_elimination_UTM(A, b)
display(U)

x1 = solve_linear_equation_UTM(U, b_u)
println("The linear equation results : ")
display(x1)
println()

println("The lower triangular matrix of matrix A : ")
L, b_l = Gaussian_elimination_LTM(A, b)
display(L)

x2 = solve_linear_equation_LTM(L, b_l)
println("The linear equation results : ")
display(x2)
println()

function solve_linear_equation(A, b)
    A = convert(Matrix{Float64}, A)
    b = convert(Vector{Float64}, b)
    U, b_u = Gaussian_elimination_UTM(A, b)
    
    return solve_linear_equation_UTM(U, b_u)
end

res = solve_linear_equation(A, b)
println("The linear equation results : ")
display(res)
