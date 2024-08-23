#=

    The Gaussian Elimination with Partial Pivoting (GEPP)

    Pivot :
        Before each elimination step, exchange rows of matrix so that 
        the element with the max absolute value in the pivot column, 
        among uneliminated entries, is brought to the pivot position.

    Example :

        A = Matrix([
            2 4 5;
            1 -1 -1;
            3 -2 1
        ])

        b = Vector([3; -1; -5])

        For the first column, abs(3) is the maximum (among |2|, |1|, |3|) so swap Row 1 and 3 :

        A = Matrix([
            3 -2 1;
            1 -1 -1;
            2 4 5;
        ])

        b = Vector([-5; -1; -3])

        The eliminate the first column

        A = Matrix([
            3 -2 1;
            0 -1/3 -4/3;
            0 16/3 13/3;
        ])

        b = Vector([-5; 2/3; 19/3])

        Then find the pivot of the second column
=#

A = Matrix([
    2 4 5;
    1 -1 -1;
    3 -2 1
])

b = Vector([3; -1; -5])

function find_pivot(vec::Vector)
    return argmax(abs.(vec))
end

function swap_row(pivot::Int, curRow::Int, A::Matrix, b::Vector) 
    pivotVec = A[pivot, :]
    A[pivot, :] = A[curRow, :]
    A[curRow, :] = pivotVec

    pivotVal = b[pivot]
    b[pivot] = b[curRow]
    b[curRow] = pivotVal
end

function GEPP(A::Matrix, b::Vector)
    mat = convert(Matrix{Float64}, A)
    y = convert(Vector{Float64}, b)

    mat_size = size(mat, 1)

    for i in 1:mat_size
        if mat[i, i] == 0
            println("The provided matrix is singular")
            break
        end

        idx = find_pivot(mat[:, i])

        if idx != i && i != mat_size
            swap_row(i, idx, mat, y)
        end

        for j in i+1:mat_size
            factor = mat[j, i] / mat[i, i]
            mat[j, :] -= factor*mat[i, :]
            y[j] -= factor*y[i]
        end
    end

    return mat, y
end

function solve_linear_UTM(utm::Matrix, y::Vector)
    utm_size = size(utm, 1)

    res = zeros(utm_size)

    for j in utm_size:-1:1
        if utm[j, j] == 0
            println("The provided matrix is singular")
            break
        end

        res[j] = y[j] / utm[j, j]

        for i in 1:j-1
            y[i] -= utm[i, j] * res[j]
        end
    end

    return res
end

U, y = GEPP(A, b)

display(U)

display(y)

x = solve_linear_UTM(U, y)

display(x)