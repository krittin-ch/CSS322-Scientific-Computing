#=
    Permutation Matrix :
        if v = [2 4 3 1] then I_n(v, :) is

            P = I_n(v, :) = [
                0 1 0 0
                0 0 0 1
                0 0 1 0
                1 0 0 0
            ]

        Since the matrix multiplication of the transpose of the permutation matrix 
        and the permutation matrix result as the identity matrix

            I_n * transpose(I_n) = I

            I = [
                1 0 0 0
                0 1 0 0
                0 0 1 0
                0 0 0 1
            ]

            Hence, I_n = inv(transpose(I_n))

        Therefore, the below eqaution can be infered

            y = Px              --> y = x(v) ; vector `x` is permutated as matrix `P`
            y = transpose(P)x   --> y(v) = x ; vector `y` is permutated as matrix `P`

        
        For non-square matrix with dimension m x n

        Matrix A (m, n) if P = I(v, :) and Q = I(w, :) then P*A*transpose(Q) = A(v, w)
        This also follows that P*Q = I(w(v), :)

            If A = [
                a_11 a_12 a_13 a_14
                a_21 a_22 a_23 a_24
                a_31 a_32 a_33 a_34
            ]

            and v = [2 3 1] and w = [4 2 1 3]

            new_A = A(v, w) = [
                a_24 a_24 a_21 a_23
                a_34 a_34 a_31 a_33
                a_14 a_14 a_11 a_13
            ]
=#

function createPermutationMatrix(vec::Vector{Int})
    vec_size = size(vec, 1)
    mat = zeros(vec_size, vec_size)

    j = 1
    for i in vec
        mat[j, i] = 1
        j += 1
    end

    return mat
end

v1 = Vector([2; 4; 3; 1])

I_n = createPermutationMatrix(v1)

I_nT = transpose(I_n)

# check inverse of permutation
# display(I_n*I_nT)

A = Matrix([
    1 2 3 4;
    5 6 7 8;
    9 10 11 12
])

v_p = Vector([2; 3; 1])
v_q = Vector([4; 2; 1; 3])

P = createPermutationMatrix(v_p)
Q = createPermutationMatrix(v_q)

new_A = P*A*transpose(Q)

display(A)
display(new_A)

display(P*Q)