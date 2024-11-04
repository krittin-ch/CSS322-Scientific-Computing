# Givens Rotations

#=
    Givens Rotations

        Householder transformations introduce many zeros in a column at once. But all zeros to the right of the current column become nonzero afterwards.
        Therefore, if the entries of A below the main diagonal already have many zeros, it is better to use Givens Rotations, which introduce zeros one at a time.

        G = [c s 
             -s c]

        G * G^T = [1 0; 0 1] = I

        Given a 2-vector a = [a_1 a_2]^T, we want to choose c and s so hat 
            Ga =    [c s; -s c] * [a_1; a_2]        = [α; 0]
                    [a_1 a_2; a_2 -a_1] * [c; s]    = [α; 0]
        
            With GE, 
                s = α*a_2 / (a_1^2 + a_2^2)
                c = α*a_1 / (a_1^2 + a_2^2)

            That is, α = √(a_1^2 + a_2^2)

        Note: Computing a_1^2 and a_2^2 can cause unnecessary overflow or underflow.
        If |a_1| > |a_2|, we can avoid the overflow/underflow problem by working with t = tan(θ) instead.

        That is, t = s/c = a_2/a_1
        and c = 1/√(1 + t^2), s = ct

        Similarly, if |a_2| > |a_1|, we can avoid the overflow/underflow by instead working with the cotangent.

        That is, τ = c/s = a_1/a_2 
        and s = 1/√(1 + τ^2), c = sτ
=#

using LinearAlgebra

a = Vector{Float64}([4; 3])

function create_2D_trig(a::Vector)
    mag = sqrt(sum(a.^2))

    c = a[1]/mag
    s = a[2]/mag
    
    return c, s
end

function construct_nD_rot(c::Float64, s::Float64, s_dim, n_dim)
    mat = Matrix{Float64}(I, n_dim, n_dim)

    mat[1, 1] = c
    mat[1, s_dim] = s
    mat[s_dim, 1] = -s
    mat[s_dim, s_dim] = c

    return mat
end

function givens_rotation(A::Matrix, b::Vector)
    m, n = size(A)
    i = m 

    while i != 1
        if abs(A[i, 1]) != 0
            c, s = create_2D_trig([A[1, 1], A[i, 1]])
            mat = construct_nD_rot(c, s, i, m)

            A = mat * A
            b = mat * b
        end

        i -= 1
    end

    return A, b
end


function QR_factorization(A, b)
    m, n = size(A)

    A, b = givens_rotation(A, b)

    if m >= 2 && n >=2 
        A[2:end, 2:end], b[2:end] = QR_factorization(A[2:end, 2:end], b[2:end])
    end


    return A, b
end

function obtain_R_and_c(A, b)
    m, n = size(A)
    
    A, b = QR_factorization(A, b)

    R = A[1:n, 1:n]
    c = b[1:n]

    return R, c
end

A = Matrix{Float64}([
    1 0 0;
    0 1 0;
    0 0 1;
    -1 1 0;
    -1 0 1;
    0 -1 1;
])

b = Vector{Float64}([1237; 1941; 2417; 711; 1177; 475])

R, c = obtain_R_and_c(A, b)

println("Matrix R:")
display(R)

println("Vector c (Rx = c):")
display(c)