# Gaussian Elimination with Complete Pivoting (GECP)
# Unlike GEEP, GECP exchange rows and columns to bring the largest uneliminated entry of a matrix to pivot position

using LinearAlgebra

function GECP(A::Matrix{Float64}, b::Vector{Float64})
    n = size(A, 1)
    # Combine A and b into an augmented matrix
    Ab = hcat(A, b)

    
    # Initialize permutation matrices
    row_perm = Vector{Float64}(1:n)
    col_perm = Vector{Float64}(1:n)
    
    for i in 1:n
        # Find the maximum element in the remaining submatrix
        max_val, max_index = findmax(abs.(Ab[i:n, i:n]))

        p, q = Tuple(max_index)
        
        # Adjust indices
        p += i - 1
        q += i - 1
        
        # Swap rows
        Ab[[i, p], :] = Ab[[p, i], :]
        
        # Swap columns
        Ab[:, [i, q]] = Ab[:, [q, i]]
        
        println("xxxx")
        # Record permutations
        row_perm[[i, p]] = row_perm[[p, i]]
        println("xxxx")
        col_perm[[i, q]] = col_perm[[q, i]]
        println("xxxx")
        
        
        
        # Perform elimination
        for j in i+1:n
            factor = Ab[j, i] / Ab[i, i]
            Ab[j, i:n+1] -= factor * Ab[i, i:n+1]
            println("yyyyy")
        end
    end

    # Back substitution
    x = zeros(Float64, n)
    for i in n:-1:1
        x[i] = (Ab[i, n+1] - Ab[i, i+1:n] * x[i+1:n]) / Ab[i, i]
    end

    # Reorder x based on column permutations
    x[col_perm] = x

    return x
end

A = [2.0 4.0 -2.0;
     4.0 9.0 -3.0;
     -2.0 -3.0 7.0]

b = [2.0; 8.0; 10.0]

x = GECP(A, b)
println("Solution: ", x)
