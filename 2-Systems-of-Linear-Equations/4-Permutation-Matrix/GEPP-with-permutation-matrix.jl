
using LinearAlgebra


function swapRow(pivot::Int, curr::Int, mat::Matrix) 
    pivotRow = mat[pivot, :]
    mat[pivot, :] = mat[curr, :]
    mat[curr, :] = pivotRow
end

function swapEle(pivot::Int, curr::Int, vec::Vector) 
    pivotVal = vec[pivot]
    vec[pivot] = vec[curr]
    vec[curr] = pivotVal
end

function LUFactorization(A::Matrix)
    U = deepcopy(A)
    L = zeros(size(A))
    P = Matrix{Float64}(I, size(A))
    n = size(A, 1)
    v = zeros(n)

    for i in 1:n
        idx = argmax(abs.(U[i:n, i])) + (i - 1)

        if idx != i && i != n
            swapRow(idx, i, A)
            swapRow(idx, i, L)
            swapRow(idx, i, U)
            swapRow(idx, i, P)
        end
        
        for j in i+1:n
            factor = U[j, i] / U[i, i]
            L[j, i] += factor
            U[j, :] -= factor * U[i, :]
        end
    end 

    L += Matrix{Float64}(I, size(A))

    for i in 1:n
        idx = argmax(P[i, :])
        v[i] += idx
    end

    return L, U, P, v
end

A1 = Matrix{Float64}([
        -1 1 3;
        2 0 1;
        -3 -1 2
    ])

b1 = Vector([0; 0; 0])

L = Matrix(I, size(A1))

L, U, P, v = LUFactorization(A1)

println("Original Matrix : ")
display(A1)

println("Lower Triangular Matrix : ")
display(L)

println("Upper Triangular Matrix : ")
display(U)

println("Permutation Matrix : ")
display(P)

println("Permutation Vector : ")
display(v)

# println("A = transpose(P)*L*U : ")
# display(transpose(P) * L * U)

#=
    Solving Ax = b with GEPP

        1. Factor A = transpose(P) * L * U by GEPP
        2. Set b^ = P * b
        3. Solve L * w = b^ for w (forward substitution)
        4. Solve U * x = w for x (backward substitution)

    Verify :
        b^ = P * b
        transpose(P) * b^ = transpose(P) * P * b
        transpose(P) * b^ = b

        Ax = (transpose(P)LU)x = transpose(P)L(Ux) = transpose(P)(Lw) = transpose(Pp)b^
=#