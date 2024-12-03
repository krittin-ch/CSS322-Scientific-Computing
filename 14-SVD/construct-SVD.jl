using LinearAlgebra
# using LinearSolve

# A = Matrix{Float64}([
#     9 3 4 1 0 2 5;
#     1 0 0 4 5 9 1;
#     12 0 4 1 2 0 0;
#     1 4 2 1 9 2 1;
#     0 0 5 2 2 8 4;
# ])

# A = Matrix{Float64}([
#     2 1 3;
#     0 1 2;
#     2 2 5
# ])

A = Matrix{Float64}([
    1 -1 3;
    3 1 1
])

function construct_SVD(A::Matrix)
    m, n = size(A)

    eigU = eigen(A * transpose(A))
    eigV = eigen(transpose(A) * A)

    singular_values = sqrt.(eigU.values)
    singular_values = singular_values[sortperm(singular_values, rev=true)]
     
    lambda_V = eigV.values
    sorted_indices_V = sortperm(lambda_V, rev=true)

    V = eigV.vectors[:, sorted_indices_V] 

    # V = eigV.vectors
    U = zeros(m, m)
    non_zero_count = count(x -> x != 0, singular_values)

    for i in 1:non_zero_count
        U[:, i] = A*V[:, i] / singular_values[i]
    end
    
    S = zeros(m, n)
    for i in 1:min(m, n)
        S[i, i] = singular_values[i]
    end

    return U, S, V
end


# function construct_SVD(A::Matrix)
#     m, n = size(A)

#     U = eigvecs(A * transpose(A))
#     V = eigvecs(transpose(A) * A)
#     s = sqrt.(eigvals(A * transpose(A)))

#     U[:, :] = U[:, end:-1:1]
#     V[:, :] = V[:, end:-1:1]
#     s = s[end:-1:1]

#     s = convert(Matrix, Diagonal(s))
#     n_s = size(s, 2)

#     S = zeros(m, n)
#     S[1:n_s, 1:n_s] = s

#     return U, S, V
# end



U, S, V = construct_SVD(A)

# display(U)
# display(S)
# display(V)
# println()


display(U * S * transpose(V))
F = svd(A)
# display(F.V)

# display(U * S * transpose(V))


# display(sqrt.(eigen(A * transpose(A)).values))
# display(sqrt.(eigen(transpose(A) * A).values))