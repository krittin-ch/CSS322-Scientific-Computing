# Rank-One Modification

#=
    In linear algebra, the rank of a matrix A is the dimension of the vector space generated (or spanned) by its columns.
    The column rank of A is the dimension of the column space of A, while the row rank of A is the dimension of the row space of A.

    For example,

        A = [
             1  2  1
            -2 -3  1
             3  5  0
        ]

        After Gaussian Elimination,

        A = [
            1 0 5
            0 1 3
            0 0 0
        ]

        The rank of matrix A is 2

    Rank-one matrix example,

        A = [
            1 2 3
            0 0 0
            0 0 0
        ]

        which can be expressed as A = u * transpose(v)

        if u = [u_1; u_2; u_3; . . .; u_n] and v = [v_1; v_2; v_3; . . .; v_n]

        then    A = [
                    u_1*v_1     u_1*v_2     u_1*v_3     . . .   u_1*v_n
                    u_2*v_1     u_2*v_2     u_2*v_3     . . .   u_3*v_n
                    u_3*v_1     u_3*v_2     u_3*v_3     . . .   u_3*v_n
                       .           .           .                   .
                       .           .           .          .        .
                       .           .           .                   .
                    u_n*v_1     u_n*v_2     u_n*v_3     . . .   u_n*v_n
                ]

        which can be minimized using GE as follows

        A = [
            u_1*v_1     u_1*v_2     u_1*v_3     . . .   u_1*v_n
               0           0           0        . . .      0
               0           0           0        . . .      0
               .           .           .                   .
               .           .           .          .        .
               .           .           .                   .
               0           0           0        . . .      0
        ]

        Hence, A = u * transpose(v) is a rank-one matrix
=#


u = Vector{Int32}([1; 2; 3; 4])
v = Vector{Int32}([-1; -4; 2; 1])

A = u * transpose(v)

print("A = u * transpose(v) :")
display(A)

function Gaussian_elimination(A::Matrix) 
    n = size(A, 1)
    res = convert(Matrix{Float64}, deepcopy(A))

    i = 1   # one loop is enough to test the validity
    for j in i+1:n
        factor = res[j, i] / res[i, i]
        res[j, :] -= factor*res[i, :]
    end

    return res
end

rank_one_A = Gaussian_elimination(A)

print("Rank-One Matrix of A (After Gaussian Elimination) : ")
display(rank_one_A)